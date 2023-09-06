library(tmap)
library(tmaptools)
library(data.table)
library(sf)


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

tmap_mode("plot")
graphics.off()
dev.new()

#osm_hb <- read_osm(hb_boundary, ext=1.1)

tmap_map <- 
      tm_shape(osm_hb) + 
      tm_rgb() + 
      tm_shape(hb_boundary) + 
      tm_polygons(labels=c("pop"),fill=NA,alpha=0.5,legend.show=F) +
      tm_shape(bc_boundary) + 
      tm_polygons(labels=c("pop"),fill=NA,alpha=0.5,legend.show=F) +
      tm_shape(acol_boundary) + 
      tm_polygons(labels=c("pop"),fill=NA,alpha=0.5,legend.show=F) +
      tm_basemap("OpenStreetMap")
print(tmap_map)
