library(magrittr)
library(sf)
## ---- boundary_extract_se --

# using data from http://www.diva-gis.org/gdata

# load in UK boundary data
Sys.setenv(OGR_GEOJSON_MAX_OBJ_SIZE = "1024MB")
ukbounds <- st_read("../data/gbr_adm/GBR_adm0.shp")

# load in the county bounds
countybounds <- st_read("../data/gbr_adm/GBR_adm2.shp")
# and extract Kent
kentbounds <- countybounds[countybounds$NAME_2=="Kent",]

kentbox <- st_as_sfc(st_bbox(kentbounds))

# cro
kentcoast <- st_crop(ukbounds,kentbox)
#kentcoast2 <- st_difference(kentcoast,kentbox)
#kcmap <- tm_basemap("OpenStreetMap") + tm_shape(kentbox) + tm_borders(lwd=2,col="red")

plot(kcmap)




#sebounds <- ukbounds[ukbounds$nuts118nm=="South East (England)",]

#out_fn <- "../data/southeast_boundary.geojson"
#if(file.exists(out_fn)) {
#   file.remove(out_fn)
#}
#st_write(sebounds, out_fn)
