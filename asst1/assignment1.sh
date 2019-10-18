#Jenny Balmagia
mkdir -p output

ogrinfo tl_2018_us_county -where "NAME = 'Santa Barbara'" -al |less #Check current projection of counties shapefile, NAD83

ogr2ogr -t_srs EPSG:3310 output/counties.shp tl_2018_us_county/tl_2018_us_county.shp #Reproject into California Albers, 3310

ogrinfo output/counties.shp -al |less #Check to see reproject worked

ogr2ogr -where "NAME = 'Santa Barbara'" output/sb.shp output/counties.shp #Extracting only santa barbara from CA counties

gdalwarp -t_srs EPSG:3310 crefl2_A2019257204722-2019257205812_250m_ca-south-000_143.tif output/reproj.tif #Reproject image raster

gdalinfo output/reproj.tif #check reproject

gdalwarp -cutline output/sb.shp -crop_to_cutline output/reproj.tif output/santa_barbara.tif -dstalpha #clip raster to extent of SB county

 