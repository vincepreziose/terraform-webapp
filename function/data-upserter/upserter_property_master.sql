INSERT INTO {etlschema}.property_master (
  idid,
  refid,
  fullstreetaddress,
  housenumber,
  directionprefix,
  streetname,
  streetsuffix,
  directionsuffix,
  unitnumber,
  city,
  state,
  zipcode,
  melissadataresultcode,
  zip4,
  fips,
  county,
  apn,
  latitude,
  longitude,
  addrmatchcode,
  censustract,
  censusblock,
  insertdate,
  updatedate
  )
SELECT
idid,
refid,
fullstreetaddress,
housenumber,
directionprefix,
streetname,
streetsuffix,
directionsuffix,
unitnumber,
city,
state,
zipcode,
melissadataresultcode,
zip4,
fips,
county,
apn,
latitude,
longitude,
addrmatchcode,
censustract,
censusblock,
insertdate,
updatedate
FROM {etlschema}.staging_property_master ON CONFLICT (refid) DO
UPDATE
SET (
  refid,
  fullstreetaddress,
  housenumber,
  directionprefix,
  streetname,
  streetsuffix,
  directionsuffix,
  unitnumber,
  city,
  state,
  zipcode,
  melissadataresultcode,
  zip4,
  fips,
  county,
  apn,
  latitude,
  longitude,
  addrmatchcode,
  censustract,
  censusblock,
  insertdate,
  updatedate
  ) = (
    EXCLUDED.refid,
    EXCLUDED.fullstreetaddress,
    EXCLUDED.housenumber,
    EXCLUDED.directionprefix,
    EXCLUDED.streetname,
    EXCLUDED.streetsuffix,
    EXCLUDED.directionsuffix,
    EXCLUDED.unitnumber,
    EXCLUDED.city,
    EXCLUDED.state,
    EXCLUDED.zipcode,
    EXCLUDED.melissadataresultcode,
    EXCLUDED.zip4,
    EXCLUDED.fips,
    EXCLUDED.county,
    EXCLUDED.apn,
    EXCLUDED.latitude,
    EXCLUDED.longitude,
    EXCLUDED.addrmatchcode,
    EXCLUDED.censustract,
    EXCLUDED.censusblock,
    EXCLUDED.insertdate,
    EXCLUDED.updatedate
  );
