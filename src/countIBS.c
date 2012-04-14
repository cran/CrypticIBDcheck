#include <stdio.h>
#include <stdlib.h>

void countIBS(char *x, int *rows, int *ncol, int *m0, int *m1, int *m2) {
  int nrow = *rows;
  int nsnp = *ncol;
  int i, j, i1, j1, i2, k, d;
  for (i=0, i1=0, i2=0; i<nrow-1; i++, i1+=nsnp, i2+=nrow) { 
    for (j=i+1, j1=j*nsnp; j<nrow; j++, j1+=nsnp) {
      for (k=0; k<nsnp; k++) {
        if ((int)x[i1+k] != 0 && (int)x[j1+k] != 0) {
          d = abs((int)x[i1+k] - (int)x[j1+k]);
          if (d==2) m2[i2+j]+=1;
          else if (d==1) m1[i2+j]+=1;
          else if (d==0) m0[i2+j]+=1;
        }
      }
    }
  }
  return;
}
