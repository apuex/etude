CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(serialize)

EXECUTE_PROCESS( COMMAND uname -s COMMAND tr -d '\n' OUTPUT_VARIABLE OSNAME )
EXECUTE_PROCESS( COMMAND uname -m COMMAND tr -d '\n' OUTPUT_VARIABLE OSARCH )

SET(CMAKE_CXX_STANDARD 14)

if(MSVC)
  SET(CMAKE_CXX_FLAGS "/bigobj /EHsc")
else()
if(${OSNAME} MATCHES "CYGWIN*")
    MESSAGE(STATUS, "${OSNAME} ${OSARCH}")
    SET(CMAKE_CXX_FLAGS "-Wall -fPIC -Wa,-mbig-obj")
  elseif(${OSNAME} MATCHES "Linux")
    SET(CMAKE_CXX_FLAGS "-Wall")
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
)

SET(PERSON_SRCS 
  include/Person.h
  person/Person.cpp
  person/main.cpp
)

SET(LOCATION_SRCS 
  include/Location.h
  location/Location.cpp
  location/main.cpp
)

SET(CSTRING_SRCS 
  cstring/main.cpp
)

ADD_EXECUTABLE(person ${PERSON_SRCS})
ADD_EXECUTABLE(location ${LOCATION_SRCS})
ADD_EXECUTABLE(cstring ${CSTRING_SRCS})

INSTALL(TARGETS person location cstring
    CONFIGURATIONS Release
    RUNTIME DESTINATION bin PERMISSIONS WORLD_EXECUTE
    LIBRARY DESTINATION lib PERMISSIONS WORLD_EXECUTE
    ARCHIVE DESTINATION lib)
INSTALL(TARGETS person location cstring
    CONFIGURATIONS Debug
    RUNTIME DESTINATION bin PERMISSIONS WORLD_EXECUTE
    LIBRARY DESTINATION lib PERMISSIONS WORLD_EXECUTE
    ARCHIVE DESTINATION lib)
INSTALL(FILES include/Person.h include/Location.h DESTINATION include
    CONFIGURATIONS Release)

ADD_DEFINITIONS(-D_AFXDLL)
ADD_DEFINITIONS(-D_WIN32_WINNT=_WIN32_WINNT_WIN10)
ADD_DEFINITIONS(-D_WINDLL)
# ADD_DEFINITIONS(-D_UNICODE)
# TARGET_COMPILE_DEFINITIONS(serialize PRIVATE REALDATAAPI_EXPORT)

