set_if("
    #include <math.h>
    int main (void)
    {
         int i, status;
         volatile double z = 1e-308;
         for (i = 0; i < 5; i++) { z = z / 10.0 ; };
         for (i = 0; i < 5; i++) { z = z * 10.0 ; };
         status = (z == 0.0);
         exit (status);
    }"
	m
    0
    GSL_HAVE_IEEE_DENORMALS)
