cmake -G "NMake Makefiles" ^
 -DCMAKE_C_FLAGS="/MD /D_WIN32_WINNT=0x0502" ^
 -DCMAKE_C_FLAGS_RELEASE="/O2 /DNDEBUG" ^
 -DCMAKE_EXE_LINKER_FLAGS="/machine:amd64 /subsystem:windows,5.02 /version:5.2" ^
 -DCMAKE_MODULE_LINKER_FLAGS="/machine:amd64 /subsystem:windows,5.02" ^
 -DCMAKE_STATIC_LINKER_FLAGS="/machine:amd64 /subsystem:windows,5.02" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_INSTALL_PREFIX=C:\usr ^
 ..

