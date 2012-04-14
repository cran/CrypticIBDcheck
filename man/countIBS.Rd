\name{countIBS}
\alias{countIBS}
\title{
calculates counts of 0, 1 and 2 IBS
}
\description{
Returns counts of the number of markers at which a
pair of subjects shares 0, 1 or 2 alleles identical-by-state (IBS),
for all possible pairs. Counts for a given pair
exclude markers where either pair member is missing data.
}
\usage{
countIBS(x)
}
\arguments{
  \item{x}{
An object of type \code{snp.matrix}
}
}
\value{
\item{IBS0}{An upper triangular matrix whose (i,j)th element (i<j) is
the count of non-missing markers where the 
ith and jth subjects share 0 alleles IBS.}
\item{IBS1}{An upper triangular matrix whose (i,j)th element (i<j) is
the count of non-missing markers where the 
ith and jth subjects share 1 allele IBS.}
\item{IBS2}{An upper triangular matrix whose (i,j)th element (i<j) is
the count of non-missing markers where the 
ith and jth subjects share 2 alleles IBS.}
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}

\examples{
data(Nhlsim)
countIBS(Nhlsim$snp.data[1:5,])
}
\keyword{univar}
