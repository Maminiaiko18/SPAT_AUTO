alter table navire add armateur varchar2 (100) constraint fk_armateur references armateur;

CREATE OR REPLACE VIEW NAVIRELIBCOMPLET
            (ID, REFERENCE, NOM, PAVILLON, JNT, JBT, PLT, LHT, LM, TE, VOLUME, REMARQUE, ETAT, TYPE, VALPAVILLON,
             DESCEPAVILLON, TYPENAVIRELIB,ARMATEUR,ARMATEURLIB)
AS
SELECT nav.ID,
       nav.REFERENCE,
       nav.NOM,
       nav.PAVILLON,
       nav.JNT,
       nav.JBT,
       nav.PLT,
       nav.LHT,
       nav.LM,
       nav.TE,
       nav.VOLUME,
       nav.REMARQUE,
       nav.ETAT,
       nav.TYPE,
       p.val   AS valpavillon,
       p.DESCE AS descepavillon,
       tn.val  AS typenavirelib,
       nav.ARMATEUR,
       a.NOM   as ARMATEURLIB
FROM navire nav
         left JOIN PAYS p ON p.id = nav.PAVILLON
         LEFT JOIN typenavire tn ON tn.id = nav.TYPE
         left join ARMATEUR a on a.ID = nav.ARMATEUR;

CREATE OR REPLACE VIEW NAVIRELIB
            ("ID", "REFERENCE", "NOM", "PAVILLON", "JNT", "JBT", "PLT", "LHT", "LM", "TE", "VOLUME", "REMARQUE", "ETAT",
             "TYPE",ARMATEURLIB) AS
SELECT id,
       reference,
       nom,
       valpavillon   AS pavillon,
       JNT,
       JBT,
       PLT,
       LHT,
       LM,
       TE,
       lht * lm * te as volume,
       REMARQUE,
       etat,
       typenavirelib AS TYPE,
       ARMATEURLIB
FROM navirelibcomplet;
