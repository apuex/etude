cmake -G "NMake Makefiles" ^
 -DCMAKE_C_FLAGS_DEBUG="/GS- /MD /O2 /DDEBUG" ^
 -DCMAKE_C_FLAGS_RELEASE="/GS- /MT /O2 /DNDEBUG" ^
 -DCMAKE_EXE_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_MODULE_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_STATIC_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_INSTALL_PREFIX=C:\usr ^
 ..

