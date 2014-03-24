	
#-----------------------------------------------------------------------------
# Git protocole option
#-----------------------------------------------------------------------------
option(Slicer_USE_GIT_PROTOCOL "If behind a firewall turn this off to use http instead." ON)

set(git_protocol "git")
if(NOT Slicer_USE_GIT_PROTOCOL)
  set(git_protocol "http")
endif()

#-----------------------------------------------------------------------------
# Enable and setup External project global properties
#-----------------------------------------------------------------------------
include(ExternalProject)
set(ep_base        "${CMAKE_BINARY_DIR}")

# Compute -G arg for configuring external projects with the same CMake generator:
if(CMAKE_EXTRA_GENERATOR)
  set(gen "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
else()
  set(gen "${CMAKE_GENERATOR}")
endif()

#-----------------------------------------------------------------------------
# OpenCV
#-----------------------------------------------------------------------------

if(NOT OpenCV_DIR)
  include("${CMAKE_CURRENT_SOURCE_DIR}/SuperBuild/External_OpenCV.cmake")
endif()

#-----------------------------------------------------------------------------
# Project dependencies
#-----------------------------------------------------------------------------

set(project ArUco)
set(${project}_DEPENDENCIES 
  OpenCV)

ExternalProject_Add(${project}
  DOWNLOAD_COMMAND ""
  SOURCE_DIR ${CMAKE_SOURCE_DIR}
  BINARY_DIR ${CMAKE_BINARY_DIR}
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DArUco_SUPERBUILD:BOOL=OFF
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DOpenCV_DIR:PATH=${OpenCV_DIR}
  INSTALL_COMMAND ""
  DEPENDS
    ${${project}_DEPENDENCIES}
    ) 
