set_if("
    #include <math.h>
    int main (void)
    {
         int status; double inf, nan;
         inf = exp(1.0e10);
         nan = inf / inf ;
         status = (nan == nan);
         exit (status);
    }"
	m
    0
    GSL_HAVE_IEEE_COMPARISONS)
