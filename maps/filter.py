import geopandas as gpd

# load the lsoa boundaries
ipython = get_ipython()
if 'gdf' not in ipython.user_ns:
   ipython.user_ns['gdf'] = gpd.read_file('lsoa_boundaries_uk.geojson')

gdf = ipython.user_ns['gdf']

# get the county
gdf['County'] = gdf['LSOA21NM'].str.split(' ', expand=True)[0]

# approx easting of Canterbury centre
canterbury_easting = 614917 
# approx northing of sheerness
sheerness_northing = 174740

# compute the centroid of each LSOA
gdf['centroid'] = gdf.geometry.centroid

# save the LSOAs with a centroid east of canterbury, south of southend
thanet_rough = gdf[(gdf['centroid'].x > canterbury_easting) & (gdf['centroid'].y < sheerness_northing)]
thanet_rough = thanet_rough.drop(columns=['centroid'])

# LSOAs that are equate to approximately thanet
thanet_rough.to_file('lsoa_boundaries_thanet_rough.geojson', driver='GeoJSON')

