cmake_minimum_required(VERSION 2.8...3.20)

project(clock_port C)

#ADD_DEFINITIONS(-DWINVER=0x0502)
#ADD_DEFINITIONS(-D_WIN32_WINNT=0x0502)
ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS)
ADD_DEFINITIONS(-D_UNICODE)
ADD_DEFINITIONS(-DUNICODE)
ADD_DEFINITIONS(-DNDEBUG)

if(MSVC)
  SET(CMAKE_C_FLAGS "/MT /GS- /O2")
else()
endif()

include_directories(
  include
  ${INCLUDE_DIRECTORIES}
  ${CMAKE_INSTALL_PREFIX}/include
)

link_directories(
  ${LINK_DIRECTORIES}
  ${CMAKE_INSTALL_PREFIX}/lib
)

set(CLOCK_SRCS
  src/clock.c
  src/clock.erl
  src/clock.rc
  src/resource.h
  src/version.h
  )

add_executable(clock WIN32 ${CLOCK_SRCS})
target_link_libraries(clock bufferoverflowu)

install(TARGETS
  clock
  CONFIGURATIONS Release
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  )

install(TARGETS
  clock
  CONFIGURATIONS Debug
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib)


