CREATE OR REPLACE VIEW CODEETABLISSEMENT_LIB AS
SELECT
ce.id,
ce.val,
ce.desce,
dept1.val as departement,
serv.val as service
FROM codeetablissement ce
LEFT JOIN departement dept1 ON ce.departement = dept1.id
LEFT JOIN service serv ON ce.service = serv.id;
