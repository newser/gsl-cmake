# wavelet sources
source_group(wavelet FILES gsl/wavelet/dwt.c gsl/wavelet/wavelet.c gsl/wavelet/bspline.c gsl/wavelet/daubechies.c gsl/wavelet/haar.c)
list(APPEND GSL_SRC gsl/wavelet/dwt.c gsl/wavelet/wavelet.c gsl/wavelet/bspline.c gsl/wavelet/daubechies.c gsl/wavelet/haar.c)

