library(sf)
library(data.table)
library(tmap)
library(tmaptools)
library(dplyr)
library(osmdata)
library(OpenStreetMap)

# load in the boundary data
boundary_datasource <- "../data/bdline/Data/bdline_gb.gpkg"
   boundary_layers <- st_layers(boundary_datasource)
if(!exists("boundary_unitary_ward")) {
   boundary_unitary_ward <- st_read(boundary_datasource,"district_borough_unitary_ward")
   boundary_parish <- st_read(boundary_datasource,"parish")
}

# http://bboxfinder.com/#51.050891,1.043701,51.400062,1.468735
# format is LNG-min,LAT-min,LNG-max,LAT-max
# x is lat, y is lng
bbox_vector_to_st_bbox <- function(bbox_vector,crs) {
   names(bbox_vector) <- c("xmin","ymin","xmax","ymax")

   bbox_st <- st_bbox(bbox_vector,crs=crs)
   bbox_sfc <- st_as_sfc(bbox_st)
   st_transform(bbox_sfc,crs=27700)
}

# filter out only those within our bounding box for southeast
se_bbox_vec <- c(1.043701,51.050891,1.468735,51.400062)
se_bbox <- bbox_vector_to_st_bbox(se_bbox_vec,4326)

se_bbox_big_vec <- c(0.719604,50.888308,1.490021,51.467697)
se_bbox_big <- bbox_vector_to_st_bbox(se_bbox_big_vec,4326)

hb_bbox_vec <- c(1.076145,51.335224,1.181545,51.377352)
hb_bbox <- bbox_vector_to_st_bbox(hb_bbox_vec,4326)

hb_and_whits_bbox_vec <- c(0.994778,51.315057,1.184292,51.378853)
hb_and_whits_bbox <- bbox_vector_to_st_bbox(hb_and_whits_bbox_vec,4326)

hb_centroid_geom <- st_sfc(st_point(c(617695,168218)),crs=27700)
hb_centroid <- st_sf(data.frame(name = "Herne Bay"), geometry = hb_centroid_geom)

filtered_unitary_wards <- st_intersection(boundary_unitary_ward,se_bbox)
filtered_unitary_wards$ShortName <- gsub("Ward","",filtered_unitary_wards$Name)

filtered_parishes <- st_intersection(boundary_parish,se_bbox_big)
filtered_parishes$ShortName <- gsub(" CP","",filtered_parishes$Name)

plot_wards <- function() {
   # tmap
   graphics.off()
   tmap_mode("plot")
   osm_layer <- read_osm(hb_bbox, ext=1.2,zoom=13,type="osm")

   tmap_map <- 
         tm_shape(osm_layer) + 
         tm_rgb() +
         tm_shape(filtered_unitary_wards) + 
         tm_borders(lwd=3) +
         tm_text(text="ShortName",bg.color="white",size=1.5) +
         tm_shape(hb_centroid) +
         tm_dots(size=1.5) +
         tm_text(text="name",size=2,ymod=2) 
   print(tmap_map)
   tmap_save(tmap_map,"figures/hb_wards.png")
}

plot_parishes <- function() {
   # tmap
   graphics.off()
   tmap_mode("plot")
   osm_layer <- read_osm(hb_and_whits_bbox, ext=1.6,zoom=11,type="osm")

   tmap_map <- 
         tm_shape(osm_layer) + 
         tm_rgb() +
         tm_shape(filtered_parishes) + 
         tm_borders(lwd=3) +
         tm_text(text="ShortName",bg.color="white",size=1.1) +
         tm_shape(hb_centroid) +
         tm_dots(size=1.5) +
         tm_text(text="name",size=2,ymod=2) 
   print(tmap_map)
   tmap_save(tmap_map,"figures/hb_unparished.png")
}
plot_wards()
plot_parishes()
