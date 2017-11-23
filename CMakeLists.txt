project(gsl)

cmake_minimum_required(VERSION 3.0.2)

include(CheckLibraryExists)
include(CheckCSourceCompiles)
include(CheckSymbolExists)
include(CheckIncludeFiles)

set(SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR})

# load platform specific settings
set(GSLBLAS_C_FLAGS)
set(GSL_C_FLAGS)
if (CMAKE_SYSTEM_NAME STREQUAL Windows)
    include(cmake/platform/windows.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL Linux)
    include(cmake/platform/linux.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL Darwin)
    include(cmake/platform/macos.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL iOS)
    include(cmake/platform/ios.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL Android)
    include(cmake/platform/android.cmake)
else ()
    # more to be added
    message(FATAL_ERROR "unsupported os: ${CMAKE_SYSTEM_NAME}")
endif ()

# building gsl need put all header files under a gsl directory
file(MAKE_DIRECTORY ${BUILD_DIR}/gsl)
file(GLOB_RECURSE GSL_HEADER ${SOURCE_DIR}/gsl "gsl*.h")
file(COPY ${GSL_HEADER} DESTINATION ${BUILD_DIR}/gsl)
file(COPY ${SOURCE_DIR}/gsl/build.h DESTINATION ${BUILD_DIR})
file(COPY ${SOURCE_DIR}/gsl/templates_on.h DESTINATION ${BUILD_DIR})
file(COPY ${SOURCE_DIR}/gsl/templates_off.h DESTINATION ${BUILD_DIR})

# config gsl
include(${SOURCE_DIR}/cmake/util.cmake)
include(${SOURCE_DIR}/cmake/config.cmake)
configure_file(${SOURCE_DIR}/cmake/config.h.in ${BUILD_DIR}/gsl/config.h @ONLY)

# building all
set(CBLAS_SRC)
set(GSL_SRC)
include(${SOURCE_DIR}/cmake/dir.cmake)

if (GSL_HAVE_LIBM)
    set(GSL_DEP m)
endif ()

# gsl cblas
add_library(gslcblas ${CBLAS_SRC})
target_include_directories(gslcblas PRIVATE ${BUILD_DIR})
target_include_directories(gslcblas PRIVATE ${BUILD_DIR}/gsl) # config.h
target_compile_definitions(gslcblas PRIVATE -DHAVE_CONFIG_H)
target_link_libraries(gslcblas ${GSL_DEP})

if (GSLBLAS_C_FLAGS)
    target_compile_options(gslcblas PRIVATE ${GSLBLAS_C_FLAGS})
endif ()

# gsl
add_library(gsl ${GSL_SRC})
target_include_directories(gsl PRIVATE ${BUILD_DIR})
target_include_directories(gsl PRIVATE ${BUILD_DIR}/gsl) # config.h
target_compile_definitions(gsl PRIVATE -DHAVE_CONFIG_H)
target_link_libraries(gsl gslcblas)

if (GSL_C_FLAGS)
    target_compile_options(gsl PRIVATE ${GSL_C_FLAGS})
endif ()

# test
set(GSL_ENABLE_TEST 0 CACHE BOOL "enable test cases")
if (GSL_ENABLE_TEST)
    enable_testing()

    function(add_gsl_test name)
        add_executable(${name} ${ARGN})
        target_link_libraries(${name} gsl)
        target_include_directories(${name} PRIVATE ${BUILD_DIR})
        target_include_directories(${name} PRIVATE ${BUILD_DIR}/gsl) # config.h
        add_test(${name} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${name})
    endfunction()

    include(${SOURCE_DIR}/cmake/test.cmake)
endif ()
