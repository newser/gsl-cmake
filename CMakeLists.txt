project(gsl)

cmake_minimum_required(VERSION 3.0.2)

set(SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR})

include(CheckLibraryExists)
include(${SOURCE_DIR}/cmake/util.cmake)
include(${SOURCE_DIR}/cmake/config.cmake)

configure_file(${SOURCE_DIR}/cmake/config.h.in ${BUILD_DIR}/config.h @ONLY)

file(MAKE_DIRECTORY ${BUILD_DIR}/gsl)
file(GLOB_RECURSE GSL_HEADER ${SOURCE_DIR}/gsl "gsl*.h")
file(COPY ${GSL_HEADER} DESTINATION ${BUILD_DIR}/gsl)

check_library_exists(m cos "" HAVE_LIBM)
if (GSL_HAVE_LIBM)
  set(GSL_DEP m)
endif ()

# gls cblas
add_group(${SOURCE_DIR}/gsl/cblas cblas CBLAS_SRC)
list(REMOVE_ITEM CBLAS_SRC ${SOURCE_DIR}/gsl/cblas/tests.c)
add_library(gslcblas ${CBLAS_SRC})
target_include_directories(gslcblas PRIVATE ${BUILD_DIR})
target_link_libraries(gslcblas ${GSL_DEP})