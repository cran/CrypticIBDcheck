#include <stdlib.h>
#include "IBDestp.h"

void IBDestp(unsigned char * p_x_i, unsigned char * p_x_j, double * p_y, int snps, double * result) {
   double sum_pi0z0, sum_pi1z0, sum_pi2z0, sum_pi1z1, sum_pi2z1, sum_pi2z2;
   sum_pi0z0 = sum_pi1z0 = sum_pi2z0 = sum_pi1z1 = sum_pi2z1 = sum_pi2z2 = 0;
   int ni[3]; ni[0] = ni[1] = ni[2] = 0;
   int val;
   double mpz[3];
   for(int k = 0; k < snps; k++) {
           if (p_x_i[k] && p_x_j[k]) { /* TRUE only if both have data */
              val = 2 - abs(p_x_i[k] - p_x_j[k]); /* number IBS */
              ni[val]++;
              sum_pi0z0 += p_y[9*k];
              sum_pi1z0 += p_y[9*k+1];
              sum_pi2z0 += p_y[9*k+2];
              sum_pi1z1 += p_y[9*k+4];
              sum_pi2z1 += p_y[9*k+5];
              sum_pi2z2 += p_y[9*k+8];
           }
  }
  result[0] = mpz[0] = ni[0]/sum_pi0z0;
  result[1] = mpz[1] = (ni[1] - mpz[0] * sum_pi1z0) / sum_pi1z1;
  result[2] = mpz[2] = (ni[2] - mpz[0] * sum_pi2z0 - mpz[1] * sum_pi2z1)/sum_pi2z2;
}
