library(sf)
load_gpkg <- function(name) {
   if(!exists(name)) {
      d <- st_read(paste0("../data/",name,".gpkg"))
      assign(name, d, envir = .GlobalEnv)
   }
}

lapply(c(
   "kent_boundary",
   "medway_boundary",
   "places_towns_kent",
   "places_towns_medway",
   "bua_2011_kent",
   "buasd_2011_kent",
   "lsoa_2011_kent"
),load_gpkg)
