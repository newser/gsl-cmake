check_include_files(ieeefp.h GSL_HAVE_IEEEFP_H)

if (GSL_HAVE_IEEEFP_H)
    check_symbol_exists(finite math.h;ieeefp.h GSL_HAVE_DECL_FINITE)
else ()
    check_symbol_exists(finite math.h GSL_HAVE_DECL_FINITE)
endif ()
