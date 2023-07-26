library(magrittr)
library(sf)
## ---- boundary_extract_se --

# load in UK boundary data
Sys.setenv(OGR_GEOJSON_MAX_OBJ_SIZE = "1024MB")
ukbounds <- st_read('../data/uk_boundary.geojson')

sebounds <- ukbounds[ukbounds$nuts118nm=="South East (England)",]

out_fn <- "../data/southeast_boundary.geojson"
if(file.exists(out_fn)) {
   file.remove(out_fn)
}
st_write(sebounds, out_fn)
