library(leaflet)
library(geojsonio)
library(sf)
library(rgdal)

# Read the GeoJSON data
lsoa_dover_geojson_fn <- "../../data/lsoa_boundaries_dover_2011.geojson"

# load GeoJSON in as SpatialPolgons
dover_sp <- geojsonio::geojson_read(lsoa_dover_geojson_fn, what = "sp") 

# define latlon CRS
latlon <- CRS("+init=epsg:4326")

# Transform the object to lat/lon
dover_latlon <- spTransform(dover_sp, latlon)

# Calculate the bounding box
bbox_sp <- sp::bbox(dover_latlon)

# Create the leaflet map
leaflet_map <- leaflet() %>%
   addTiles() %>%
   addPolygons(data=dover_latlon) %>%
   fitBounds(bbox_sp[1, 1], bbox_sp[2, 1], bbox_sp[1, 2], bbox_sp[2, 2])

# Print the map
#print(leaflet_map)
