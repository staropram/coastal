library(mapview)
library(sf)
lsoa_dover_geojson_fn <- "../../data/lsoa_boundaries_dover_2011.geojson"

geojson_sf <- st_read(lsoa_dover_geojson_fn)

mapview_map <- mapview(geojson_sf)
