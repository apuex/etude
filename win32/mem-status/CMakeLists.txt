CMAKE_MINIMUM_REQUIRED(VERSION 2.8...3.20)
PROJECT(mem-status C)

if(MSVC)
  ADD_DEFINITIONS(-D_WIN32_WINNT=0x0502)
  ADD_DEFINITIONS(-D_UNICODE)
  ADD_DEFINITIONS(-DUNICODE)
endif()

INCLUDE_DIRECTORIES(
  app
  include
  ${CMAKE_INSTALL_PREFIX}/include
  ${INCLUDE_DIRECTORIES}
)

LINK_DIRECTORIES(
  lib
  ${CMAKE_INSTALL_PREFIX}/lib
  ${LINK_DIRECTORIES} 
  ${LIBRARY_OUTPUT_PATH}
)

set(utilities
  disk-space
  mem-status
  process
  sys-info
  timezone
  version 
  volume
)

foreach(utility ${utilities})
  add_executable(${utility} "src/${utility}.c")
  target_link_libraries(${utility} psapi)
endforeach()

INSTALL(TARGETS
  ${utilities} 
  CONFIGURATIONS Release
  EXPORT synchronized
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  )

INSTALL(TARGETS
  ${utilities} 
  CONFIGURATIONS Debug
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib)

