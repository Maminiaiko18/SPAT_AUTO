ALTER TABLE factureclient
ADD datedepart DATE;

ALTER TABLE factureclient
ADD heuredepart varchar(500);

ALTER TABLE factureclient
ADD datearrivee DATE;

ALTER TABLE factureclient
ADD heurearrivee varchar(500);

ALTER TABLE factureclient
ADD bateau varchar(100) CONSTRAINT factureclient_navire_id_fk REFERENCES navire(id);

ALTER TABLE factureclient
ADD provenance varchar(500) CONSTRAINT factureclient_postedest_id_fk REFERENCES postedestinataire(id);

ALTER TABLE factureclient
ADD destination varchar(500) CONSTRAINT factureclient_postedest2_id_fk REFERENCES postedestinataire(id);
ALTER TABLE factureclient
ADD escale varchar(500);