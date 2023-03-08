alter table codeetablissement drop constraint Service_dep_fk;

ALTER TABLE codeetablissement ADD CONSTRAINT Service_dep_fk FOREIGN KEY (SERVICE) REFERENCES SERVICE(ID);
ALTER TABLE codeetablissement ADD CONSTRAINT direction_dep_fk FOREIGN KEY (DESCE) REFERENCES direction(IDDIR);