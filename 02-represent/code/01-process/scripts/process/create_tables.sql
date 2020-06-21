
\connect geocycle;

-- ****************************************************************************************************
-- Load Instagram photos data
-- ****************************************************************************************************

DROP TABLE IF EXISTS instagram_photos;

CREATE TABLE IF NOT EXISTS instagram_photos ( 
pid int NOT NULL,
created_at timestamp,
longitude float8, 
latitude float8, 
tags TEXT ARRAY); 


COPY instagram_photos FROM '/Users/schifane/Dropbox/teaching/SpatialAM-20/classes/02-represent/code/01-process/data/instagram/instagram-photos-manhattan.csv' CSV HEADER ENCODING 'utf-8';

-- Add a geometry column geom as a two dimensional point
SELECT AddGeometryColumn('instagram_photos', 'geom', 4326, 'POINT', 2);
-- Convert longitude, latitude column in a Point geometry
UPDATE instagram_photos SET geom = ST_SetSRID(ST_Point(longitude, latitude), 4326);
CREATE INDEX instagram_geom_index on instagram_photos USING GIST(geom);
CREATE INDEX instagram_pid_index on instagram_photos(pid);


-- ****************************************************************************************************
-- Load Crime data
-- ****************************************************************************************************


DROP TABLE IF EXISTS nyc_crime;

CREATE TABLE IF NOT EXISTS nyc_crime ( 
	identifier text NOT NULL,
	date timestamp, 
	offence text, 
	category text, 
	longitude float8, 
	latitude float8);

COPY nyc_crime FROM '/Users/schifane/Dropbox/teaching/SpatialAM-20/classes/02-represent/code/01-process/data/crime/nyc_crime.csv' CSV HEADER ENCODING 'utf-8';

-- Add a geometry column geom as a two dimensional point
SELECT AddGeometryColumn('nyc_crime', 'geom', 4326, 'POINT', 2);
-- Convert longitude, latitude column in a Point geometry
UPDATE nyc_crime SET geom = ST_SetSRID(ST_Point(longitude, latitude), 4326);

CREATE INDEX geom_index on nyc_crime USING GIST(geom);
CREATE INDEX pid_index on nyc_crime(identifier);

-- Update statistics
VACUUM (VERBOSE, ANALYZE) instagram_photos;
VACUUM (VERBOSE, ANALYZE) nyc_crime;

