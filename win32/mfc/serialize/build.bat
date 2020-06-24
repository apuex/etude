chcp 65001
mkdir dist
cd dist
cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%APPDATA%\local ..
nmake install
cd ..
