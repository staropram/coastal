library(sf)
library(data.table)
library(tmap)
# https://osdatahub.os.uk/downloads/open/OpenNames
places_cities_southeast <- st_read("../data/places_cities_southeast.gpkg")
places_towns_southeast <- st_read("../data/places_towns_southeast.gpkg")
places_villages_southeast <- st_read("../data/places_villages_southeast.gpkg")
places_settlement_southeast <- st_read("../data/places_settlement_southeast.gpkg")

webplot = F
if(webplot) {
   tmap_mode("view")
   tmap_map <- tm_basemap("OpenStreetMap") +
         tm_shape(places_towns_southeast) +
          tm_dots(labels="name1")
   print(tmap_map)
} else {
   graphics.off()
   tmap_mode("plot")

   town_bounds <- places_towns_southeast %>% filter(grepl("Whitstable|Broadstairs|Margate|Hythe",name1))
   se_hull <- st_convex_hull(st_union(town_bounds))

   osm_layer <- read_osm(se_hull, ext=1.1,zoom=13)

   tmap_map <- 
         tm_shape(osm_layer) + 
         tm_rgb() +
         tm_shape(places_towns_southeast) +
         tm_dots()
   print(tmap_map)
}
