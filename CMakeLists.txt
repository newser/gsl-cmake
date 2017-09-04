project(gsl)

cmake_minimum_required(VERSION 3.0.2)

include(CheckLibraryExists)
include(CheckCSourceCompiles)
include(CheckSymbolExists)
include(CheckIncludeFiles)

set(SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR})

# load platform specific settings
if (CMAKE_SYSTEM_NAME STREQUAL Windows)
    include(cmake/windows.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL Linux)
    include(cmake/linux.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL Darwin)
    include(cmake/macos.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL iOS)
    include(cmake/ios.cmake)
elseif (CMAKE_SYSTEM_NAME STREQUAL Android)
    include(cmake/android.cmake)
else ()
    # more to be added
    message(FATAL_ERROR "unsupported os: ${CMAKE_SYSTEM_NAME}")
endif ()

# config gsl
include(${SOURCE_DIR}/cmake/util.cmake)
include(${SOURCE_DIR}/cmake/config.cmake)
configure_file(${SOURCE_DIR}/cmake/config.h.in ${BUILD_DIR}/config.h @ONLY)

# building gsl need put all header files under a gsl directory
file(MAKE_DIRECTORY ${BUILD_DIR}/gsl)
file(GLOB_RECURSE GSL_HEADER ${SOURCE_DIR}/gsl "gsl*.h")
file(COPY ${GSL_HEADER} DESTINATION ${BUILD_DIR}/gsl)
file(COPY ${SOURCE_DIR}/gsl/build.h DESTINATION ${BUILD_DIR})
file(COPY ${SOURCE_DIR}/gsl/templates_on.h DESTINATION ${BUILD_DIR})
file(COPY ${SOURCE_DIR}/gsl/templates_off.h DESTINATION ${BUILD_DIR})

if (GSL_HAVE_LIBM)
    set(GSL_DEP m)
endif ()

# gls cblas
add_group(${SOURCE_DIR}/gsl/cblas cblas CBLAS_SRC)
list(REMOVE_ITEM CBLAS_SRC ${SOURCE_DIR}/gsl/cblas/tests.c)

add_library(gslcblas ${CBLAS_SRC})
target_include_directories(gslcblas PRIVATE ${BUILD_DIR})
target_compile_definitions(gslcblas PRIVATE -DHAVE_CONFIG_H)
target_link_libraries(gslcblas ${GSL_DEP})

# gsl
set(GLS_SRC)
# generally sources under util are not necessary
add_group(${SOURCE_DIR}/gsl/sys sys GLS_SRC)
add_group(${SOURCE_DIR}/gsl/test test GLS_SRC)
add_group(${SOURCE_DIR}/gsl/err err GLS_SRC)
add_group(${SOURCE_DIR}/gsl/const const GLS_SRC)
add_group(${SOURCE_DIR}/gsl/complex complex GLS_SRC)
add_group(${SOURCE_DIR}/gsl/cheb cheb GLS_SRC)
add_group(${SOURCE_DIR}/gsl/block block GLS_SRC)
add_group(${SOURCE_DIR}/gsl/vector vector GLS_SRC)
add_group(${SOURCE_DIR}/gsl/matrix matrix GLS_SRC)
add_group(${SOURCE_DIR}/gsl/permutation permutation GLS_SRC)
add_group(${SOURCE_DIR}/gsl/combination combination GLS_SRC)
add_group(${SOURCE_DIR}/gsl/multiset multiset GLS_SRC)
add_group(${SOURCE_DIR}/gsl/sort sort GLS_SRC)
add_group(${SOURCE_DIR}/gsl/ieee-utils ieee-utils GLS_SRC)
add_group(${SOURCE_DIR}/gsl/dht dht GLS_SRC)
add_group(${SOURCE_DIR}/gsl/qrng qrng GLS_SRC)
add_group(${SOURCE_DIR}/gsl/rng rng GLS_SRC)
add_group(${SOURCE_DIR}/gsl/randist randist GLS_SRC)
add_group(${SOURCE_DIR}/gsl/fit fit GLS_SRC)
add_group(${SOURCE_DIR}/gsl/multilarge multilarge GLS_SRC)
add_group(${SOURCE_DIR}/gsl/rstat rstat GLS_SRC)
add_group(${SOURCE_DIR}/gsl/statistics statistics GLS_SRC)
add_group(${SOURCE_DIR}/gsl/siman siman GLS_SRC)
add_group(${SOURCE_DIR}/gsl/sum sum GLS_SRC)
add_group(${SOURCE_DIR}/gsl/interpolation interpolation GLS_SRC)
add_group(${SOURCE_DIR}/gsl/interpolation interpolation GLS_SRC)
add_group(${SOURCE_DIR}/gsl/ode-initval ode-initval GLS_SRC)
add_group(${SOURCE_DIR}/gsl/roots roots GLS_SRC)
add_group(${SOURCE_DIR}/gsl/min min GLS_SRC)
add_group(${SOURCE_DIR}/gsl/monte monte GLS_SRC)
add_group(${SOURCE_DIR}/gsl/ntuple ntuple GLS_SRC)
add_group(${SOURCE_DIR}/gsl/diff diff GLS_SRC)
add_group(${SOURCE_DIR}/gsl/deriv deriv GLS_SRC)
add_group(${SOURCE_DIR}/gsl/wavelet wavelet GLS_SRC)
add_group(${SOURCE_DIR}/gsl/bspline bspline GLS_SRC)
add_group(${SOURCE_DIR}/gsl/spblas spblas GLS_SRC)
add_group(${SOURCE_DIR}/gsl/spmatrix spmatrix GLS_SRC)
add_group(${SOURCE_DIR}/gsl/splinalg splinalg GLS_SRC)

add_group(${SOURCE_DIR}/gsl/eigen eigen GLS_SRC)
list(REMOVE_ITEM GLS_SRC ${SOURCE_DIR}/gsl/eigen/qrstep.c)

add_group(${SOURCE_DIR}/gsl/linalg linalg GLS_SRC)
list(REMOVE_ITEM GLS_SRC 
     ${SOURCE_DIR}/gsl/linalg/apply_givens.c
     ${SOURCE_DIR}/gsl/linalg/cholesky_common.c
     ${SOURCE_DIR}/gsl/linalg/svdstep.c)

add_group(${SOURCE_DIR}/gsl/specfunc specfunc GLS_SRC)
list(REMOVE_ITEM GLS_SRC 
     ${SOURCE_DIR}/gsl/specfunc/cheb_eval_mode.c
     ${SOURCE_DIR}/gsl/specfunc/cheb_eval.c)

add_group(${SOURCE_DIR}/gsl/fft fft GLS_SRC)
file(GLOB_RECURSE F_C ${SOURCE_DIR}/fft "c_*")
file(GLOB_RECURSE F_HC ${SOURCE_DIR}/fft "hc_*")
file(GLOB_RECURSE F_REAL ${SOURCE_DIR}/fft "real_*")
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/fft/bitreverse.c
     ${F_C}
     ${F_HC}
     ${F_REAL})

add_group(${SOURCE_DIR}/gsl/poly poly GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/poly/balance.c
     ${SOURCE_DIR}/gsl/poly/companion.c
     ${SOURCE_DIR}/gsl/poly/qr.c)

add_group(${SOURCE_DIR}/gsl/multifit multifit GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/multifit/lmiterate.c
     ${SOURCE_DIR}/gsl/multifit/lmmisc.c
     ${SOURCE_DIR}/gsl/multifit/lmset.c
     ${SOURCE_DIR}/gsl/multifit/lmpar.c
     ${SOURCE_DIR}/gsl/multifit/lmutil.c
     ${SOURCE_DIR}/gsl/multifit/qrsolv.c)

add_group(${SOURCE_DIR}/gsl/multifit_nlinear multifit_nlinear GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/multifit_nlinear/common.c
     ${SOURCE_DIR}/gsl/multifit_nlinear/qrsolv.c)

add_group(${SOURCE_DIR}/gsl/multilarge_nlinear multilarge_nlinear GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/multilarge_nlinear/common.c)

add_group(${SOURCE_DIR}/gsl/integration integration GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/integration/append.c
     ${SOURCE_DIR}/gsl/integration/initialise.c
     ${SOURCE_DIR}/gsl/integration/positivity.c
     ${SOURCE_DIR}/gsl/integration/ptsort.c
     ${SOURCE_DIR}/gsl/integration/qc25c.c
     ${SOURCE_DIR}/gsl/integration/qc25f.c
     ${SOURCE_DIR}/gsl/integration/qc25s.c
     ${SOURCE_DIR}/gsl/integration/qelg.c
     ${SOURCE_DIR}/gsl/integration/qpsrt.c
     ${SOURCE_DIR}/gsl/integration/qpsrt2.c
     ${SOURCE_DIR}/gsl/integration/reset.c
     ${SOURCE_DIR}/gsl/integration/set_initial.c
     ${SOURCE_DIR}/gsl/integration/util.c)

add_group(${SOURCE_DIR}/gsl/histogram histogram GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/histogram/find.c
     ${SOURCE_DIR}/gsl/histogram/find2d.c)

add_group(${SOURCE_DIR}/gsl/ode-initval2 ode-initval2 GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/ode-initval2/control_utils.c
     ${SOURCE_DIR}/gsl/ode-initval2/rksubs.c
     ${SOURCE_DIR}/gsl/ode-initval2/step_utils.c)

add_group(${SOURCE_DIR}/gsl/multiroots multiroots GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/multiroots/enorm.c
     ${SOURCE_DIR}/gsl/multiroots/dogleg.c)

add_group(${SOURCE_DIR}/gsl/multimin multimin GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/multimin/directional_minimize.c
     ${SOURCE_DIR}/gsl/multimin/linear_wrapper.c)

add_group(${SOURCE_DIR}/gsl/cdf cdf GLS_SRC)
list(REMOVE_ITEM GLS_SRC
     ${SOURCE_DIR}/gsl/cdf/beta_inc.c)

file(GLOB_RECURSE F_SRC ${SOURCE_DIR}/gsl "*_source.*")
file(GLOB_RECURSE F_TEST ${SOURCE_DIR}/gsl "test*")
file(GLOB_RECURSE F_FP ${SOURCE_DIR}/gsl/ieee-utils "fp-*")
list(REMOVE_ITEM GLS_SRC ${F_SRC} ${F_TEST} ${F_FP})

add_library(gsl ${GLS_SRC})
target_include_directories(gsl PRIVATE ${BUILD_DIR})
target_compile_definitions(gsl PRIVATE -DHAVE_CONFIG_H)
target_link_libraries(gsl gslcblas)