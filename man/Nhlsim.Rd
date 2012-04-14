\name{Nhlsim}
\alias{Nhlsim}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
Example data for the CrypticIBDcheck package
}
\description{
A dataset that contains genotypes simulated by 
gene drop based on a model of linkage disequilibrium fit to data from a 
candidate-gene case-control study.  
Several close relative pairs have been included 
in the simulated data.
}
\usage{data(Nhlsim)}
\format{
A list comprised of the following four objects:
\tabular{rll}{
[[1]] \tab snp.data \tab a \code{snp.matrix} object containing genotypes of 208 subjects (108 controls and 100 cases). \cr
 \tab \tab Rows correspond to subjects and columns correspond to SNPs \cr
[[2]] \tab chromosome \tab a numeric vector containing the chromosome numbers of the SNPs \cr
[[3]] \tab physmap \tab a numeric vector of physical positions \cr
[[4]] \tab csct \tab a vector of case-control status (1=case, 0=control) \cr
}
}
\details{
The dataset contains mostly unrelated individuals, but includes two 
parent-offspring pairs and three full-siblings pairs
to show how the CrypticIBDcheck package can be used to 
uncover cryptic relatedness.
}
\source{
The genotypes were simulated based on data 
from a candidate-gene case-control study 
described in Schuetz et al. (2012).
}
\references{
Schuetz JM, Daley D, Graham J, Berry BR, Gallagher RP, Connors JM, Gascoyne
RD, Spinelli JJ, Brooks-Wilson AR (2012). Genetic Variation in Cell
Death Genes and Risk of Non-Hodgkin Lymphoma. PLoS ONE, 7(2), e31560.
doi:10.1371/journal.pone.0031560. 
}
\examples{
data(Nhlsim)
}
\keyword{datasets}
