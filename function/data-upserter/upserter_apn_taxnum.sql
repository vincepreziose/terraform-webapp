DELETE FROM {etlschema}.apn_taxnum dest
USING {etlschema}.staging_apn_taxnum a
WHERE dest.FILEID = a.FILEID;

INSERT INTO {etlschema}.apn_taxnum (
  idid,
  fileid,
  propertyid,
  taxid,
  taxclasstype,
  taxtype,
  taxnum,
  taxyear,
  taxrateareanum,
  insertdate,
  updatedate
  )
SELECT
  idid,
  fileid,
  propertyid,
  taxid,
  taxclasstype,
  taxtype,
  taxnum,
  taxyear,
  taxrateareanum,
  insertdate,
  updatedate
FROM {etlschema}.staging_apn_taxnum;
