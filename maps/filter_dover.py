import geopandas as gpd

# load the lsoa boundaries
gdf = gpd.read_file('lsoa_boundaries_uk.geojson')

# get the county
gdf['County'] = gdf['LSOA21NM'].str.split(' ', expand=True)[0]

# filter out dover
dover = gdf[gdf['County']=='Dover']

# save
dover.to_file("lsoa_dover.geojson", driver='GeoJSON')
