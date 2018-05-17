\name{sim.control}
\alias{sim.control}
\title{Set options that control gene drop simulation of relationship pairs.}
\description{
Set options that control gene drop simulation of relationship pairs.
}
\usage{
sim.control(simulate=FALSE, 
    rships=c("unrelated","MZtwins","parent-offspring","full-sibs","half-sibs"),
    nsim=rep(200,length(rships)), userdat=NULL,
    geno.err=1/1000, hom2hom.err=0, fitLD=TRUE, LDfiles=NULL, cl=NULL)
}
\arguments{
 \item{simulate}{
Should data be simulated by gene drop to allow the user to assign 
relationships to outlying 
pairs? Default is FALSE. See \bold{Details} for more information.
}
 \item{rships}{A character vector specifying the 
relationships to simulate. The choices are currently
\code{"unrelated"}, \code{"MZtwins"}, \code{"parent-offspring"}, 
\code{"full-sibs"}, \code{"half-sibs"},
\code{"cousins"}, or \code{"user"},
for unrelated, monozygotic-twin/duplicate, parent-offspring,
full-sibling,  half-sibling, first-cousin, or  user-defined relationship pairs,
respectively.  The default relationships are
\code{"unrelated"}, \code{"MZtwins"}, \code{"parent-offspring"}, \code{"full-sibs"} and 
\code{"half-sibs"}. Please 
note that half-sibling, avuncular and grandparent-grandchild relationships
cannot be distinguished on the basis of IBD coefficients.
Partial matches (e.g., \code{"par"} rather than \code{"parent-offspring"})
are allowed, as shown in the \bold{Examples}.
}
 \item{nsim}{
Numeric vector of numbers of pairs to be simulated by gene drop 
for each relationship.  The default is 200 for each relationship listed in  
\code{rships}.
}
 \item{userdat}{
A data frame of information on the pedigree to simulate for a user-defined 
relationship pair. The columns of this
data frame must be named as follows: 
\code{ids}, the IDs of the members of the pedigree;
\code{dadids}, the IDs of each pedigree member's father, or zero if 
the father is not in the pedigree;
\code{momids}, the IDs of each pedigree member's mother, or zero if 
the mother is not in the pedigree;
\code{gender}, the gender of each subject coded as 1 for male and 2
for female.
See \bold{Examples} for an example.
Default is \code{NULL}.
}
 \item{geno.err}{
Genotyping error rate. Each genotype is sampled with probability
\code{geno.err} to be measured incorrectly, according to a simple
error model. In the error model, heterozygous genotypes are equally 
likely to be called as either of the homozygous genotypes. 
Homozygous genotypes are called as the other homozygous genotype
with probability \code{hom2hom.err} and as heterozygous with 
probability 1-\code{hom2hom.err}. 
The default value of \code{geno.err} is 0.001.
}
 \item{hom2hom.err}{
The probability a homozygous genotype that is miscalled is miscalled
as the other homozygous genotype. Default is 0, so that miscalled
homozyous genotypes are always called heterozygous.
}
 \item{fitLD}{
Should an LD model be fit to the data for use in gene drop simulations?
Default is TRUE. 
Ignored if \code{simulate=FALSE}. 
See \bold{Details} for more information.
}
 \item{LDfiles}{
Character vector of the names of files containing LD models fit
by \code{\link[rJPSGCS]{FitGMLD}}. These may be present from a previous
call to \code{\link{IBDcheck}}. 
There must be one file name for each chromosome
of data in \code{snp.data}, and the files must be ordered
by chromosome number. Default is \code{NULL}. Ignored if
\code{fitLD=FALSE} or \code{simulate=FALSE}.
}
 \item{cl}{
A SNOW cluster that can be used to split fitting of LD models and 
gene drop simulations across a compute cluster. Default is \code{NULL}.
}
}
\details{
When \code{simulate=TRUE}, \code{IBDcheck} simulates data from pairs 
with known relationship that can be 
used to generate prediction ellipses on the graphical displays as a reference.
Unrelated, parent-offspring, full sibling, 
half sibling,  cousin, or user-defined relationships are simulated by 
gene drop and their estimated IBD coeficients are computed as for pairs of
study subjects.
Monozygotic twins/duplicates are not simulated by gene drop.
Rather, they are simulated by randomly sampling a study individual and
then applying the genotyping error model twice to make two copies.
Gene drop simulations can be based on loci in linkage equilibrium 
(\code{fitLD=FALSE}) or on a fitted LD model that accounts for 
inter-locus correlation (\code{fitLD=TRUE}).
}
\value{A list whose components are the function inputs.}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}
\seealso{
\code{\link{IBDcheck}}
}
\examples{
# Set simulation parameters to simulate unrelated, parent-offspring and
# full-sibling pairs. Leave other simulation parameters at their 
# default values (e.g., nsim=rep(200,length(rships)), fitLD=TRUE).
ss<-sim.control(simulate=TRUE,rships=c("unrel","parent","full"))
\dontrun{
# Create an IBD object to use as input to IBDcheck.
data(Nhlsim)
popsam<-Nhlsim$csct==0 # controls
# Use chromosomes 20, 21 and 22 only.
cind<-(Nhlsim$chromosome==20|Nhlsim$chromosome==21|Nhlsim$chromosome==22)
dat<-new.IBD(Nhlsim$snp.data[,cind],Nhlsim$chromosome[cind],
                Nhlsim$physmap[cind],popsam)
# Run IBDcheck
cibd<-IBDcheck(dat,simparams=ss)
# Save the names of the LD files for future simulations.
LDfiles<-cibd$simparams$LDfiles

# Use the fitted LD model from cibd to add 100 more simulated, unrelated pairs
# and save the updated IBD object in cibd2.
ss<-sim.control(simulate=TRUE,LDfiles=LDfiles,rships="unrelated",nsim=100) 
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd
cibd2<-IBDcheck(cibd2,filterparams=ff,simparams=ss)

# Add 200 simulated first-cousin pairs to cibd2, an IBD object which has no
# simulated first-cousin pairs. Save the updated IBD object in cibd3.
ss<-sim.control(simulate=TRUE,LDfiles=LDfiles,rships="cousins") 
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd2
cibd3<-IBDcheck(cibd2,filterparams=ff,simparams=ss)

# Add 200 simulated pairs having the user-specified mother-daughter relationship, 
# with mother and father being first cousins. See the package vignette 
# "CrypticIBDcheck", Figure 4, for a picture of this pedigree. Save the updated
# IBD object in cibd4. 
userdat<-data.frame(ids=1:9,
                    dadids=c(3,5,7,0,9,9,0,0,0),
                    momids=c(2,4,6,0,8,8,0,0,0),
                    gender=c(2,2,1,2,1,2,1,2,1))
ss<-sim.control(simulate=TRUE,LDfiles=LDfiles,rships=c("user"),userdat=userdat)
ff<-filter.control(filter=FALSE) # No need to re-filter the SNP data in cibd3
cibd4<-IBDcheck(cibd3,simparams=ss,filterparams=ff)

# Distribute fitting of LD models and gene drop simulations for each 
# chromosome across a cluster running on a local computer.  See the 
# package vignette, vignette("CrypticIBDcheck") for an example of running
# IBDcheck in batch mode on a compute cluster. Save the updated IBD object
# in cibd5.
library(parallel)
cl<-makeCluster(3,type="SOCK")
clusterEvalQ(cl,library("CrypticIBDcheck"))
ss<-sim.control(simulate=TRUE,cl=cl) # Leave all other sim params at defaults
cibd5<-IBDcheck(dat,simparams=ss)
stopCluster(cl)
}
}
