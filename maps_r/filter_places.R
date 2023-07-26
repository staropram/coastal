# https://osdatahub.os.uk/downloads/open/OpenNames
library(sf)
library(data.table)
#places <- st_read("../data/opname_gb.gpkg")
#places <- data.table(places)

places_cities <- places[local_type=="City"&region=="South East"]
places_towns <- places[local_type=="Town",]
places_villages <- places[local_type=="Village",]
places_settlement <- places[local_type=="Other Settlement",]

write_gpkg <- function(obj,out_fn) {
   if(file.exists(out_fn)) {
      file.remove(out_fn)
   }
   st_write(obj, out_fn)
}

write_gpkg(places_cities,"../data/places_cities.gpkg")
write_gpkg(places_towns,"../data/places_towns.gpkg")
write_gpkg(places_villages,"../data/places_villages.gpkg")
write_gpkg(places_settlement,"../data/places_settlement.gpkg")
