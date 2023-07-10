library(tmap)
library(sf)

## ---- plot_dover_lsoa_plus_ruc ----

# load in the LSOA boundaries with the RUC labels
dover_plus_ruc <- "../data/lsoa_boundaries_dover_2011_plus_ruc.geojson"
# convert it to Simple Features object
dover_sf <- st_read(dover_plus_ruc,quiet=T)

# increase max.categories otherwise we can only show a few different boundaries
tmap_options(max.categories=100)
tmap_mode("view")

# create the map
tmap_map <- tm_basemap("OpenStreetMap") +
       tm_shape(dover_sf) + 
       tm_polygons("RUC11",alpha=0.5,legend.show=T)
tmap_map
