# load in BUA data
bua <- data.table(st_read('../data/bua_2011.geojson'))

bua_hb <- bua[BUA11NM=="Herne Bay/Whitstable BUA"]

out_fn <- "../data/hb_bua.geojson"
if(file.exists(out_fn)) {
   file.remove(out_fn)
}
st_write(bua_hb,out_fn)

bua_dover_precise <- bua[BUA11NM=="Dover BUA"]
out_fn <- "../data/dover_bua_precise.geojson"
if(file.exists(out_fn)) {
   file.remove(out_fn)
}
st_write(bua_dover_precise,out_fn)
