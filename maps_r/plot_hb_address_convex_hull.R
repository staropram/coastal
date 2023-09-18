library(tmap)
library(tmaptools)
library(data.table)
library(sf)
library(dplyr)
source("helper_functions.R")


if(!exists("ads")) {
   ads <- fread("../../data/addressbasecore/AddressBaseCore_FULL_2021-09-09_001.csv")
}

hb_ads_csv <- ads[TOWN_NAME=="HERNE BAY"]
hb_ads <- st_as_sf(hb_ads_csv, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)
hb_boundary <- st_convex_hull(st_combine(hb_ads))

bc_ads_csv <- ads[TOWN_NAME=="BIRCHINGTON"]
bc_ads <- st_as_sf(bc_ads_csv, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)
bc_boundary <- st_convex_hull(st_combine(bc_ads))

acol_ads <- bc_ads %>% filter(grepl("ACOL",SINGLE_LINE_ADDRESS))
acol_boundary <- st_convex_hull(st_combine(acol_ads))

whits_ads_csv <- ads[TOWN_NAME=="WHITSTABLE"]
whits_ads <- st_as_sf(whits_ads_csv, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)
whits_boundary <- st_convex_hull(st_combine(whits_ads))

tmap_mode("plot")
graphics.off()
dev.new()

hb_and_whits_bbox_vec <- c(0.994778,51.315057,1.184292,51.378853)
hb_and_whits_bbox <- bbox_vector_to_st_bbox(hb_and_whits_bbox_vec,4326)


#topcoast_bbox_vec <- c(0.983620,51.265352,1.459122,51.397492)
topcoast_bbox_vec <- c(0.983620,51.304648,1.375351,51.392779)
topcoast_bbox <- bbox_vector_to_st_bbox(topcoast_bbox_vec,4326)

#osm_hb <- read_osm(hb_and_whits_bbox, ext=1.6,zoom=11,type="osm")


plot_hb_zoomed_convex_hull <- function() {
   osm_hb <- read_osm(hb_boundary, zoom=12, ext=1.3)
   tmap_map <- 
         tm_shape(osm_hb) + 
         tm_rgb() + 
         tm_shape(hb_boundary) + 
         tm_polygons(labels=c("pop"),fill=NA,alpha=0,legend.show=F,lwd=3,border.col="darkred") +
         tm_shape(filtered_parishes) + 
         tm_borders(lwd=3,lty="dotted") +
         tm_text(text="ShortName",bg.color="white",size=1.2) +
         tm_shape(hb_centroid) +
         tm_dots(size=1.5) +
         tm_text(text="name",size=1.5,ymod=2) 
   print(tmap_map)
   tmap_save(tmap_map,"figures/hb_convex.png")
}

plot_hb_and_others_convex_hull <- function() {
   osm_hb <- read_osm(topcoast_bbox, zoom=11, ext=1.0)
   tmap_map <- 
         tm_shape(osm_hb) + 
         tm_rgb() + 
         tm_shape(hb_boundary) + 
         tm_polygons(labels=c("pop"),fill=NA,alpha=0,legend.show=F,lwd=3,border.col="darkred") +
         tm_shape(bc_boundary) + 
         tm_polygons(labels=c("pop"),fill=NA,alpha=0,legend.show=F,lwd=3,border.col="magenta") +
         tm_shape(whits_boundary) + 
         tm_polygons(labels=c("pop"),fill=NA,alpha=0,legend.show=F,lwd=3,border.col="darkgreen") +
         #tm_shape(filtered_parishes) + 
         #tm_borders(lwd=3,lty="dotted") +
         #tm_text(text="ShortName",bg.color="white",size=1.2) +
         tm_shape(hb_centroid) +
         tm_dots(size=0.5) +
         tm_text(text="name",size=1,ymod=1) 
   print(tmap_map)
   tmap_save(tmap_map,"figures/hb_and_others-convex.png")
}

#plot_hb_zoomed_convex_hull()
plot_hb_and_others_convex_hull()
