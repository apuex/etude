chcp 65001

mkdir "%APPDATA%\local\bin\"
copy rsyslog-udp.exe "%APPDATA%\local\bin\"

REM create service with directory specified for log files
REM for more command line options, type `rsyslog-udp.exe -h`

sc create "RSyslogd" binPath="%APPDATA%\local\bin\rsyslog-udp.exe --log-dir=D:\RSyslog"
sc config "RSyslogd" start=auto
sc config "RSyslogd" DisplayName="RSyslog Server"
sc description "RSyslogd" "为应用程序提供远程日志服务。"

sc start "RSyslogd"
