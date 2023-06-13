import pandas as pd
import geopandas as gpd
dover = gpd.read_file("lsoa_boundaries_dover_2011.geojson")
urban = pd.read_csv("lsoa_rural_urban_classifications_2011.csv")
# do a left join on our dover data, note ONS has not published 2021 classifications yet
# so the urban column is "LSOA11CD"
dover = dover.merge(urban,on=["LSOA11CD","LSOA11NM"],how="left")

# map the class to a colour
urban_color_map = {
    'Rural village and dispersed' : '#77dd77',
    'Rural town and fringe' : '#fdfd96',
    'Urban city and town' : '#ffb347',
}

dover['urban_color_map'] = dover.RUC11.map(urban_color_map)

