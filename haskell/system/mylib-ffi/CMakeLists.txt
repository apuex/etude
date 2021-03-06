CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(mylib)

EXECUTE_PROCESS( COMMAND uname -s COMMAND tr -d '\n' OUTPUT_VARIABLE OSNAME )
EXECUTE_PROCESS( COMMAND uname -m COMMAND tr -d '\n' OUTPUT_VARIABLE OSARCH )

SET(CMAKE_CXX_STANDARD 14)
SET(CMAKE_LEGACY_CYGWIN_WIN32 0)

if(MSVC)
  SET(CMAKE_CXX_FLAGS "/bigobj /EHsc /O2")
  #MESSAGE(STATUS, "Using Visual Studio")
else()
if(${OSNAME} MATCHES "CYGWIN*")
    MESSAGE(STATUS, "${OSNAME} ${OSARCH}")
    SET(CMAKE_CXX_FLAGS "-O2 -Wall -fPIC -Wa,-mbig-obj")
  elseif(${OSNAME} MATCHES "Linux")
    SET(CMAKE_CXX_FLAGS "-O2 -Wall")
  elseif(${OSNAME} MATCHES "WIN32")
  endif()
endif()

INCLUDE_DIRECTORIES(include 
  ${INCLUDE_DIRECTORIES}
)

LINK_DIRECTORIES(
  ${LINK_DIRECTORIES} 
  ${LIBRARY_OUTPUT_PATH}
)

INCLUDE_DIRECTORIES(
  include
  cbits
)

SET(MYAPP_SRCS cbits/myapp.c)
SET(MYLIB_SRCS 
  include/mylib.h
  cbits/mylib.c
)

ADD_EXECUTABLE(myapp ${MYAPP_SRCS})
ADD_LIBRARY(mylib SHARED ${MYLIB_SRCS})

INSTALL(TARGETS myapp mylib
    CONFIGURATIONS Release
    RUNTIME DESTINATION bin PERMISSIONS WORLD_EXECUTE
    LIBRARY DESTINATION lib PERMISSIONS WORLD_EXECUTE
    ARCHIVE DESTINATION lib)
INSTALL(FILES include/mylib.h DESTINATION include
    CONFIGURATIONS Release)

if(MSVC)
  TARGET_COMPILE_DEFINITIONS(mylib PRIVATE _WINDLL)
  TARGET_COMPILE_DEFINITIONS(mylib PRIVATE MYLIBAPI_EXPORT)
  TARGET_LINK_LIBRARIES(myapp mylib)
else()
  TARGET_LINK_LIBRARIES(mylib m pthread)
  TARGET_LINK_LIBRARIES(myapp mylib m pthread)
endif()

