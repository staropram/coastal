library(sf)
library(data.table)
library(tmap)
library(tmaptools)
library(dplyr)
library(osmdata)
library(OpenStreetMap)

# load in counties
if(!exists("counties")) {
   counties <- st_read("../data/counties.gpkg")
}

# extract and save kent
kent_boundary <- counties[counties$CTY23NM=="Kent",]
st_write(kent_boundary,"../data/kent_boundary.gpkg",append=F)

# load in LSOA boundaries (use the 20m resolution)
if(!exists("lsoa")) {
   lsoa <- st_read("../data/lsoa_2011_20m.gpkg")
}

# load in BUA boundaries
if(!exists("bua")) {
   bua <- st_read('../data/bua_2011.gpkg')
}

# extract BUA in Kent and write
bua_kent_idx <- which(st_intersects(bua,kent_boundary,sparse=F))
bua_kent <- bua[bua_kent_idx,]
st_write(bua_kent,"../data/bua_2011_kent.gpkg",append=F)

# load in place names
if(!exists("places")) {
   places <- st_read("../data/opname_gb.gpkg")
   places_towns <- places[places$local_type=="Town",]
}

# extract towns in kent
places_towns_kent <- places_towns[places_towns$county_unitary=="Kent",]
st_write(places_towns_kent,"../data/places_towns_kent.gpkg",append=F)


#crop_data_to_bbox
