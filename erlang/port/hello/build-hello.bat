cl /DECHO /DWIN32 /DPRINT_TERM ^
hello.c ^
/I "C:\Program Files\erl6.4\lib\erl_interface-3.7.20\include" ^
/link /LIBPATH:"C:\Program Files\erl6.4\lib\erl_interface-3.7.20\lib" ^
ei.lib erl_interface.lib ws2_32.lib

cl /DECHO /DWIN32 /DPRINT_TERM ^
term.c ^
/I "C:\Program Files\erl6.4\lib\erl_interface-3.7.20\include" ^
/link /LIBPATH:"C:\Program Files\erl6.4\lib\erl_interface-3.7.20\lib" ^
ei.lib erl_interface.lib ws2_32.lib

