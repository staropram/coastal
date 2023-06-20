library(tmap)
library(sf)

lsoa_dover_geojson_fn <- "../../data/lsoa_boundaries_dover_2011.geojson"
dover_sf <- st_read(lsoa_dover_geojson_fn)

tmap_options(max.categories=100)
tmap_mode("view") 

tmap_map <- tm_basemap("OpenStreetMap") +
       tm_shape(dover_sf) + 
       tm_polygons("LSOA11CD",alpha=0.5,legend.show=F)
