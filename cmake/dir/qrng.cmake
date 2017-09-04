# qrng sources
source_group(qrng FILES gsl/qrng/gsl_qrng.h gsl/qrng/qrng.c gsl/qrng/niederreiter-2.c gsl/qrng/sobol.c gsl/qrng/halton.c gsl/qrng/reversehalton.c gsl/qrng/inline.c)
list(APPEND GSL_SRC gsl/qrng/gsl_qrng.h gsl/qrng/qrng.c gsl/qrng/niederreiter-2.c gsl/qrng/sobol.c gsl/qrng/halton.c gsl/qrng/reversehalton.c gsl/qrng/inline.c)

