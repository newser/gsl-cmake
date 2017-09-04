# err sources
source_group(err FILES gsl/err/error.c gsl/err/stream.c gsl/err/message.c gsl/err/strerror.c)
list(APPEND GSL_SRC gsl/err/error.c gsl/err/stream.c gsl/err/message.c gsl/err/strerror.c)

