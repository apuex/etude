module RSyslog.CmdLine where

import           Data.Char
import           System.Console.GetOpt
import           System.Environment.FindBin
import           System.FilePath
import           System.IO
import           System.Exit
import           Text.Printf


data Options = Options
    { logDir    :: String
    , baseFile  :: String
    , host      :: String
    , port      :: String
    , console   :: Bool
    , printHelp :: Bool
    } deriving Show

defaultOptions :: Options
defaultOptions = Options
    { logDir    = "."
    , baseFile  = "rsyslog"
    , host      = "0.0.0.0"
    , port      = "514"
    , console   = False
    , printHelp = False
    }

options :: [OptDescr (Options -> Options)]
options =
    [ Option ['d'] ["log-dir"]   (ReqArg (\ o opts -> opts { logDir    = o       }) "DIR"  ) "directory for log files"
    , Option ['d'] ["base-file"] (ReqArg (\ o opts -> opts { baseFile  = o       }) "FILE" ) "base file name. date and '.log' extension appended."
    , Option ['H'] ["host"]      (ReqArg (\ o opts -> opts { host      = o       }) "NAME/IP ADDR" ) "log server bind host name/address"
    , Option ['p'] ["port"]      (ReqArg (\ o opts -> opts { port      = o       }) "PORT NAME/NUMBER" ) "log server bind port/service name."
    , Option ['c'] ["console"]   (NoArg  (\   opts -> opts { console   = True    })        ) "log output to console"
    , Option ['h'] ["help"]      (NoArg  (\   opts -> opts { printHelp = True    })        ) "print this help message"]

compileOpts :: PrintfArg t => t -> [String] -> IO (Options, [String])
compileOpts progName argv = case getOpt Permute options argv of
    (o,n,[]  ) -> do
        progPath <- getProgPath
        let opts = foldl (flip id) (defaultOptions { logDir = progPath }) o
        if printHelp opts
            then do hPutStr stderr (usageInfo (header progName) options)
                    exitSuccess
            else return (opts, n)
    (_,_,errs) -> ioError (userError (concat errs ++ usageInfo (header progName) options))

header :: PrintfArg t => t -> String
header = printf "Usage: %s [OPTION...]"

