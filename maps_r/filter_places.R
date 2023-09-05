# https://osdatahub.os.uk/downloads/open/OpenNames
library(sf)
library(data.table)
#places <- st_read("../data/opname_gb.gpkg")
#places <- data.table(places)

places_se <- places[region=="South East"]
places_cities_southeast <- places_se[local_type=="City",]
places_towns_southeast <- places_se[local_type=="Town",]
places_villages_southeast <- places_se[local_type=="Village",]
places_settlement_southeast <- places_se[local_type=="Other Settlement",]

write_gpkg <- function(obj,out_fn) {
   if(file.exists(out_fn)) {
      file.remove(out_fn)
   }
   st_write(obj, out_fn)
}

write_gpkg(places_cities_southeast,"../data/places_cities_southeast.gpkg")
write_gpkg(places_towns_southeast,"../data/places_towns_southeast.gpkg")
write_gpkg(places_villages_southeast,"../data/places_villages_southeast.gpkg")
write_gpkg(places_settlement_southeast,"../data/places_settlement_southeast.gpkg")
