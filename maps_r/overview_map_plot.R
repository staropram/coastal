## ---- plot_overview_map ----
source("overview_map_load_data.R")

library(tmap)
library(sf)

town_bbox <- st_convex_hull(places_towns_kent)

tmap_mode("view")
#osm_layer <- read_osm(town_bbox, ext=1.2,zoom=13,type="osm")

tmap_map <- tm_basemap("OpenStreetMap") + 
   tm_view(bbox=st_bbox(kent_boundary)) + # bound to kent
   tm_shape(kent_boundary,name="Kent Boundary") + tm_borders(lwd=3) + # kent boundary
   tm_shape(places_towns_kent,name="Town centroids") + tm_dots() + #+ tm_text(text="name1",bg.color="white",bg.alpha=0,size=1.1,ymod=1.2) # towns
   tm_shape(bua_2011_kent,name="BUA 2011") + tm_polygons()


print(tmap_map)
