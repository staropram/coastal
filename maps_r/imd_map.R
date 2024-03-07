## ---- plot_overview_map ----
source("imd_map_load_data.R")

library(tmap)
library(tmaptools)
library(sf)
library(dplyr)

#town_bbox <- st_convex_hull(places_towns_kent)
numRows <- nrow(imd)
fifthPercentile <- numRows*0.05
tenthPercentile <- numRows*0.1
if(!exists("england")) {
   england <- coast %>% filter(CTRY22NM=="England")
}
england_convex_hull <- st_convex_hull(england)
england_boundary <- st_boundary(england)

# filter out so they have to be near to cost

imd <- imd %>% arrange(desc(IMD_Rank))
imd$RevRank <- nrow(imd)-imd$IMD_Rank

#imd_coastal <- imd %>% filter(st_distance(imd,england_boundary)<5000)

imdTop10 <- imd[1:10,]
top10CH <- st_concave_hull(st_combine(st_centroid(imdTop10)),0.2)

# some of these are not valid

tmap_mode("view")
#osm_layer <- read_osm(town_bbox, ext=1.2,zoom=13,type="osm")

tmap_map <- tm_basemap("OpenStreetMap") + 
   tm_shape(imdTop10,name="imdTop10") + tm_borders(lwd=3,col="darkred") + # Kent boundary 
   tm_shape(top10CH,name="conv hull") + tm_borders(lwd=2,col="darkblue")   # Kent boundary
   #tm_shape(england,name="Coastal Boundary") + tm_borders(lwd=2,col="darkblue") +  # Kent boundary
   #tm_shape(england_convex_hull,name="Coastal convex hull") + tm_borders(lwd=2,col="orange") +  # Kent boundary
   #tm_shape(england_boundary,name="Coastal st boundary") + tm_borders(lwd=2,col="magenta")  # Kent boundary
   #tm_view(bbox=st_bbox(kent_boundary)) + # bound to kent
   #tm_shape(lsoa_2011_kent,name="LSOA 2011") + tm_polygons(alpha=0.6,col="LSOA11NMW",legend.show=F) + # LSOA
   #tm_shape(bua_2011_kent,name="BUA 2011") + tm_polygons(alpha=0.3,col="BUA11NM",legend.show=F,border.col="black",border.alpha=1) +# BUA
   #tm_shape(buasd_2011_kent,name="BUASD 2011") + tm_polygons(alpha=0.3,col="BUASD11NM",legend.show=F,border.col="black",border.alpha=1) +# BUASD
   #tm_shape(places_towns_kent,name="Town centroids (Kent)") + tm_dots(size=0.1) +  # Towns kent
   #tm_text(text="name1",bg.color="yellow",bg.alpha=1,size=1.1,ymod=1) +
   #tm_shape(places_towns_medway,name="Town centroids (Medway)") + tm_dots(size=0.1) +  # Towns medway
   #tm_text(text="name1",bg.color="white",bg.alpha=1,size=1.1,ymod=1) # towns


print(tmap_map)

# tmap_save(tmap_map,"outputs/imd_map.html")
