import geopandas as gpd

# load the lsoa boundaries
gdf = gpd.read_file('../data/lsoa_boundaries_2011.geojson')

# get the county
gdf['Region'] = gdf['LSOA11NM'].str.split(' ', expand=True)[0]

# filter out dover
dover = gdf[gdf['Region']=='Dover']

# save
dover.to_file("../data/lsoa_boundaries_dover_2011.geojson", driver='GeoJSON')
