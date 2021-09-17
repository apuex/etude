CMAKE_MINIMUM_REQUIRED(VERSION 2.8...3.20)
PROJECT(enum-perfctrs C)

INCLUDE(CTest)
ENABLE_TESTING()

if(MSVC)
  SET(CMAKE_CXX_FLAGS "/MT /EHsc")
  ADD_DEFINITIONS(-D_WIN32_WINNT=_WIN32_WINNT_WS08)
  ADD_DEFINITIONS(-D_UNICODE)
  ADD_DEFINITIONS(-DUNICODE)
  ADD_DEFINITIONS(-D_WINDLL)
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

INCLUDE_DIRECTORIES(
  include
)

#cmake_policy(SET CMP0057 NEW)
#cmake_policy(SET CMP0065 NEW)

find_package(Threads REQUIRED)

SET(SYNC_FMT_MSG_SRCS
  src/format-message.c
  src/perfctrs-enum-object-items.c
  src/perfctrs-enum-objects.c
  src/perfctrs-enum-objects.h
)

ADD_EXECUTABLE(format-message ${SYNC_FMT_MSG_SRCS})
target_link_libraries(format-message pdh)
set_property(TARGET format-message PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

SET(SYNC_ENUM_PERF_CTRS_SRCS
  src/perfctrs-enum-object-items.c
  src/perfctrs-enum-objects.c
  src/perfctrs-enum-objects.h
  src/perfctrs.c
)

ADD_EXECUTABLE(enum-perfctrs ${SYNC_ENUM_PERF_CTRS_SRCS})
target_link_libraries(enum-perfctrs pdh)
set_property(TARGET enum-perfctrs PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

INSTALL(TARGETS
  enum-perfctrs
  CONFIGURATIONS Release
  EXPORT synchronized
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  )

INSTALL(TARGETS
  enum-perfctrs
  CONFIGURATIONS Debug
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib)

INSTALL(FILES 
  src/perfctrs-enum-objects.h
  DESTINATION include
  CONFIGURATIONS Release)
    
