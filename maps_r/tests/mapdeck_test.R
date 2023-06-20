library(mapdeck)
library(geojsonsf)
lsoa_dover_geojson_fn <- "../../data/lsoa_boundaries_dover_2011.geojson"

dover_sf <- read_sf(lsoa_dover_geojson_fn)
dover_sf_latlon <- st_transform(dover_sf, 4326)

key <- readLines("../mapbox_key.txt")

mapdeck_map <- mapdeck(token = key) %>% 
   add_polygon(
      data = dover_sf_latlon,
      layer_id = "Dover LSOAs",
      fill_opacity=0.5
   )
#print(mapdeck_map)
