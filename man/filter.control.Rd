\name{filter.control}
\alias{filter.control}
\title{Set options for quality control filtering of data.
}
\description{
Set options for quality control filtering of data.
}
\usage{
filter.control(filter=TRUE, snpcallrate=.9, MAF=.01, samplecallrate=.9, 
               HWEp=.001)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{filter}{
Should data filtering be done? Default is \code{TRUE}.
}
 \item{snpcallrate}{
The SNP call rate is the proportion of non-missing genotypes in the 
study per SNP.  
SNPs with call rate less than \code{snpcallrate} are removed. 
The default value is 0.90.
} 
 \item{MAF}{
The minimum minor allele frequency (MAF) for SNPs. 
SNPs with MAF less than \code{MAF} are removed. 
The default value is 0.01.
} 
 \item{samplecallrate}{
%%     ~~Describe \code{csct} here~~
The proportion of SNPs for a sample that had genotype calls. 
Samples with call rate less than \code{samplecallrate} are removed.
The default value is 0.90.
} 
 \item{HWEp}{
Threshold for the p-value from a 2-sided test of HWE. 
SNPs with p-value less than \code{HWEp} are removed.
The default value is 0.001. 
}
}
\value{
A list whose components are the function inputs.
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}
\seealso{
\code{\link{IBDcheck}}
}
\examples{
ff<-filter.control()
ff<-filter.control(MAF=0.05)
}
