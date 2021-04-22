create or replace view CODEETABLISSEMENT_LIB as
SELECT
ce.id,
ce.val,
dri.LIBELLEDIR  as desce,
dept1.val as departement,
serv.val as service
FROM codeetablissement ce
LEFT JOIN departement dept1 ON ce.departement = dept1.id
left join DIRECTION dri on dri.IDDIR=ce.DESCE
LEFT JOIN service serv ON ce.service = serv.id
/