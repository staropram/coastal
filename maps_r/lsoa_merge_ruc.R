library(sf)
library(stringr)

## ---- lsoa_merge_ruc ----

# load the rural-urban classes
ruc <- fread('../data/lsoa_rural_urban_classifications_2011.csv')
setkey(ruc,"LSOA11CD")

# load the LSOA boundaries for dover
lsoa_dover <- data.table(st_read("../data/lsoa_boundaries_dover_2011.geojson"))
setkey(lsoa_dover,"LSOA11CD")

# join together
lsoa_dover_plus_ruc <- lsoa_dover[ruc,nomatch=NULL]
# drop the duplicate cols
lsoa_dover_plus_ruc[, grep("^i\\.", names(lsoa_dover_plus_ruc), value=TRUE) := NULL]

# save the merger
out_fn <-  "../data/lsoa_boundaries_dover_2011_plus_ruc.geojson"
if(file.exists(out_fn)) {
   file.remove(out_fn)
}
st_write(lsoa_dover_plus_ruc, out_fn)
