library(sf)
library(tmap)

# load in kent admin boundary as useful
kent_admin_boundary <- st_read("../data/kent_boundary.gpkg")

# define national grid CRS
national_grid_crs <- st_crs(kent_admin_boundary)

# load in kentish towns
kent_towns <- st_read("../data/places_towns_kent.gpkg")
# remove empty points
kent_towns <- kent_towns[!st_is_empty(kent_towns),]

# load in coastal boundary, project to national grid CRS
if(!exists("coastal_boundary")) {
   coastal_boundary <- st_transform(st_read("../data/gbr_adm/GBR_adm0.shp"),crs=national_grid_crs)
}

# make a boundary just for kent to make things quicker (this needs improving to remove the bbox sides
kent_bbox <- st_as_sfc(st_bbox(kent_admin_boundary))
kent_bounds <- st_intersection(coastal_boundary,kent_bbox)

# measure distance between towns and kent_bounds
# note we take st_boundary of kent_bounds to get a multilinestring
# if we use a polygon then any point inside the polygon is considered to have a distance of 0
kent_towns$distance_to_coast <- round(st_distance(kent_towns,st_boundary(kent_bounds)),digits=1)
kent_towns$lab <- paste0(kent_towns$name1," (",kent_towns$distance_to_coast,")")

tmap_map <- tm_basemap("OpenStreetMap") + 
   #tm_view(bbox=st_bbox(kent_admin_boundary)) + # bound to kent
   tm_shape(kent_bounds,name="Kent Boundary") + tm_borders(lwd=3,col="darkblue")  + # Kent boundary
   tm_shape(kent_towns,name="Town centroids") + tm_dots(size=0.25) +  # Towns
   tm_text(text="name1",bg.color="red",bg.alpha=1,size=1.1,ymod=1) + # towns
   tm_text(text="lab",col="darkred",size=2,ymod=4)  # distance

