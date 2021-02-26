CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(stdint-example)

EXECUTE_PROCESS( COMMAND uname -s COMMAND tr -d '\n' OUTPUT_VARIABLE OSNAME )
EXECUTE_PROCESS( COMMAND uname -m COMMAND tr -d '\n' OUTPUT_VARIABLE OSARCH )

SET(CMAKE_CXX_STANDARD 14)
if(${OSNAME} MATCHES "Darwin")
  SET(CMAKE_CXX_FLAGS "-fPIC -Wall")
elseif(${OSNAME} MATCHES "Linux")
  SET(CMAKE_CXX_FLAGS "-fPIC -Wall")
elseif(${OSNAME} MATCHES "WIN32")
endif()

ENABLE_TESTING()

INCLUDE_DIRECTORIES(
  include
  src
  ${DESTDIR}/include
  ${INCLUDE_DIRECTORIES}
)

LINK_DIRECTORIES(
  lib
  ${DESTDIR}/lib
  ${LINK_DIRECTORIES} 
  ${LIBRARY_OUTPUT_PATH}
)

cmake_policy(SET CMP0057 NEW)
cmake_policy(SET CMP0065 NEW)

set(Boost_USE_STATIC_LIBS        ON) # only find static libs
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)

find_package(Boost 1.75.0 REQUIRED COMPONENTS date_time program_options log unit_test_framework)
if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  link_directories(${Boost_LIBRARY_DIRS})
endif()

SET(STDINT_EXAMPLE_SRCS
  app/stdint-example.c
)
ADD_EXECUTABLE(stdint-example ${STDINT_EXAMPLE_SRCS})

SET(FAIL_TEST_SRCS 
  test/fail-test.cpp
)
ADD_EXECUTABLE(fail-test ${FAIL_TEST_SRCS})
ADD_TEST(NAME fail-test COMMAND fail-test)

if(MSVC)
  ADD_DEFINITIONS(-D_WIN32_WINNT=0x0601)
endif()

