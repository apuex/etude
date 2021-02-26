cmake.exe ^
  -DBoost_DIR=D:\usr\lib\cmake\Boost-1.75.0 ^
  -DBoost_INCLUDE_DIR=D:\usr\include ^
  -DBoost_LIBRARY_DIRS=D:\usr\lib ^
  -Dnanodbc_DIR=D:\usr\cmake ^
  -S . ^
  -B dist ^
  -G "NMake Makefiles"

cmake.exe ^
  -DBoost_DIR=D:\usr\lib\cmake\Boost-1.75.0 ^
  -DBoost_INCLUDE_DIR=D:\usr\include ^
  -DBoost_LIBRARY_DIRS=D:\usr\lib ^
  -Dnanodbc_DIR=D:\usr\cmake ^
  -S . ^
  -B vs ^
  -G "Visual Studio 16 2019"

