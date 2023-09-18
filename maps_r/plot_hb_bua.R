library(tmap)
library(tmaptools)
library(data.table)
library(sf)
library(dplyr)
source("helper_functions.R")

# load in HB built up areas
hb_bua <- st_read("../data/hb_bua.geojson")

tmap_mode("plot")
graphics.off()
dev.new()

c3 <- c(1.076145,51.335224,1.181545,51.377352)
hb_bbox <- matrix(c3,ncol=2)
hb_and_whits_bbox <-matrix(c(0.979671,51.329325,1.205578,51.384531),ncol=2)


osm_hb <- read_osm(hb_bbox, zoom=13, ext=1.2)
plot_hb_bua <- function() {
   tmap_map <- 
         tm_shape(osm_hb) + 
         tm_rgb() + 
         tm_shape(hb_bua) +
         tm_polygons(labels=c("pop"),fill=NA,alpha=0,legend.show=F,lwd=3,border.col="darkred")+ 
         tm_shape(hb_centroid) +
         tm_dots(size=1.5) +
         tm_text(text="name",size=1.5,ymod=2) 
   print(tmap_map)
   tmap_save(tmap_map,"figures/hb_bua.png")
}

osm_hb_and_whits <- read_osm(hb_and_whits_bbox, zoom=12, ext=1)
plot_hb_and_whits_bua <- function() {
   tmap_map <- 
         tm_shape(osm_hb_and_whits) + 
         tm_rgb() + 
         tm_shape(hb_bua) +
         tm_polygons(labels=c("pop"),fill=NA,alpha=0,legend.show=F,lwd=3,border.col="darkred")+ 
         tm_shape(hb_centroid) +
         tm_dots(size=1.2) +
         tm_text(text="name",size=1.2,ymod=1.5) 
   print(tmap_map)
   tmap_save(tmap_map,"figures/hb_and_whits_bua.png")
}
#plot_hb_bua()
plot_hb_and_whits_bua()
