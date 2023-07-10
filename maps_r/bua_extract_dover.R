## ---- bua_extract_dover --

# load in BUA data
bua <- st_read('../data/bua_2011.geojson')

# and the RUC labelled LSOA data
lsoa <- st_read("../data/lsoa_boundaries_dover_2011_plus_ruc.geojson")

# do an st_join to find the BUAs that intersect the LSOAs
bua_lsoa <- st_join(bua, lsoa, join = st_intersects,left=F)

# save these
out_fn <- "../data/bua_in_dover.geojson"
if(file.exists(out_fn)) {
   file.remove(out_fn)
}
st_write(bua_lsoa,out_fn)
