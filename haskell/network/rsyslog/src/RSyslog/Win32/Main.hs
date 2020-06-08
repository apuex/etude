module Main(main) where

import           RSyslog.CmdLine
import           RSyslog.UDPServer
import           System.Directory
import           System.Environment
import           System.FilePath
import           System.IO
import           Control.Concurrent      (forkIO)
import           Control.Monad.Trans     (liftIO)
import           Control.Concurrent.MVar
import           Text.Printf
import           System.Environment
import           System.Exit
import           System.Log.Logger
import           System.Log.Handler.Syslog
import           System.Win32.Services
import           System.Win32.Types
import qualified System.Win32.Error as E


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- compileOpts progName args
    createDirectoryIfMissing True $ logDir opts
    if console opts then startServe opts "514"
    else do
        gState <- newMVar (1, ServiceStatus Win32OwnProcess
                              StartPending [] E.Success 0 0 3000)
        mStop <- newEmptyMVar
        startServiceCtrlDispatcher "RSyslogd" 3000 (svcCtrlHandler mStop gState) $ svcMain opts mStop gState

svcMain opts mStop gState _ _ h = do
    reportSvcStatus h Running E.Success 0 gState

    run <- newMVar True
    forkIO $ startServe opts

    syslog <- openlog_remote Socket.AF_INET (host opts) (read (port opts) :: Socket.PortNumber) "RSyslogd" [PID] USER DEBUG
    updateGlobalLogger rootLoggerName (setHandlers [syslog])
    updateGlobalLogger rootLoggerName (setLevel DEBUG)
    infoM "ServiceMain" "Logger initialized to R Syslog."

    infoM "ServiceMain" $ "Server started. Wating for service stop signal.."
    takeMVar mStop
    
    modifyMVar_ run $ \ _ -> return False
    infoM "ServiceMain" $ "Terminate signal sent, report service status to be stopped."
    reportSvcStatus h Stopped E.Success 0 gState
    infoM "ServiceMain" $ "all cleaning job done, terminated."
    exitSuccess

reportSvcStatus :: HANDLE -> ServiceState -> E.ErrCode -> DWORD
    -> MVar (DWORD, ServiceStatus) -> IO ()
reportSvcStatus hStatus state win32ExitCode waitHint mState = do
    modifyMVar_ mState $ \(checkPoint, svcStatus) -> do
        let state' = nextState (checkPoint, svcStatus
             { win32ExitCode = win32ExitCode
             , waitHint      = waitHint
             , currentState  = state })
        setServiceStatus hStatus (snd state')
        return state'

nextState :: (DWORD, ServiceStatus) -> (DWORD, ServiceStatus)
nextState (checkPoint, svcStatus) = case (currentState svcStatus) of
    StartPending -> (checkPoint + 1, svcStatus
        { controlsAccepted = [], checkPoint = checkPoint + 1 })
    Running -> (checkPoint, svcStatus
        { controlsAccepted = [AcceptStop], checkPoint = 0 })
    Stopped -> (checkPoint, svcStatus
        { controlsAccepted = [], checkPoint = 0 })
    _ -> (checkPoint + 1, svcStatus
        { controlsAccepted = [], checkPoint = checkPoint + 1 })

svcCtrlHandler :: MVar () -> MVar (DWORD, ServiceStatus)
    -> HandlerFunction
svcCtrlHandler mStop mState hStatus Stop = do
    reportSvcStatus hStatus StopPending E.Success 3000 mState
    putMVar mStop ()
    return True
svcCtrlHandler _ _ _ Interrogate = return True
svcCtrlHandler _ _ _ _  = return False

