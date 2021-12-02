DELETE FROM {etlschema}.buyer_seller dest
USING {etlschema}.staging_buyer_seller a
WHERE dest.FILEID = a.FILEID;

INSERT INTO {etlschema}.buyer_seller (
  idid,
  fileid,
  principaltype,
  staticseqnum,
  principalclass,
  fullname,
  principalreportname,
  firstname,
  lastname,
  spousefirstname,
  spouselastname,
  vestname,
  vestingtext,
  trustshortname,
  insertdate,
  updatedate
  )
SELECT
idid,
fileid,
principaltype,
staticseqnum,
principalclass,
fullname,
principalreportname,
firstname,
lastname,
spousefirstname,
spouselastname,
vestname,
vestingtext,
trustshortname,
insertdate,
updatedate
FROM {etlschema}.staging_buyer_seller;
