library(sf)
library(data.table)
library(tmap)
library(tmaptools)
library(dplyr)
# https://osdatahub.os.uk/downloads/open/OpenNames

graphics.off()
tmap_mode("plot")

# Function to calculate the area of a bounding box
calculate_bbox_area <- function(bbox_wgs84) {
  # Create a simple feature geometry from the bounding box
  bbox_geom <- st_as_sfc(bbox_wgs84)
  
  # Identify an appropriate UTM zone based on the centroid of the bounding box
  utm_zone <- floor((st_coordinates(st_centroid(bbox_geom))[1] + 186) / 6)
  
  # Create a UTM CRS string
  utm_crs_str <- paste0("+proj=utm +zone=", utm_zone, " +ellps=WGS84 +datum=WGS84 +units=m +no_defs")
  
  # Reproject to the identified UTM zone
  bbox_utm <- st_transform(bbox_geom, crs = utm_crs_str)
  
  # Calculate and return the area in square meters
  return(as.numeric(st_area(bbox_utm)))
}

c1 <- c(1.008167,51.278347,1.217766,51.378638)
c2 <- c(1.002674,51.313018,1.206264,51.382710)
c3 <- c(1.076145,51.335224,1.181545,51.377352)
hb_bbox <- matrix(c3,ncol=2)

# zoomed in version of herne bay
osm_layer <- read_osm(hb_bbox, zoom=13,ext=1.2,type="osm")

wgsdots <- st_transform(places_towns_southeast,st_crs(osm_layer))
tmap_map <- 
      tm_shape(osm_layer) + 
      tm_rgb() +
      tm_shape(wgsdots) +
      tm_dots(size=0.5) +
      tm_text(text = "name1",ymod=1)
print(tmap_map)
tmap_save(tmap_map,"figures/hb_close.png")

# herne bay with the unparished area


