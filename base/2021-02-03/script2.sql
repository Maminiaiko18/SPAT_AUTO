CREATE OR REPLACE FORCE VIEW NAVIRELIBCOMPLET
AS
   SELECT nav."ID",
          nav."REFERENCE",
          nav."NOM",
          nav."PAVILLON",
          nav."JNT",
          nav."JBT",
          nav."PLT",
          nav."LHT",
          nav."LM",
          nav."TE",
          nav."VOLUME",
          nav."REMARQUE",
          nav."ETAT",
          nav."TYPE",
          p.val AS valpavillon,
          p.DESCE AS descepavillon,
          tn.val AS typenavirelib
     FROM navire nav
          left JOIN PAYS p ON p.id = nav.PAVILLON
          LEFT JOIN typenavire tn ON tn.id = nav.TYPE;