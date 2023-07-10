## ---- plot_dover_lsoa ----

library(tmap)
library(sf)

# load in the LSOA boundaries
lsoa_dover_geojson_fn <- "../data/lsoa_boundaries_dover_2011.geojson"
# convert it to Simple Features object
dover_sf <- st_read(lsoa_dover_geojson_fn,quiet=T)

# increase max.categories otherwise we can only show a few different boundaries
tmap_options(max.categories=100)
tmap_mode("view")

# create the map
tmap_map <- tm_basemap("OpenStreetMap") +
       tm_shape(dover_sf) + 
       tm_polygons("LSOA11CD",alpha=0.5,legend.show=F)
tmap_map
