cmake ^
-G "NMake Makefiles" ^
-DCMAKE_BUILD_TYPE=Release ^
-DCMAKE_C_FLAGS="/MT /GS- /O2 /Ob2 /DNDEBUG" ^
-DCMAKE_C_FLAGS_RELEASE="/MT /GS- /O2 /Ob2 /DNDEBUG" ^
-DCMAKE_EXE_LINKER_FLAGS="/machine:AMD64 /subsystem:console,5.02 /version:5.02 /RELEASE" ^
-DCMAKE_INSTALL_PREFIX=E:/usr64 ^
..

