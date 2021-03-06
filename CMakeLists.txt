cmake_minimum_required(VERSION 3.8.0)
project(Unicorn LANGUAGES CXX)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules/")
set(CMAKE_CONTRIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/contrib)

include(FindZLIB)
include(FindIconv)
include(FindThreads)
include(cmake/find_pcre2.cmake)

add_library(Unicorn
    unicorn/character.cpp
    unicorn/environment.cpp
    unicorn/format.cpp
    unicorn/io.cpp
    unicorn/mbcs.cpp
    unicorn/normal.cpp
    unicorn/options.cpp
    unicorn/path.cpp
    unicorn/regex.cpp
    unicorn/segment.cpp
    unicorn/string-algorithm.cpp
    unicorn/string-case.cpp
    unicorn/string-compare.cpp
    unicorn/string-escape.cpp
    unicorn/string-manip.cpp
    unicorn/string-property.cpp
    unicorn/ucd-bidi-tables.cpp
    unicorn/ucd-block-tables.cpp
    unicorn/ucd-case-tables.cpp
    unicorn/ucd-character-names.cpp
    unicorn/ucd-decomposition-tables.cpp
    unicorn/ucd-numeric-tables.cpp
    unicorn/ucd-property-tables.cpp
    unicorn/ucd-script-tables.cpp
    unicorn/utf.cpp)
add_library(RS::Unicorn ALIAS Unicorn)

target_include_directories(Unicorn PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include>)

target_compile_features(Unicorn PUBLIC cxx_std_17)

target_link_libraries(Unicorn
    PRIVATE
        ${PCRE2_LIB}
        ZLIB::ZLIB
        Iconv::Iconv
        Threads::Threads)

if(UNICORN_BUILD_TESTING)
    include(CTest)
    add_executable(unicorn_tests
        unicorn/character-test.cpp
        unicorn/environment-test.cpp
        unicorn/format-test.cpp
        unicorn/io-test.cpp
        unicorn/mbcs-test.cpp
        unicorn/normal-test.cpp
        unicorn/options-test.cpp
        unicorn/path-test.cpp
        unicorn/regex-test.cpp
        unicorn/segment-test.cpp
        unicorn/string-algorithm-test.cpp
        unicorn/string-case-test.cpp
        unicorn/string-compare-test.cpp
        unicorn/string-conversion-test.cpp
        unicorn/string-escape-test.cpp
        unicorn/string-manip-a-e-test.cpp
        unicorn/string-manip-f-m-test.cpp
        unicorn/string-manip-n-r-test.cpp
        unicorn/string-manip-s-z-test.cpp
        unicorn/string-property-test.cpp
        unicorn/string-size-test.cpp
        unicorn/ucd-normalization-test.cpp
        unicorn/ucd-segmentation-test.cpp
        unicorn/unit-test.cpp
        unicorn/utf-test.cpp
        unicorn/utility-test.cpp)
    target_link_libraries(unicorn_tests PRIVATE RS::Unicorn)
    add_test(unicorn_tests unicorn_tests)
endif()
