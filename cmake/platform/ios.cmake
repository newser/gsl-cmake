# disable warnings by default, we do not want to modify gsl source
set(GSL_ENABLE_WARNING 0 CACHE BOOL "enable compile warnings")
if (NOT GSL_ENABLE_WARNING)
    list(APPEND GSLBLAS_C_FLAGS -w)
    list(APPEND GSL_C_FLAGS -w)
endif ()
