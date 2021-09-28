                includelib    kernel32.lib
GetStdHandle    proto                       ; Function to retrieve I/O handle
WriteConsoleA   proto                       ; Function to write to console
helloc          proto                       ; C Function to write to console
ExitProcess     proto                       ; Function to exit process
Console         equ     -11                 ; Device code for console output.

                .code
main            proc
                sub     RSP, 40             ; Reserve "shadow space" on stack
                
                ; Obtain "handle" for console display monitor I/O streams
                mov     RCX, Console
                call    GetStdHandle
                mov     stdout, RAX

                ; Display the "Hello, World!" message
                mov     RCX, stdout
                lea     RDX, msg
                mov     R8, lengthof msg
                lea     R9, nbwr
                call    WriteConsoleA
                
                mov     RCX, stdout
                call    helloc
                add     RSP, 40             ; Replace "shadow space" on stack        
                mov     RCX, 0
                call    ExitProcess
main            endp

                .data                    
msg             byte    "Hello, World!"     ;
stdout          qword   ?                   ; Handle to standard output device
nbwr            qword   ?                   ; Number of bytes actually written

                end
                                    
