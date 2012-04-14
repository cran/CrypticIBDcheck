\name{RutgersMapB36}
\alias{RutgersMapB36}
\docType{data}
\title{
physical and genetic map positions for a collection of markers on chromosome 1 to 22
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
This dataset is list comprised of  data frames corresponding to chromosomes 1 to 22. Each data frame has information on physical and genetic map positions for a
collection of markers on the corresponding chromosome.
}
\usage{data(RutgersMapB36)}
\format{
The format of the dataset is a list of 22 elements. Each element is a data frame corresponding to a chromosome with nine columns: 
\tabular{rlll}{
[,1] \tab Markers_name \tab factor \tab marker name \cr
[,2] \tab Type \tab factor \tab marker type \cr
[,3] \tab Primer.SNP_ref_name \tab factor \tab primer or SNP name \cr
[,4] \tab Informative_meioses \tab integer \tab number of informative meioses \cr
[,5] \tab Heterozygosity \tab numeric \tab marker heterozygosity \cr
[,6] \tab Build36_map_physical_position \tab integer \tab physical position (in base pairs) on build 36 of the human genome \cr
[,7] \tab Sex.averaged_map_position \tab numeric \tab sex-averaged map position \cr
[,8] \tab Female_map_position \tab numeric \tab female map position \cr
[,9] \tab Male_map_position \tab numeric \tab male map position \cr
}
}
\source{
The data were obtained from the Rutgers map (see
\url{http://compgen.rutgers.edu/RutgersMap/DownloadMap.aspx})
}
\references{
A second-generation combined linkage physical map of the human genome. 
Matise TC, Chen F, Chen W, De La Vega FM, Hansen M, He C, Hyland FC, Kennedy GC, 
Kong X, Murray SS, Ziegle JS, Stewart WC, Buyske S.
Genome Res. 2007 Dec;17(12):1783-6. Epub 2007 Nov 7.
}
\examples{
data(RutgersMapB36)
}
\keyword{datasets}
