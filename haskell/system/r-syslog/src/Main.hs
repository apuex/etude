module Main where

import System.Log.Logger
import System.Log.Handler.Syslog
import System.Log.Handler.Simple
import System.Log.Handler (setFormatter)
import System.Log.Formatter

-- By default, all messages of level WARNING and above are sent to stderr.
-- Everything else is ignored.

-- "MyApp.Component" is an arbitrary string; you can tune
-- logging behavior based on it later.
main = do
       debugM "MyApp.Component"  "This is a debug message -- never to be seen"
       warningM "MyApp.Component2" "Something Bad is about to happen."

       -- Copy everything to syslog from here on out.
       s <- openlog "SyslogStuff" [PID] USER DEBUG
       updateGlobalLogger rootLoggerName (addHandler s)

       errorM "MyApp.Component" "This is going to stderr and syslog."

       -- Now we'd like to see everything from BuggyComponent
       -- at DEBUG or higher go to syslog and stderr.
       -- Also, we'd like to still ignore things less than
       -- WARNING in other areas.
       --
       -- So, we adjust the Logger for MyApp.BuggyComponent.

       updateGlobalLogger "MyApp.BuggyComponent"
                          (setLevel DEBUG)

       -- This message will go to syslog and stderr
       debugM "MyApp.BuggyComponent" "This buggy component is buggy"

       -- This message will go to syslog and stderr too.
       warningM "MyApp.BuggyComponent" "Still Buggy"

       -- This message goes nowhere.
       debugM "MyApp.WorkingComponent" "Hello"

       -- Now we decide we'd also like to log everything from BuggyComponent at DEBUG
       -- or higher to a file for later diagnostics.  We'd also like to customize the
       -- format of the log message, so we use a 'simpleLogFormatter'

       h <- fileHandler "debug.log" DEBUG >>= \lh -> return $
                setFormatter lh (simpleLogFormatter "[$time : $loggername : $prio] $msg")
       updateGlobalLogger "MyApp.BuggyComponent" (addHandler h)

       -- This message will go to syslog and stderr,
       -- and to the file "debug.log" with a format like :
       -- [2010-05-23 16:47:28 : MyApp.BuggyComponent : DEBUG] Some useful diagnostics...
       debugM "MyApp.BuggyComponent" "Some useful diagnostics..."
