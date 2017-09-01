set_if("
    #include <stdlib.h>
    #include <stdio.h>
    int main (void)
    {
        const char * s = \"5678.25\"; long double x = 1.234 ;
        fprintf(stderr,\"%Lg\n\",x) ;
        sscanf(s, \"%Lg\", &x);
        if (x == 5678.25) {exit (0);} else {exit(1); }
    }"
	m
    0
    GSL_HAVE_PRINTF_LONGDOUBLE)
