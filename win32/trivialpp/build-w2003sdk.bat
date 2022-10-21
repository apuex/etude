cmake -G "NMake Makefiles" ^
 -DCMAKE_CXX_FLAGS_DEBUG="/MT /EHsc" ^
 -DCMAKE_CXX_FLAGS_RELEASE="/MT /EHsc /O2 /DNDEBUG" ^
 -DCMAKE_EXE_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_MODULE_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_STATIC_LINKER_FLAGS="/machine:amd64" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_INSTALL_PREFIX=C:\usr ^
 ..

