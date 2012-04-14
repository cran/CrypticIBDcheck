\name{IBD}
\alias{IBD}
\alias{IBD-class}
\title{Constructor function for objects of class \code{IBD}}
\description{
Constructor function for objects of class \code{IBD}, used
as both the input and output of the \code{\link{IBDcheck}} function. This is 
not intended to be called by users. Users 
preparing data for a call to \code{IBDcheck} should use the wrapper function
\code{\link{new.IBD}}, which provides basic checks of the input.
}
\usage{
IBD(snp.data, snp.support,subject.support, ibd.study=NULL,
    ibd.ur=NULL,ibd.mz=NULL,ibd.po=NULL,ibd.fs=NULL,ibd.hs=NULL, 
    ibd.co=NULL, ibd.user=NULL, filterparams=NULL,simparams=NULL,call=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{snp.data}{
A snp.matrix object containing the genotypes. 
Rows correspond to subjects and columns correspond to SNPs.
}
  \item{snp.support}{
a data frame of SNP information
}
  \item{subject.support}{
a data frame of subject information
}
 \item{ibd.study}{
A data frame of estimated IBD coefficients for study subjects. 
Columns represent estimated probabilities of 0, 1 and 2 
alleles IBD. Rows represent pairs of subjects.
}
 \item{ibd.ur}{
data frame of estimated IBD coefficients for simulated unrelated subjects
}
 \item{ibd.mz}{
data frame of estimated IBD coefficients for simulated monozygotic twins
}
 \item{ibd.po}{
data frame of estimated IBD coefficients for simulated parent-offspring subjects
}
 \item{ibd.fs}{
data frame of estimated IBD coefficients for simulated full sibling subjects
}
 \item{ibd.hs}{
data frame of estimated IBD coefficients for simulated half sibling subjects 
}
 \item{ibd.co}{
data frame of estimated IBD coefficients for simulated cousins
}
 \item{ibd.user}{
data frame of estimated IBD coefficients for subjects having a user-defined relationship
}
  \item{filterparams}{
a list of data filtering options returned by 
\code{\link{filter.control}}
}
  \item{simparams}{
a list of data simulation options returned by 
\code{\link{sim.control}}
}
  \item{call}{
the \code{\link{IBDcheck}} call that created the 
\code{ibd.*} data frames
}
}
\details{
Objects of class \code{IBD} are both the input and output of the
\code{\link{IBDcheck}} function.
}
\value{
An object of class \code{IBD}, which is a list comprised of the 
function arguments. 
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}
\seealso{
\code{\link{IBDcheck}}
}
