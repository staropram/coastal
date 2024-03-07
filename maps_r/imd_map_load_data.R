library(sf)
if(!exists("imd")) {
   imd <- st_read("../data/Indices_of_Multiple_Deprivation_(IMD)_2019.shp")
   imd <- imd %>% st_transform(crs=27700)
   invalid_loop_i <- which(!st_is_valid(imd))
   imd[invalid_loop_i,] <- st_make_valid(imd[invalid_loop_i,])
}

load_gpkg <- function(params) {
      if(!exists(params$rname)) {
               d <- st_read(paste0("../data/",params$fn,".gpkg"))
      assign(params$rname, d, envir = .GlobalEnv)
         }
}

# load in coast
if(!exists("coast")) {
   load_gpkg(list(fn="Countries_December_2022_UK_BGC",rname="coast"))
}
