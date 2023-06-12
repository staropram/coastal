import pandas as pd
import geopandas as gpd
dover = gpd.read_file("lsoa_dover.geojson")
urban = pd.read_csv("LSOA_Rural_Urban_Classifications.csv")
# do a left join on our dover data, note ONS has not published 2021 classifications yet
# so the urban column is "LSOA11CD"
dover = dover.merge(urban,left_on="LSOA21CD",right_on="LSOA11CD",how="left")

urban_mapping = {
   'Rural village and dispersed' : 1,
   'Rural town and fringe' : 2,
   'Urban city and town' : 3 ,
}

dover['urban_class'] = dover.RUC11.map(urban_mapping)


dover.head()
