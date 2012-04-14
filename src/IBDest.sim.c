#include <R.h>
#include <Rdefines.h>
#include "IBDestp.h"

SEXP IBDest_sim(SEXP x, SEXP x_rows, SEXP x_cols, SEXP y, SEXP rho)
{
   int rows, snps;
   unsigned char * p_x;
   double *p_y, *p_mpz0, *p_mpz1, *p_mpz2;
   SEXP ans, mpz0, mpz1, mpz2;  
   R_len_t i;

   rows = INTEGER_VALUE(x_rows);
   snps = INTEGER_VALUE(x_cols);
   PROTECT(x = AS_RAW(x));
   PROTECT(y = AS_NUMERIC(y));
   p_x = RAW_POINTER(x);
   p_y = NUMERIC_POINTER(y);

   PROTECT(ans = allocVector(VECSXP, 3));
   PROTECT(mpz0 = NEW_NUMERIC(rows));
   PROTECT(mpz1 = NEW_NUMERIC(rows));
   PROTECT(mpz2 = NEW_NUMERIC(rows));

   p_mpz0 = NUMERIC_POINTER(mpz0);
   p_mpz1 = NUMERIC_POINTER(mpz1);
   p_mpz2 = NUMERIC_POINTER(mpz2);

   for (int init=0; init < rows; init++) { 
      p_mpz0[init] = 0; 
      p_mpz1[init] = 0; 
      p_mpz2[init] = 0; 
   }

   double result[3];
   for(i = 0; i < rows; i++) {
        IBDestp(&p_x[i*snps], &p_x[(i+rows)*snps], p_y, snps, result);
        p_mpz0[i] = result[0];
        p_mpz1[i] = result[1];
        p_mpz2[i] = result[2];
   }
   SET_ELEMENT(ans, 0, mpz0); 
   SET_ELEMENT(ans, 1, mpz1); 
   SET_ELEMENT(ans, 2, mpz2); 

   UNPROTECT(6);
   return(ans);
}
