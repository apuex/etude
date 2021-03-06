module Main(main) where

import qualified RSyslog.CmdLine       as CL
import           RSyslog.UDPServer
import           System.Environment
import           System.FilePath
import           System.IO
import           Control.Concurrent      (forkIO)
import           Control.Monad.Trans     (liftIO)
import           Control.Concurrent.MVar
import           Network.Socket
import           Text.Printf
import           System.Environment
import           System.Exit
import           System.Win32.Services
import           System.Win32.Types
import qualified System.Win32.Error as E


main :: IO ()
main = do
    progName <- getProgName
    args     <- getArgs
    (opts, files) <- CL.compileOpts progName args

    if CL.console opts then do
        createServer opts >>= startServe opts
    else do
        gState <- newMVar (1, ServiceStatus Win32OwnProcess
                              StartPending [] E.Success 0 0 3000)
        mStop <- newEmptyMVar
        startServiceCtrlDispatcher "RSyslogd" 3000 (svcCtrlHandler mStop gState) $ svcMain opts mStop gState

svcMain opts mStop gState _ _ h = do
    reportSvcStatus h Running E.Success 0 gState

    state <- createServer opts
    forkIO $ startServe opts state

    takeMVar mStop

    modifyMVar_ (terminate state) $ \ _ -> return True
    sock <- readMVar (svrSock state)
    close sock

    reportSvcStatus h Stopped E.Success 0 gState
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

