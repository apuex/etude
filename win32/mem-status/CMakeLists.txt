CMAKE_MINIMUM_REQUIRED(VERSION 2.8...3.20)
PROJECT(mem-status C)

if(MSVC)
  SET(CMAKE_CXX_FLAGS "/MT /EHsc")
  ADD_DEFINITIONS(-D_WIN32_WINNT=_WIN32_WINNT_WS08)
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
  mem-status
  sys-info
  timezone
)

foreach(utility ${utilities})
  add_executable(${utility} "src/${utility}.c")
  set_property(TARGET ${utility} PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
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

