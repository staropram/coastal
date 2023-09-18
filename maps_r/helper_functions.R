# http://bboxfinder.com/#51.050891,1.043701,51.400062,1.468735
# format is LNG-min,LAT-min,LNG-max,LAT-max
# x is lat, y is lng
bbox_vector_to_st_bbox <- function(bbox_vector,crs) {
   names(bbox_vector) <- c("xmin","ymin","xmax","ymax")

   bbox_st <- st_bbox(bbox_vector,crs=crs)
   bbox_sfc <- st_as_sfc(bbox_st)
   st_transform(bbox_sfc,crs=27700)
}
