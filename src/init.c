#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .C calls */
extern void count_IBS(void *, void *, void *, void *, void *, void *);

/* .Call calls */
extern SEXP IBDest_sim(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP IBDest_study(SEXP, SEXP, SEXP, SEXP, SEXP);

static const R_CMethodDef CEntries[] = {
    {"count_IBS", (DL_FUNC) &count_IBS, 6},
    {NULL, NULL, 0}
};

static const R_CallMethodDef CallEntries[] = {
    {"IBDest_sim",   (DL_FUNC) &IBDest_sim,   5},
    {"IBDest_study", (DL_FUNC) &IBDest_study, 5},
    {NULL, NULL, 0}
};

void R_init_CrypticIBDcheck(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
