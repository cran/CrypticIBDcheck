\name{CrypticIBDcheck-package}
\alias{CrypticIBDcheck-package}
\alias{CrypticIBDcheck}
\docType{package}
\title{
identify cryptic relatedness in genetic association studies
}
\description{
\pkg{CrypticIBDcheck} can be used to identify pairs of closely-related
subjects based on genetic marker data from single-nucleotide 
polymorphisms (SNPs). The package is able to accommodate SNPs in 
linkage disequibrium (LD), without the need to thin the markers so 
that they are approximately independent in the population. Sample
pairs are identified as related 
by superposing their estimated identity-by-descent 
(IBD) coefficients on plots of IBD coefficients for pairs of simulated 
subjects from one of several common close relationships. The methods 
are particularly relevant to candidate-gene association
studies, in which dependent SNPs cluster in a relatively small 
number of genes spread throughout the genome.
}
\details{
The main function in CrypticIBDcheck is \code{\link{IBDcheck}}, 
which uses SNP information to estimate 
IBD coefficients for pairs of study subjects and optionally for 
simulated pairs of subjects and returns an object of class \code{IBD}. 
The plot method for the \code{IBD} class, \code{\link{plot.IBD}},
displays the IBD coefficients for 
pairs of study subjects, along with prediction ellipses for known 
relationship pairs.

The package comes with two vignettes: \code{CrypticIBDcheck} gives
an overview of the package and describes the methodology used, and
\code{IBDcheck-hapmap} illustrates how to use the package 
to explore cryptic relatedness using genome-wide data from HapMap. 
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney

Maintainer: Brad McNeney <mcneney@sfu.ca>
}
\keyword{package}
\seealso{
\pkg{rJPSGCS}
}
