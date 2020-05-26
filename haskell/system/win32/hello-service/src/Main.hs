module Main where

import           Control.Concurrent.MVar
import           System.Win32.Services
import           System.Win32.Types
import           Control.Exception    as E
import qualified System.Win32.Error as E
import           System.Log.Logger
import           System.Log.Handler.Syslog
import           GHC.IO.Encoding (getLocaleEncoding)
import           System.IO

main :: IO ()
main = do
    gState <- newMVar (1, ServiceStatus Win32OwnProcess
                          StartPending [] E.Success 0 0 3000)
    mStop <- newEmptyMVar
    startServiceCtrlDispatcher "Test" 3000 (svcCtrlHandler mStop gState) $ svcMain mStop gState

svcMain mStop gState _ _ h = do
    reportSvcStatus h Running E.Success 0 gState
   
    let initLogger = do 
            syslog <- openlog "hello-service" [PID] USER DEBUG
            updateGlobalLogger rootLoggerName (setHandlers [syslog])
            updateGlobalLogger rootLoggerName (setLevel DEBUG)
            infoM "Launcher" "Logger initialized to R Syslog."
            encoding <- getLocaleEncoding
            infoM "Launcher" $ "Locale charactor encoding is: " ++ (show encoding)

    outfile <- openBinaryFile "c:\\hello-service.log" WriteMode
    r <- E.try initLogger :: IO (Either E.SomeException ())
    case r of
        Left  e -> do
            hPutStrLn outfile $ "Launcher main initLogger left: " ++ show e
        Right m -> do
            hPutStrLn outfile $ "Launcher main initLogger right: " ++ show m
    hClose outfile

    takeMVar mStop
    reportSvcStatus h Stopped E.Success 0 gState

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
