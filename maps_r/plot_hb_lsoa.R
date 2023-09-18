library(sf)
library(stringr)
library(data.table)
library(tmap)
library(tmaptools)
#library(OpenStreetMap)

# load LSOA
if(!exists("lsoa_boundaries")) {
   lsoa_boundaries <- st_read('../data/lsoa_boundaries_2011.geojson',quiet=T)
}

# load hb_bua

buasd <- st_read("../data/Built_up_Area_Sub_Divisions_Dec_2011_Boundaries.gpkg",quiet=T)

hb_buasd <- buasd[buasd$BUASD11NM=="Herne Bay BUASD",]

hb_boundary <- st_convex_hull(hb_buasd)
hb_centroid_geom <- st_sfc(st_point(c(617695,168218)),crs=27700)
hb_centroid <- st_sf(data.frame(name = "Herne Bay"), geometry = hb_centroid_geom)

# Get the rows in lsoa_boundaries that intersect with hb_buasd
#hb_lsoas <- st_intersection(lsoa_boundaries,hb_buasd)
hb_lsoas_idx <- st_intersects(lsoa_boundaries,hb_buasd,sparse=F)
hb_lsoas <- lsoa_boundaries[hb_lsoas_idx,]

hb_lsoas$geometry[5] <- st_union(st_collection_extract(hb_lsoas$geometry[5]))
fillCol <- as.character(sample(colors(),nrow(hb_lsoas)))
names(fillCol) <- as.character(hb_lsoas$FID)
hb_lsoas$dummy <- as.character(hb_lsoas$FID)
hb_lsoas$geometry <- st_cast(hb_lsoas$geometry,"MULTIPOLYGON")

graphics.off()

osm_hb <- read_osm(hb_boundary, zoom=13, ext=1.4)
plot_hb_buasd_and_lsoa <- function() {
   tmap_map <- 
         tm_shape(osm_hb) + 
         tm_rgb() + 
         #tm_shape(hb_lsoas[st_geometry_type(hb_lsoas)=="MULTIPOLYGON",]) + 
         tm_shape(hb_lsoas) +
         tm_polygons(col="dummy",legend.show=F,lwd=1.5,border.col="darkgreen")  +
         tm_shape(hb_buasd) + 
         tm_polygons(fill=NA,alpha=0,legend.show=F,lwd=4,border.col="darkred") +
         #tm_shape(hb_lsoas[st_geometry_type(hb_lsoas)=="POLYGON",]) + 
         #tm_polygons(fill=NA,alpha=0,legend.show=F,lwd=1.5,border.col="darkgreen") 
         tm_shape(hb_centroid) +
         tm_dots(size=0.5) +
         tm_text(text="name",size=1,ymod=2) 
   print(tmap_map)
   tmap_save(tmap_map,"figures/hb_bua_lsoas.png")
}
plot_hb_buasd_and_lsoa()
