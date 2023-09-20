library(sf)
library(data.table)
library(tmap)
library(tmaptools)
library(dplyr)
library(osmdata)
library(OpenStreetMap)

# load in counties
if(!exists("counties")) {
   counties <- st_read("../data/counties_and_unitary_20m.gpkg")
}

# extract and save kent
kent_boundary <- counties[counties$CTYUA23NM=="Kent",]
st_write(kent_boundary,"../data/kent_boundary.gpkg",append=F)
medway_boundary <- counties[counties$CTYUA23NM=="Medway",]
st_write(medway_boundary,"../data/medway_boundary.gpkg",append=F)
kent_and_medway_boundary <- st_union(kent_boundary,medway_boundary)

# load in LSOA boundaries (use the 20m resolution)
if(!exists("lsoa_2011")) {
   lsoa_2011 <- st_read("../data/lsoa_2011_20m.gpkg")
}
# (!) allow to spill out the boundary with Kent and Medway
lsoa_2011_kent_idx <- which(st_intersects(lsoa_2011,kent_and_medway_boundary,sparse=F))
lsoa_2011_kent <- lsoa_2011[lsoa_2011_kent_idx,]
st_write(lsoa_2011_kent,"../data/lsoa_2011_kent.gpkg",append=F)

# load in BUA boundaries
if(!exists("bua")) {
   bua <- st_read('../data/bua_2011.gpkg')
}

# extract BUA in Kent and write
# (!) clip to boundary with Kent and Medway
bua_2011_kent <- st_intersection(bua,kent_and_medway_boundary)
st_write(bua_2011_kent,"../data/bua_2011_kent.gpkg",append=F)

# load in BUASD boundaries
if(!exists("buasd_2011")) {
   buasd_2011 <- st_read('../data/buasd_2011.gpkg')
}
# extract BUASD in Kent and write
# (!) clip to boundary with Kent and Medway
buasd_2011_kent <- st_intersection(buasd_2011,kent_and_medway_boundary)
st_write(buasd_2011_kent,"../data/buasd_2011_kent.gpkg",append=F)

# load in place names
if(!exists("places")) {
   places <- st_read("../data/opname_gb.gpkg")
   places_towns <- places[places$local_type=="Town",]
}

# extract towns in kent
places_towns_kent <- places_towns[places_towns$county_unitary=="Kent",]
st_write(places_towns_kent,"../data/places_towns_kent.gpkg",append=F)


#crop_data_to_bbox
