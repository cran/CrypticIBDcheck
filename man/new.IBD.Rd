\name{new.IBD}
\alias{new.IBD}
\title{Create a data structure suitable for input to \code{IBDcheck}}
\description{
Create a data structure suitable for input to \code{\link{IBDcheck}}.
This is a wrapper function for the constructor function \code{\link{IBD}}
that creates the object.
The wrapper provides basic checks of the input and creates
the \code{snp.support} and \code{subject.support} data frames
required for an \code{IBD} object.
}
\usage{
new.IBD(snp.data, Chromosome, Position, popsam, Gen_loc=NULL, 
        pvalue_HWE=NULL, subids=NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{snp.data}{
A \code{snp.matrix} object containing the genotypes. 
Rows correspond to subjects and columns correspond to SNPs.
}
  \item{Chromosome}{
a vector containing the chromosome numbers of the SNPs
}
  \item{Position}{
a vector of physical map positions
}
 \item{popsam}{
A logical vector indicating whether each subject can be considered 
part of a random sample (\code{TRUE}) or not (\code{FALSE}).
See \bold{Details} for more information.
Only those subjects for which \code{popsam==TRUE} are used for
estimating conditional IBS probabilities and fitting LD models.
}
  \item{Gen_loc}{
A vector of genetic map positions in centiMorgans. If \code{NULL}
(the default), they will be inferred using the function
\code{\link{SNPgenmap}}.
}
  \item{pvalue_HWE}{
A vector of p-values from tests of Hardy-Weinberg proportions for
each SNP. If \code{NULL} (the default), they will be filled in using 
all population sample subjects (\code{popsam==TRUE}) in 
\code{snp.data}.
}
  \item{subids}{
a vector of subject IDs
}
  \item{...}{
additional arguments to be passed to the constructor \code{\link{IBD}}
}
}
\details{
The arguments \code{snp.data}, \code{Chromosome}, \code{Position} and 
\code{popsam} are required.
Only subjects with \code{popsam==TRUE} are used for estimating 
conditional IBS probabilities and fitting LD models; 
those with \code{popsam==FALSE} are excluded.
A typical use of \code{popsam} is to exclude cases 
when the data are from case control study of a rare disease, where
cases are oversampled relative to
their frequency in the population but controls may be regarded as 
a population sample.

If \code{Gen_loc} is missing it is inferred from \code{Position} by the
\code{\link{SNPgenmap}} function. 
Currently \code{\link{SNPgenmap}}
assumes physical map positions are on build 36 of the human genome.
If \code{subids} is missing, the row names of \code{snp.data}
are used as subject identifiers. 
}
\value{
An object of class \code{IBD}. See the help file for 
the constructor function \code{\link{IBD}} for details.
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}
\seealso{
\code{\link{IBDcheck}}
}
\examples{
data(Nhlsim)
popsam<-Nhlsim$csct==0 #controls
dat<-new.IBD(Nhlsim$snp.data,Nhlsim$chromosome,Nhlsim$physmap,popsam)

\dontrun{
# Read PLINK-formatted data via the read.snps.pedfile() function of the 
# chopsticks package 
# [source("http://bioconductor.org/biocLite.R"); biocLite("chopsticks") to install]
# Assume PLINK data is in files mydata.ped and mydata.map.
require(chopsticks)
mydata = read.snps.pedfile("mydata.ped")
# mydata is now a list with elements mydata$snp.data, mydata$snp.support and 
# mydata$subject.support. Chromosome number and physical position of the SNPs 
# are in mydata$snp.support$chromosome and mydata$snp.support$position, respectively.
dat<-new.IBD(mydata$snp.data,mydata$snp.support$chromosome,
             mydata$snp.support$position,popsam=rep(1,nrow(mydata$snp.support)))
}
}
