library(sf)
library(stringr)

## ---- lsoa_extract_dover ----

# load the boundary data
lsoa_boundaries <- data.table(st_read('../data/lsoa_boundaries_2011.geojson'))

# extract the region from the data
lsoa_boundaries$region <- str_split(lsoa_boundaries_2011$LSOA11NM, ' ', simplify = TRUE)[,1]

# extract dover
lsoa_boundaries_dover <- lsoa_boundaries[region=="Dover"]

# delete the output file if it already exists
output_fn <- "../data/lsoa_boundaries_dover_2011.geojson"
if(file.exists(output_fn)) {
   file.remove(output_fn)
}

# write the dover data
st_write(lsoa_boundaries_dover, "../data/lsoa_boundaries_dover_2011.geojson")
