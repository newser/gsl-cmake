# multimin sources
source_group(multimin FILES gsl/multimin/fdfminimizer.c gsl/multimin/steepest_descent.c gsl/multimin/conjugate_fr.c gsl/multimin/conjugate_pr.c gsl/multimin/convergence.c gsl/multimin/diff.c gsl/multimin/vector_bfgs.c gsl/multimin/vector_bfgs2.c gsl/multimin/fminimizer.c gsl/multimin/simplex.c gsl/multimin/simplex2.c)
list(APPEND GSL_SRC gsl/multimin/fdfminimizer.c gsl/multimin/steepest_descent.c gsl/multimin/conjugate_fr.c gsl/multimin/conjugate_pr.c gsl/multimin/convergence.c gsl/multimin/diff.c gsl/multimin/vector_bfgs.c gsl/multimin/vector_bfgs2.c gsl/multimin/fminimizer.c gsl/multimin/simplex.c gsl/multimin/simplex2.c)

