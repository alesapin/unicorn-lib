# PCRE2 needs some settings.
SET(PCRE2_BUILD_PCRE2_8 ON CACHE BOOL "Build 8bit PCRE2 library")
SET(PCRE2_SHOW_REPORT OFF CACHE BOOL "Show the final configuration report")
SET(PCRE2_BUILD_PCRE2GREP OFF CACHE BOOL "Build pcre2grep")

SET(PCRE2_MIN_VERSION 10.21)
FIND_LIBRARY(PCRE2_LIB pcre2-8)
FIND_PATH(PCRE2_INCLUDE_DIR pcre2.h)
IF (PCRE2_LIB AND PCRE2_INCLUDE_DIR)
  MESSAGE(STATUS "Found system PCRE2 library ${PCRE2_INCLUDE_DIR}")
ELSE()
  MESSAGE(STATUS "Using bundled PCRE2 library")
  ADD_SUBDIRECTORY(${CMAKE_CONTRIB_DIR}/pcre2-10.32 EXCLUDE_FROM_ALL)
  SET(PCRE2_INCLUDE_DIR ${CMAKE_CONTRIB_DIR}/pcre2-10.32/)
  SET(PCRE2_LIB pcre2-8)
endif(PCRE2_LIB AND PCRE2_INCLUDE_DIR)
INCLUDE_DIRECTORIES(${PCRE2_INCLUDE_DIR})
