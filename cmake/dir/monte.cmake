# monte sources
source_group(monte FILES gsl/monte/miser.c gsl/monte/plain.c gsl/monte/gsl_monte_vegas.h gsl/monte/gsl_monte_miser.h gsl/monte/gsl_monte_plain.h gsl/monte/gsl_monte.h gsl/monte/vegas.c)
list(APPEND GSL_SRC gsl/monte/miser.c gsl/monte/plain.c gsl/monte/gsl_monte_vegas.h gsl/monte/gsl_monte_miser.h gsl/monte/gsl_monte_plain.h gsl/monte/gsl_monte.h gsl/monte/vegas.c)

