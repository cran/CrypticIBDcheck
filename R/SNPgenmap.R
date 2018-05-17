SNPgenmap <- function(physmap, chromosomes) {
   genmap <- rep(NA, length(chromosomes))
   for (chr in 1:22) {
      physpos <- CrypticIBDcheck::RutgersMapB36[[paste0("chr", chr)]]$Build36_map_physical_position
      genmappos<-CrypticIBDcheck::RutgersMapB36[[paste0("chr", chr)]]$Sex.averaged_map_position
      chrmap <- approxfun(physpos,genmappos)
      ind <- which(chromosomes == chr)
      genmap[ind] <- chrmap(physmap[ind])
   }
   return(genmap)
}


