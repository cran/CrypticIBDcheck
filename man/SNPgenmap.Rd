\name{SNPgenmap}
\alias{SNPgenmap}
\title{
convert physical map positions on build 36 of the genome to genetic map positions
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~ 
Convert physical map positions on build 36 of the genome 
to genetic map positions by linear interpolation of the Rutgers combined 
linkage-physical map. 
The markers in the Rutgers map are a small 
subset of markers for which genetic map positions have been
determined. Linear interpolation is done for points in between. 
}
\usage{
SNPgenmap(physmap, chromosomes)
}
\arguments{
  \item{physmap}{a vector of physical map positions on build 36 of the human genome 
}
  \item{chromosomes}{a vector containing the corresponding chromosome numbers 
}
}
\details{
Genetic map positions are inferred from physical positions by linear
interpolation of the Rutgers Combined Linkage-Physical Map for 
build 36 of the human genome, contained in the data object
\code{\link{RutgersMapB36}}.
Users who want some other form of interpolation can do so themselves
using \code{\link{RutgersMapB36}}, as illustrated in the
\bold{Examples}.
\emph{NB:} The order of markers in \code{RutgersMapB36}
is the same for both physical and genetic maps.  In order for an interpolated
genetic map to preserve the ordering of physical map positions, the interpolant
must be monotone increasing. Linear interpolation \emph{is} monotone
increasing, but other forms, such as spline interpolation, may not be.
}
\value{
The function returns a vector of genetic map positions.
}
\author{
Annick Joelle Nembot-Simo, Jinko Graham and Brad McNeney
}
\note{
The function interpolates the Rutgers map and does not attempt
to extrapolate for SNPs outside the map. Genetic map positions
for SNPs outside the Rutgers map are set to \code{NA}.
}

\seealso{
\code{\link{RutgersMapB36}}
}
\examples{
data(Nhlsim)
gmap <- SNPgenmap(Nhlsim$physmap,Nhlsim$chromosome)

# Example of using RugtersMapB36 to do spline rather than linear 
# interpolation of genetic map positions on chromosome 1.  
# NB: Interpolant is not necessarily monotone increasing, which can lead to a 
# genetic map on which markers are re-ordered relative to the physical map.
data("RutgersMapB36")
chrmap<-splinefun(RutgersMapB36[["chr1"]]$Build36_map_physical_position,
                  RutgersMapB36[["chr1"]]$Sex.averaged_map_position)
c1ind<-(Nhlsim$chromosome=="chr1")
gmap[c1ind]<-chrmap(Nhlsim$physmap[c1ind])
}
