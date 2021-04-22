insert into menudynamique values('MEN0084','Direction','fa fa-cog','#','5','2','MENP007');
insert into menudynamique values('MEN0085','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=utilisateur/direction-saisie.jsp','3','3','MEN0084');
insert into menudynamique values('MEN0086','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=utilisateur/direction-liste.jsp','2','3','MEN0084');

create or replace view PATRIMOINELIBCOMPLET as
select
        p."ID",p."IDOBJET",p."IDTYPEPATRIMOINE",p."REMARQUE",p."ETAT" as etatpatrimoine,p."LIBELLE",p."DESCRIPTION",p."MONTANT",p."OCCUPANT",p."DEBUT_CONTRAT",p."FIN_CONTRAT",p."UTILISATION",
        type.val as valtypepatrimoine, type.desce as descetypepatrimoine,
        etat.VAL as valetatpatrimoine, etat.DESCE as desceetatpatrimoine,
        mat.DENOMINATION, DATE_AQUISITION, IDMARQUE, PUISSANCE, DETENTEUR, MAINTENANCE, IDTYPE_MATERIEL, IMMATRICULATION, mat.ETAT, VALMARQUE, DESCEMARQUE, VALTYPEMATERIEL, DESCETYPEMATERIEL
    from PATRIMOINE p
        join TYPEPATRIMOINE type on p.IDTYPEPATRIMOINE = type.ID
        join ETATPATRIMOINE etat on p.ETAT = etat.ID
        join MATERIELNAVALLIBCOMPLET mat on mat.id = p.IDOBJET;
		
create or replace view PATRIMOINELIB as
select
        id,
        DENOMINATION as idobjet,
        VALTYPEPATRIMOINE as IDTYPEPATRIMOINE,
        REMARQUE,
        valetatpatrimoine as etat,
        LIBELLE, DESCRIPTION, MONTANT, OCCUPANT, DEBUT_CONTRAT, FIN_CONTRAT,UTILISATION
    from PATRIMOINELIBCOMPLET;
	
update MENUDYNAMIQUE set href='#' where id='MEN0064';
insert into MENUDYNAMIQUE values ('MEN0082','Saisie','fa fa-plus','/spat/pages/globalnegoce.jsp?but=capitainerie/occupationMaterielNaval-saisie.jsp',1,4,'MEN0064');
insert into MENUDYNAMIQUE values ('MEN0083','Liste','fa fa-list','/spat/pages/globalnegoce.jsp?but=capitainerie/occupationMaterielNaval-liste.jsp',2,4,'MEN0064');

create view PLACEMENTLIBCOMPLET_ANALYSE as
(select "ID","ENTITE","DATE_PLACEMENT","DATE_ECHEANCE","DUREE","MONTANT","TAUX","ETAT","NUMERO","IDDETAILS","IDMEREDETAILS","MOIS","MONTANT_TERME","INTERET_RECEVOIR","INTERET_NET","IDENTITE","IDBANQUE","VALENTITE","DESCEENTITE","VALBANQUE","DESCEBANQUE" from PLACEMENTLIBCOMPLET);

create or replace view MVTLIBCOMPLETANALYSEUNION as
select id, daty, escale, navire, consignataire, datearrivee, heure, provenance, destination, remarque, duree, typemvt, etat, valCONSIGNATAIRE, desceCONSIGNATAIRE, referenceNAVIRE, nomNAVIRE, pavillonNAVIRE, jntNAVIRE, jbtNAVIRE, pltNAVIRE, lhtNAVIRE, lmNAVIRE, teNAVIRE, volumeNAVIRE, remarqueNAVIRE, quaiPROVENANCE, internePROVENANCE, paysPROVENANCE, longueurPROVENANCE, profondeurPROVENANCE, tirantPROVENANCE, quaiDESTINATION, interneDESTINATION, paysDESTINATION, longueurDESTINATION, profondeurDESTINATION, tirantDESTINATION, idtypemvt, idquaiPROVENANCE, idquaiDESTINATION
       ,cast(1 as number(10,2)) as depart,
       cast(0 as number(10,2)) as arrivee
from mouvementLibelleComplet
union
select id,
       daty,
       escale,
       navire,
       consignataire,
       datearrivee,
       heure,
       provenance,
       destination,
       remarque,
       duree,
       typemvt,
       etat,
       valCONSIGNATAIRE,
       desceCONSIGNATAIRE,
       referenceNAVIRE,
       nomNAVIRE,
       pavillonNAVIRE,
       jntNAVIRE,
       jbtNAVIRE,
       pltNAVIRE,
       lhtNAVIRE,
       lmNAVIRE,
       teNAVIRE,
       volumeNAVIRE,
       remarqueNAVIRE,
       quaiPROVENANCE,
       internePROVENANCE,
       paysPROVENANCE,
       longueurPROVENANCE,
       profondeurPROVENANCE,
       tirantPROVENANCE,
       quaiDESTINATION,
       interneDESTINATION,
       paysDESTINATION,
       longueurDESTINATION,
       profondeurDESTINATION,
       tirantDESTINATION,
       idtypemvt,
       idquaiPROVENANCE,
       idquaiDESTINATION,
       cast(0 as number(10,2)) as depart,
       cast(1 as number(10,2)) as arrivee
from mouvementLibelleComplet;

update MENUDYNAMIQUE set href='/spat/pages/globalnegoce.jsp?but=patrimoine/patrimoine-saisie.jsp' where id='MEN00192';
delete from MENUDYNAMIQUE where id in ('MEN00202','MEN00203','MEN00204','MEN00205','MEN00206','MEN00207');