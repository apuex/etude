CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(set-example)

option(ENABLE_TESTS "Enable building tests" ON)
option(ENABLE_VALGRIND "Enable the valgrind memory checker for the tests." OFF)

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
  ${DESTDIR}/lib
  ${LINK_DIRECTORIES} 
  ${LIBRARY_OUTPUT_PATH}
)

cmake_policy(SET CMP0057 NEW)
cmake_policy(SET CMP0065 NEW)

if(MSVC)
  ADD_DEFINITIONS(-D_WIN32_WINNT=0x0601)
endif()

if(ENABLE_TESTS)
set(algorithm_unit_tests
  for-each-number-test
  )
if (ENABLE_VALGRIND)
  find_program(MEMORYCHECK_COMMAND valgrind)
  if ("${MEMORYCHECK_COMMAND}" MATCHES "MEMORYCHECK_COMMAND-NOTFOUND")
    message(WARNING "Valgrind couldn't be found.")
    unset(MEMORYCHECK_COMMAND)
  else()
    set(MEMORYCHECK_COMMAND_OPTIONS --trace-children=yes --leak-check=full --error-exitcode=1 --suppressions=${CMAKE_CURRENT_SOURCE_DIR}/valgrind.supp)
  endif()
endif()

foreach(unit_test ${algorithm_unit_tests})
  add_executable("${unit_test}" "tests/${unit_test}.cpp")
  target_link_libraries("${unit_test}" StdDrvLib)
  if(UNIX)
    set_target_properties("${unit_test}" PROPERTIES LINK_FLAGS_RELEASE -s)
  else()
  endif()
  if(MEMORYCHECK_COMMAND)
    add_test(NAME "${unit_test}"
      COMMAND "${MEMORYCHECK_COMMAND}" ${MEMORYCHECK_COMMAND_OPTIONS} "${CMAKE_CURRENT_BINARY_DIR}/${unit_test}")
  else()
    add_test(NAME "${unit_test}"
      COMMAND "./${unit_test}")
  endif()
  INSTALL(TARGETS
    "${unit_test}"
    CONFIGURATIONS Release
    RUNTIME DESTINATION bin
    COMPONENT unittests)
endforeach()
endif(ENABLE_TESTS)

