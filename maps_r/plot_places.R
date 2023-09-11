library(sf)
library(data.table)
library(tmap)
library(tmaptools)
library(dplyr)
library(osmdata)
library(OpenStreetMap)
# https://osdatahub.os.uk/downloads/open/OpenNames
places_cities_southeast <- st_read("../data/places_cities_southeast.gpkg")
places_towns_southeast <- st_read("../data/places_towns_southeast.gpkg")
places_villages_southeast <- st_read("../data/places_villages_southeast.gpkg")
places_settlement_southeast <- st_read("../data/places_settlement_southeast.gpkg")

town_bounds <- places_towns_southeast %>% dplyr::filter(grepl("Whitstable|Broadstairs|Margate|Hythe",name1))
se_hull <- st_convex_hull(st_union(town_bounds))
se_hull_wgs84 <- st_transform(se_hull,crs=4326)
se_hull_wgs84_bbox <- st_bbox(se_hull_wgs84)
se_hull_overpass_bbox <- matrix(c(se_hull_wgs84_bbox['xmin'], se_hull_wgs84_bbox['ymin'], se_hull_wgs84_bbox['xmax'], se_hull_wgs84_bbox['ymax']), ncol = 2)

# can view all map tiles here: https://mc.bbbike.org/mc/?lon=13.368594&lat=52.459748&zoom=10&num=2&mt0=osm-no-labels&mt1=mapnik&marker=

plottype = "raster"
if(plottype=="web") {
   tmap_mode("view")
   tmap_map <- tm_basemap("OpenStreetMap") +
         tm_shape(places_towns_southeast) +
          tm_dots(labels="name1")
   print(tmap_map)
} else if(plottype=="raster") {
   graphics.off()
   tmap_mode("plot")

   osm_layer <- read_osm(se_hull, ext=1.2,zoom=11,type="osm")

   wgsdots <- st_transform(places_towns_southeast,st_crs(osm_layer))
   tmap_map <- 
         tm_shape(osm_layer) + 
         tm_rgb() +
         tm_shape(wgsdots) +
         tm_dots(size=0.5) +
			tm_text(text = "name1",ymod=1)
   print(tmap_map)
	tmap_save(tmap_map,"figures/se_towns.png")
} else if(plottype=="vector") {
	
	se_hull_osm_query <- opq(bbox = se_hull_overpass_bbox) %>% 
		add_osm_feature(key = 'highway') %>%  # for roads
		add_osm_feature(key = 'natural', value = 'water')   # for water bodies
	se_hull_osm <- se_hull_osm_query %>% osmdata_sf()

   graphics.off()
   tmap_mode("plot")
	tmap_map <- tm_shape(se_hull_osm$osm_lines) + 
		tm_lines(col = "grey30") #+ 
		#tm_shape(se_hull_osm$osm_polygons) +
		#tm_polygons(col = "blue", filter = "natural == 'water'")
	print(tmap_map)
} else if(plottype=="test") {
	# Define bounding box for Canterbury, UK
	upperLeft <- c(51.3, 1.05)
	lowerRight <- c(51.25, 1.15)

	'https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png'

	# Fetch the map using OpenStreetMap package
	osm_map <- openmap(upperLeft, lowerRight, type = "osm")


	# Convert to raster for plotting with tmap
	osm_raster <- as.raster(osm_map)

	# Plot using tmap
	mappy <- tm_shape(osm_raster) + 
	  tm_raster()
	print(mappy)

}
