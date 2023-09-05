library(sf)
library(data.table)
library(tmap)
# https://osdatahub.os.uk/downloads/open/OpenNames
places_cities_southeast <- st_read("../data/places_cities_southeast.gpkg")
places_towns_southeast <- st_read("../data/places_towns_southeast.gpkg")
places_villages_southeast <- st_read("../data/places_villages_southeast.gpkg")
places_settlement_southeast <- st_read("../data/places_settlement_southeast.gpkg")

tmap_mode("view")
tmap_map <- tm_basemap("OpenStreetMap") +
       tm_shape(places_towns_southeast)
tmap_map
