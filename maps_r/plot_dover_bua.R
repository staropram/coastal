## ---- plot_dover_bua ----

library(tmap)
library(sf)

# load in buas in dover
bua_dover <- st_read("../data/bua_in_dover.geojson",quiet=T)

# increase max.categories otherwise we can only show a few different boundaries
tmap_options(max.categories=100)
tmap_mode("view")

# create the map
tmap_map <- tm_basemap("OpenStreetMap") +
       tm_shape(bua_dover) + 
       tm_polygons("BUA11NM",alpha=0.5,legend.show=F)
tmap_map

## ---- not eval by markdown ---- 
print(tmap_map)
