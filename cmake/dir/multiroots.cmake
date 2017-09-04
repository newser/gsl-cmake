# multiroots sources
source_group(multiroots FILES gsl/multiroots/fdjac.c gsl/multiroots/fsolver.c gsl/multiroots/fdfsolver.c gsl/multiroots/convergence.c gsl/multiroots/newton.c gsl/multiroots/gnewton.c gsl/multiroots/dnewton.c gsl/multiroots/broyden.c gsl/multiroots/hybrid.c gsl/multiroots/hybridj.c)
list(APPEND GSL_SRC gsl/multiroots/fdjac.c gsl/multiroots/fsolver.c gsl/multiroots/fdfsolver.c gsl/multiroots/convergence.c gsl/multiroots/newton.c gsl/multiroots/gnewton.c gsl/multiroots/dnewton.c gsl/multiroots/broyden.c gsl/multiroots/hybrid.c gsl/multiroots/hybridj.c)

