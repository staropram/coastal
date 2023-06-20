import geopandas as gpd

# load the lsoa boundaries
gdf = gpd.read_file('../data/bua_2011.geojson')

# get the county
#gdf['County'] = gdf['LSOA11NM'].str.split(' ', expand=True)[0]

# filter out dover
#dover = gdf[gdf['County']=='Dover']

# save
#dover.to_file("lsoa_boundaries_dover_2011.geojson", driver='GeoJSON')
