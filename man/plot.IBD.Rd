\name{plot.IBD}
\alias{plot.IBD}
\title{
plot estimated IBD coefficients for pairs of study subjects, along with prediction ellipses
based on simulated pairs of known relationships}
\description{
Interactive graphical display of an \code{IBD} object.
}
\usage{
\method{plot}{IBD}(x,kinshipth=NULL, ellipse.coverage=.95,...)
}
\arguments{
  \item{x}{an IBD object returned by IBDcheck}
 \item{kinshipth}{
Kinship coefficient threshold. 
If \code{NULL} (the default),
all study pairs will be included on the first plot summarizing the study pairs.
If a numeric value, study pairs with estimated kinship coefficient less than 
this threshold value will be suppressed on the first plot.
When \code{simulate=TRUE} and unrelated pairs are simulated, users may specify
\code{kinshipth="empirical"} to use the 99th percentile 
of estimated kinship coefficients in simulated unrelated pairs
as the threshold value. 
}
 \item{ellipse.coverage}{
Prediction ellipse coverage probability. 
Simulated pairs of subjects from
a given relationship are used to construct prediction ellipses with 
approximate coverage probability \code{ellipse.coverage}.
See \bold{Details} for details.
}
 \item{...}{
optional arguments passed to \code{\link[graphics]{plot}}
}
}
\details{
\strong{Overview:} 
When \code{simulate=FALSE}, the function produces an interactive plot of 
estimated IBD coefficients for pairs of study subjects whose estimated
kinship coefficients exceed the user-specified threshold in \code{kinshipth}. 
Plots are of the estimated probability of 1 IBD versus the estimated 
probability of 0 IBD for pairs of study subjects, with prediction ellipses 
for known relationships superposed, if requested by the user 
with \code{simulate=TRUE}.
The prediction ellipses are produced from estimated IBD coefficients 
for a user-specified number (default 200) of simulated pairs of 
known relationships, assuming the distribution of estimated 
IBD coefficients is approximately bivariate Normal. 
When simulated pairs are omitted (\code{simulate=FALSE}),
plotting produces a single interactive display of estimated IBD 
coefficients for pairs of study subjects specified by \code{kinshipth}, on which points
may be identified by clicking with the mouse.
By contrast, when the \code{IBD} object includes simulated pairs,
the function returns a series of plots, which the user is
prompted to view and interact with successively.
The first plot to appear is non-clickable and shows the 
estimated IBD coefficients for pairs of study subjects 
specified by \code{kinshipth},
along with the prediction ellipse for unrelated, simulated pairs.
Subsequent plots are clickable and correspond to each relationship
requested in the call to \code{IBDcheck()}. These relationship-specific
plots are for identifying pairs of study subjects which could have the
relationship. The plotting regions are
restricted to the neighborhood of the prediction ellipse for
the simulated pairs of that relationship, which is also drawn. 
If, however, the plotting region overlaps with the 
prediction ellipse for simulated unrelated pairs, 
the ellipse for simulated unrelated pairs is drawn as well.
Points falling within the 
prediction ellipse for the relationship
and outside the prediction 
ellipse for unrelated pairs are automatically flagged. 
In addition, 
users may click on points of study pairs that appear to be related 
but are not automatically flagged. 
The plot method produces a data frame of information on pairs
that have been flagged on the different plots, 
either automatically or interactively by the user through
clicking the mouse.

\strong{Additional details:}
The \code{\link[car]{showLabels}} function in the \pkg{car} package
is used to implement identification of points by left-clicking the 
mouse on interactive plots.
When finished identifying points, users should
right-click the plotting region to move to the next plot. 
A Bonferroni-type adjustment is applied when computing the ellipse for 
unrelated pairs to account for the fact that, typically, most 
study pairs will be unrelated. Specifically, 
the coverage probability for the simulated unrelated
pairs ellipse is taken to be 
\eqn{1-(1-{\tt ellipse.coverage})/n_p}{1-(1-ellipse.coverage)/npairs}, where
\eqn{n_p}{npairs} is the number of pairs of study subjects.
}
\value{
A data frame of information on pairs that are flagged, either automatically
or by user mouse-clicks,  on the
different plots provided by the function. The columns of this data
frame are:
\item{member1}{ID of the first member of the study pair}
\item{member2}{ID of the second member of the study pair}
\item{pz0}{estimated proportion of markers with zero alleles IBD}
\item{pz1}{estimated proportion of markers with one allele IBD}
\item{relationship}{If \code{simulate=TRUE}, this column
indicates which relationship plot each pair was 
identified on. This column is absent from the data frame when
\code{simulate=FALSE}.}
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}
\seealso{
\code{\link{IBDcheck}},
\code{\link[car]{showLabels}}
}
\examples{
data(Nhlsim)
\dontrun{
# Example with simulate=FALSE (default)
popsam<-Nhlsim$csct==0 # controls
dat<-new.IBD(Nhlsim$snp.data,Nhlsim$chromosome,Nhlsim$physmap,popsam)
cibd<-IBDcheck(dat)
plot(cibd)
# Example with simulate=TRUE. Use chromosomes 20, 21 and 22 only.
cind<-(Nhlsim$chromosome == 20 | Nhlsim$chromosome == 21 | Nhlsim$chromosome == 22)
dat<-new.IBD(Nhlsim$snp.data[,cind],Nhlsim$chromosome[cind],
                Nhlsim$physmap[cind],popsam)
ss<-sim.control(simulate=TRUE,fitLD=TRUE)
cibd2<-IBDcheck(dat,simparams=ss)
plot(cibd2)

# Example use of kinshipth argument: On the plot of study subjects, only plot
# those with kinship coefficient greater than the 99th percentile of the
# kinship coefficients of simulated unrelated individuals.
plot(cibd2,kinshipth="empirical")
}
}
\keyword{hplot}
