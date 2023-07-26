## ---- plot_se_bounds ----

library(tmap)
library(sf)

# load in the southeast boundaries
sebounds <- st_read("../data/southeast_boundary.geojson")

tmap_mode("view")

# create the map
se_bounds_map <- tm_basemap("OpenStreetMap") +
       tm_shape(sebounds) +
       tm_borders(lwd=2,col="red")
se_bounds_map
