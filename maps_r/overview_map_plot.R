## ---- plot_overview_map ----
source("overview_map_load_data.R")

library(tmap)
library(tmaptools)
library(sf)

town_bbox <- st_convex_hull(places_towns_kent)

tmap_mode("view")
#osm_layer <- read_osm(town_bbox, ext=1.2,zoom=13,type="osm")

tmap_map <- tm_basemap("OpenStreetMap") + 
   #tm_view(bbox=st_bbox(kent_boundary)) + # bound to kent
   tm_shape(kent_boundary,name="Kent Boundary") + tm_borders(lwd=3,col="darkblue") + # Kent boundary
   tm_shape(medway_boundary,name="Medway Boundary") + tm_borders(lwd=3,col="darkred") + # Medway boundary
   tm_shape(lsoa_2011_kent,name="LSOA 2011") + tm_polygons(alpha=0.6,col="LSOA11NMW",legend.show=F) + # LSOA
   tm_shape(bua_2011_kent,name="BUA 2011") + tm_polygons(alpha=0.3,col="BUA11NM",legend.show=F,border.col="black",border.alpha=1) +# BUA
   tm_shape(buasd_2011_kent,name="BUASD 2011") + tm_polygons(alpha=0.3,col="BUASD11NM",legend.show=F,border.col="black",border.alpha=1) +# BUASD
   tm_shape(places_towns_kent,name="Town centroids (Kent)") + tm_dots(size=0.1) +  # Towns kent
   tm_text(text="name1",bg.color="yellow",bg.alpha=1,size=1.1,ymod=1) +
   tm_shape(places_towns_medway,name="Town centroids (Medway)") + tm_dots(size=0.1) +  # Towns medway
   tm_text(text="name1",bg.color="white",bg.alpha=1,size=1.1,ymod=1) # towns


print(tmap_map)
tmap_save(tmap_map,"outputs/overview_map.html")
