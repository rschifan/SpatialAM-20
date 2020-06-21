#!/bin/bash

DATA="../../data"

# ****************************************************************************************************
# Create database and tables
# ****************************************************************************************************

psql template1 -f create_database.sql -U geocycle
psql -f create_tables.sql -U geocycle


# ****************************************************************************************************
# Load NYC boundaries 
# ****************************************************************************************************


shp2pgsql -I -d -s 102718:4326 -g geom $DATA/shp/nyc_boroughs/nyc_boroughs.shp nyc_boroughs | psql -d geocycle -U geocycle

shp2pgsql -I -d -s 26918:4326 -g geom $DATA/shp/nyc_neighborhoods/nyc_neighborhoods.shp nyc_neighborhoods | psql -d geocycle -U geocycle

shp2pgsql -I -d -s 102718:4326 -g geom $DATA/shp/nyc_census_tracts/nyc_census_tracts.shp nyc_census_tracts | psql -d geocycle -U geocycle

shp2pgsql -I -d -s 102718:4326 -g geom $DATA/shp/nyc_census_blocks/nyc_census_blocks.shp nyc_census_blocks | psql -d geocycle -U geocycle


# ****************************************************************************************************
# Load OSM metro extract
# ****************************************************************************************************

psql -d geocycle -U geocycle -f /usr/local/Cellar/osmosis/0.47/libexec/script/pgsnapshot_schema_0.6.sql
psql -d geocycle -U geocycle -f /usr/local/Cellar/osmosis/0.47/libexec/script/pgsnapshot_schema_0.6_linestring.sql

osmosis --read-pbf $DATA/osm/nyc_poly_highways.osm.pbf --log-progress --write-pgsql database=geocycle user=geocycle password=geocycle




