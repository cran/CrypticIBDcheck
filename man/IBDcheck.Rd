\name{IBDcheck}
\alias{IBDcheck}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{estimate IBD coefficients to identify cryptic relatedness in genetic association studies
%% compare pairwise IBD estimates on study subjects to those from simulated pairs of known relationship
}
\description{
Estimate IBD coefficients for pairs of study subjects.
Optionally, IBD coefficients are estimated from simulated
unrelated, monozygotic twin/duplicate, 
parent-offspring, full sibling, half sibling, or cousin pairs.
Users may also specify their own relationships to simulate
(see \bold{Examples}).
Simulations can make use of 
information about population linkage disequilibrium structure. 
The function returns an object of class \code{IBD} that can be 
graphically displayed by the
plot method of the class, 
 \code{\link{plot.IBD}}.
}
\usage{
IBDcheck(dat, filterparams=filter.control(),simparams=sim.control())
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{
An object of class \code{IBD}, created by \code{\link{new.IBD}} or by 
a previous call to \code{IBDcheck}.
}
 \item{filterparams}{
A list of parameters that control the filtering (e.g., quality control
filtering) of the data.
See \code{\link{filter.control}} for a description of these parameters.
} 
 \item{simparams}{
A list of parameters that control simulation of data by gene drops.
See \code{\link{sim.control}} for a description of these parameters.
} 
}
\details{
The required input to \code{IBDcheck} is an object of class
\code{IBD}, created by \code{\link{new.IBD}} or by 
a previous call to \code{IBDcheck}.
At a minimum, such an object includes the genetic data as a \code{snp.matrix}
object from the \pkg{chopsticks} package (Leung 2012),
a data frame of SNP information that includes chromosome and 
physical map positions of each SNP, and
a data frame of subject information that includes 
a logical vector indicating whether 
(\code{TRUE}) or not (\code{FALSE})
each subject is to be used to estimate
the conditional IBS probabilities and fit the LD model.
Sex-chromosome SNPs in the \code{IBD} object are ignored by \code{IBDcheck}.
SNPs and subjects are removed according the the filtering 
parameters set by the \code{\link{filter.control}} function.
For SNPs and subjects that remain after filtering,
IBD coefficients are estimated as described in Purcell \emph{et al.} (2007).
These proportions can be displayed graphically by the plotting function
\code{\link{plot.IBD}}.
When \code{simulate=TRUE}, \code{IBDcheck} simulates data that can be 
used to produce prediction ellipses for each simulated
relationship on the graphical displays.
Gene drop simulations to produce simulated pairs are done by the 
\code{\link{GeneDrops}} function from the \pkg{rJPSGCS} package. 
These simulations can be based on independent loci 
(\code{fitLD=FALSE}) or on a fitted LD model that accounts for 
inter-locus correlation (\code{fitLD=TRUE}).
Parameters that control the simulations may be set by the 
\code{\link{sim.control}} function.

The package vignette, \code{vignette("CrypticIBDcheck")}, 
contains full details on the methods underlying \code{IBDcheck}.
See also \code{vignette("IBDcheck-hapmap")} for an illustration 
of how to use \code{IBDcheck} to explore cryptic relatedness 
using genome-wide data from HapMap.
}
\value{
An object of class \code{IBD}. See the help file for the
constructor function \code{\link{IBD}} for a description of the 
components of this class.
}
\references{
Leung H-T (2012). chopsticks: The snp.matrix and X.snp.matrix
classes. R package version 1.20.0.

Purcell S, Neale B, Todd-Brown K, Thomas L, Ferreira MA, Bender D, Maller J, 
Sklar P, de Bakker PI, Daly MJ, Sham PC.
PLINK: a tool set for whole-genome association and population-based 
linkage analyses.  Am J Hum Genet. 2007 Sep;81(3):559-75.
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}
\note{
%%  ~~further notes~~

When \code{simulate=TRUE} and \code{fitLD=TRUE}, the function can 
be computationally demanding for data sets with more than about
1000 SNPs. 
In Appendix B of the vignette \code{CrypticIBDcheck} we
describe strategies for making computations feasible by 
use of a \pkg{parallel} cluster (Tierney \emph{et al.}, 2011).

Users may also need to increase the amount of java heap space for
some computations.
The computation for fitting the 
LD model is done in java, using functions from Alun
Thomas' suite of Java Programs for Statistical Genetics and
Computational Statistics (JPSGCS).
The JPSGCS java programs are accessed
by R-wrappers provided by the \pkg{rJPSGCS} R package. When \pkg{rJPSGCS}
is loaded (automatically by loading \pkg{CrypticIBDcheck}), it 
initializes the java Virtual
Machine (JVM) via the \pkg{rJava} package, if not already done so
by another package. One can set the amount of memory java can use 
for heap space by
initilizing the JVM \emph{before} loading \pkg{CrypticIBDcheck} as
follows:

\preformatted{
   options(java.parameters="-Xmx2048m") #set max heap space to 2GB
   library(rJava)
   .jinit() #initialize the JVM
   library(CrypticIBDcheck) # now load rJPSGCS by loading CrypticIBDcheck
   }

}
\seealso{
\code{\link{plot.IBD}},
\code{\link{SNPgenmap}}
}
\examples{
# These examples use the package dataset Nhlsim. For examples of how to
# prepare data in other formats for use by IBDcheck(), please see the 
# documentation for new.IBD().
##################################################3
# Part I: No simulations
# Example 1) use all default settings; i.e., filter SNPs but do not simulate data
data(Nhlsim)
popsam<-Nhlsim$csct==0 # controls
dat<-new.IBD(Nhlsim$snp.data,Nhlsim$chromosome,Nhlsim$physmap,popsam)
cibd<-IBDcheck(dat)
##################################################3
\dontrun{
# Part II: Simulate data assuming SNPs are in linkage equilibrium (no LD model fitted).
# Example 2) Simulate pairs of subjects of each of the default relationships:
# unrelated, MZ twins/duplicate, parent-offspring, full sibling, half sibling
# Use chromosomes 20, 21 and 22 only.
cind<-(Nhlsim$chromosome == 20 | Nhlsim$chromosome == 21 | Nhlsim$chromosome == 22)
dat<-new.IBD(Nhlsim$snp.data[,cind],Nhlsim$chromosome[cind],
                Nhlsim$physmap[cind],popsam)
ss<-sim.control(simulate=TRUE,fitLD=FALSE) 
cibd2<-IBDcheck(dat,simparams=ss)

# Example 3) Add 100 more simulated unrelated pairs to the IBD object cibd2
ss<-sim.control(simulate=TRUE,fitLD=FALSE,rships="unrelated",nsim=100) 
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd2
cibd3<-IBDcheck(cibd2,filterparams=ff,simparams=ss)

# Example 4) Add simulated first cousin pairs to the IBD object, cibd3, without any  
# simulated first cousins. Simulate the default number of 200 pairs of first cousins.
ss<-sim.control(simulate=TRUE,fitLD=FALSE,rships="cousins") 
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd3
cibd4<-IBDcheck(cibd3,filterparams=ff,simparams=ss)

# Example 5) Add simulated pairs for the user-specified relationship of
# mother-daughter, with mother and father who are first cousins. See the package
# vignette "CrypticIBDcheck", Figure 4, for a picture of this pedigree. Simulate  
# the default number of 200 pairs of this user-specified relationship.
userdat<-data.frame(ids=1:9,
                    dadids=c(3,5,7,0,9,9,0,0,0),
                    momids=c(2,4,6,0,8,8,0,0,0),
                    gender=c(2,2,1,2,1,2,1,2,1))
ss<-sim.control(simulate=TRUE,fitLD=FALSE, rships=c("user"), userdat=userdat)
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd4
cibd5<-IBDcheck(cibd4,simparams=ss,filterparams=ff)
##################################################
# Part III: Simulations based on a fitted LD model
# Example 6) Simulate pairs of subjects of each of the default relationships:
# unrelated, MZ twins/duplicate, parent-offspring, full sibling, half sibling.
# Use IBD object "dat" with SNPs from chromosomes 20, 21 and 22 only.
ss<-sim.control(simulate=TRUE,fitLD=TRUE) 
cibd6<-IBDcheck(dat,simparams=ss)
# Save names of LD files for future simulations.
LDfiles<-cibd6$simparams$LDfiles

# Example 7) Use the fitted LD model from cibd6 to add 100 more simulated 
# unrelated pairs
ss<-sim.control(simulate=TRUE,fitLD=TRUE,LDfiles=LDfiles,
rships="unrelated",nsim=100) 
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd6
cibd7<-IBDcheck(cibd6,filterparams=ff,simparams=ss)
# NB: names of the LD files will be copied from cibd6 to cibd7

# Example 8) Use the fitted LD model from cibd6 to add simulated first cousins
# to an IBD object without any simulated first-cousin pairs. Add the default
# number of 200 simulated pairs of first cousins.
ss<-sim.control(simulate=TRUE,fitLD=TRUE,LDfiles=LDfiles,rships=c("cousins"))
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd7
cibd8<-IBDcheck(cibd7,simparams=ss,filterparams=ff)

# Example 9) Use the fitted LD model from cibd6 to add simulated pairs for the
# user-specified mother-daughter relationship, with mother and father who are
# first cousins. See the package vignette "CrypticIBDcheck", Figure 4, for a
# picture of this pedigree. Simulate the default number of 200 pairs of this
# user-specified relationship.
200 pairs.
userdat<-data.frame(ids=1:9,
                    dadids=c(3,5,7,0,9,9,0,0,0),
                    momids=c(2,4,6,0,8,8,0,0,0),
                    gender=c(2,2,1,2,1,2,1,2,1))
ss<-sim.control(simulate=TRUE,fitLD=TRUE, LDfiles=LDfiles, rships=c("user"),
userdat=userdat)
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd8
cibd9<-IBDcheck(cibd8,simparams=ss,filterparams=ff)

# Example 10) Distribute fitting of LD models and gene drop simulations for
# chromosomes 20, 21 and 22 across a cluster running on a local computer. 
# See the package vignette, vignette("CrypticIBDcheck") for an example of
# running IBDcheck in batch mode on a compute cluster. Simulate pairs of
# subjects from each of the default relationships: unrelated, MZ twins/duplicate, 
# parent-offspring, full sibling, half sibling.
cind<-(Nhlsim$chromosome == 20 | Nhlsim$chromosome == 21 | Nhlsim$chromosome == 22)
dat<-new.IBD(Nhlsim$snp.data[,cind],Nhlsim$chromosome[cind],
                Nhlsim$physmap[cind],popsam)
library(parallel)
cl<-makeCluster(3,type="SOCK")
clusterEvalQ(cl,library("CrypticIBDcheck"))
ss<-sim.control(simulate=TRUE,fitLD=TRUE,cl=cl)
cibd3<-IBDcheck(dat,simparams=ss)
stopCluster(cl)

}
}

\keyword{univar}
