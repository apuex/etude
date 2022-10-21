cmake -G "NMake Makefiles" ^
 -DCMAKE_C_COMPILER=cl ^
 -DCMAKE_C_FLAGS_DEBUG="/MD /GS-" ^
 -DCMAKE_C_FLAGS_RELEASE="/MD /GS- /O2 /DNDEBUG" ^
 -DCMAKE_EXE_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_MODULE_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_STATIC_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_C_STANDARD_LIBRARIES="kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib bufferoverflowu.lib" ^
 -DCMAKE_CXX_STANDARD_LIBRARIES="kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib bufferoverflowu.lib" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_INSTALL_PREFIX=E:\usr64 ^
 ..

