----------------------- SPAT_CAPITAINERIE -----------------------

create view UTILISATEURVUEFICHE_ID (REFUSER, LOGINUSER, PWDUSER, NOMUSER, ADRUSER, TELUSER, IDROLE) as
    select cast(u.refuser as varchar2(50)),u.LOGINUSER,u.PWDUSER,u.NOMUSER,
        d.LIBELLEDIR as adruser,u.TELUSER,u.IDROLE
     from utilisateur u, direction d where u.ADRUSER=d.IDDIR;
	 
alter table HISTORIQUE_VALEUR modify val5 varchar2(1000);

create or replace view OCCUPMATERIELNAVALLIBCOMPLET as
	select
		occup."ID",occup."DATY",occup."IDMATERIEL_NAVAL",occup."IDPILOTE",occup."IDCOMMANDANT",occup."IDNATUREOPERATION",occup."IDMANOEUVREBORD",occup."HEUREDEBUT",occup."HEUREFIN",occup."IDNAVIRE",occup."IDCLIENT",occup."DUREE",occup."POSITION",occup."OBSERVATION",occup."ETAT",occup."DATEFIN",
		mat.denomination, mat.DATE_AQUISITION, mat.IDMARQUE, mat.PUISSANCE, mat.DETENTEUR, mat.MAINTENANCE,
		mat.IDTYPE_MATERIEL, mat.IMMATRICULATION, mat.etat as etatmaterielnaval, mat.valmarque, mat.descemarque, mat.valtypemateriel, mat.descetypemateriel,
		p.VAL as valpilote, p.DESCE as descepilote,
		comm.val as valcommandant, comm.DESCE as descecommandant,
		nat.val as valnatureoperation, nat.DESCE as descenatureoperation,
		manb.val as valmanoeuvrebord, manb.DESCE as descemanoeuvrebord,
		nav.reference, nav.nom as nomnavire, nav.pavillon as pavillonnavire, nav.jnt, nav.JBT, nav.PLT, nav.LHT, nav.lm, nav.te,
		nav.volume, nav.remarque, nav.valpavillon, nav.descepavillon
	from OCCUPATIONMATERIELNAVAL occup
		join MATERIELNAVALLIBCOMPLET mat on mat.ID = occup.IDMATERIEL_NAVAL
		join pilote p on p.ID = occup.IDPILOTE
		join COMMANDANT comm on comm.id = occup.IDCOMMANDANT
		join NATUREOPERATION nat on nat.id = occup.IDNATUREOPERATION
		join MANOEUVREBORD manb on manb.id = occup.IDMANOEUVREBORD
		join NAVIRELIBCOMPLET nav on nav.ID = occup.IDNAVIRE;
		
create or replace view OCCUPMATERIELNAVALLIB as
	select
        id,
        daty,
        denomination as idmateriel_naval,
        valpilote as idpilote,
        valcommandant as idcommandant,
        valnatureoperation as idnatureoperation,
        valmanoeuvrebord as idmanoeuvrebord,
        heuredebut, heurefin,
        nomnavire as idnavire,
        duree, position, observation, etat, datefin
    from OCCUPMATERIELNAVALLIBCOMPLET;
	
create view UTILISATEUR_ID (REFUSER, LOGINUSER, PWDUSER, NOMUSER, ADRUSER, TELUSER, IDROLE) as
    select cast(u.refuser as varchar2(50)),u.LOGINUSER,u.PWDUSER,u.NOMUSER,
        u.adruser,u.TELUSER,u.IDROLE
     from utilisateur u;
	 
create or replace view OCCUPMATERIELNAVALLIBNOMBRE as
    select
        id,daty,idmateriel_naval,idpilote,idcommandant,
        idnatureoperation,idmanoeuvrebord,heuredebut,heurefin,
        idnavire,duree,position,observation,etat,datefin,
        cast(1 as number(10,2)) as nombre
    from occupmaterielnavallib;
	
create or replace view T_SALSYNDICAT as
	select
        tsal."SA_CompteurNumero",tsal."MatriculeSalarie",tsal."Civilite",tsal."Nom",tsal."NomJeuneFille",tsal."Prenom",tsal."Prenom2",tsal."Confidentialite",tsal."Rue1",tsal."Rue2",tsal."Commune",tsal."BureauDistributeur",tsal."CodePostal",tsal."CodePays",tsal."Telephone",tsal."Rue12",tsal."Rue22",tsal."Commune2",tsal."BureauDistributeur2",tsal."CodePostal2",tsal."CodePays2",tsal."Telephone2",tsal."ChoixSurAdresse",tsal."DateNaissance",tsal."DeptNaissance",tsal."CommuneNaissance",tsal."CodeCommuneNaissance",tsal."SituationMilitaire",tsal."DateDebutServiceMil",tsal."DateFinServiceMil",tsal."TravailleurHandicape",tsal."SuiteAccident",tsal."TauxInvalidite",tsal."NoBulletinModele",tsal."CompteAuxiliaire",tsal."ModeDePaiement",tsal."EtatPaie",tsal."Cloture",tsal."DateDePaie",tsal."DateDeCloture",tsal."CumulsReposCompensateur",tsal."ResteAPrendre",tsal."AcquisPrecedent",tsal."AcquisEnCours",tsal."CumulsBrutPrecedent",tsal."MoisAncienneteSociete",tsal."MoisAncienneteEtablissement",tsal."MoisAnciennetePoste",tsal."DateDebutConges1",tsal."DateFinConges1",tsal."DateDebutConges2",tsal."DateFinConges2",tsal."DateDebutConges3",tsal."DateFinConges3",tsal."DroitSupplementaire",tsal."NbSamedis",tsal."MoisDeClotureDesConges",tsal."TypeDeVentilation",tsal."NbFichesENF",tsal."NbFichesMUL",tsal."ChoixEtablissement",tsal."GHRTypeConjoint",tsal."GHRTypeDAstreinte",tsal."GHRTypeDeSalarie",tsal."GHRSoldeRCReel",tsal."GHRSoldeRCCalcul",tsal."GHRDateDernierEnregistrement",tsal."GHRDateDernierEnregistrementHS",tsal."GHRDateDernierEnregistrementRC",tsal."GHRCodePAM",tsal."GHRDernierContingentHS",tsal."GHRContingentHSEnCours",tsal."GHRCumulAnnuelHS",tsal."AdresseOrganismeETA",tsal."TypeDuBulletin",tsal."CotorepDate",tsal."CotorepDateFin",tsal."CotorepCategorie",tsal."CodeInseeCommune",tsal."RompuBilletagePrecedent",tsal."RompuBilletageCourant",tsal."FormNiveauEtudes",tsal."CodeFonctionEntreprise",tsal."NumeroDeBadge",tsal."NumeroSQL",tsal."CodeEmploiINSEE",tsal."Commentaire1",tsal."Commentaire2",tsal."FlagInfosGenerales",tsal."BanqueActive",tsal."PaiementBanque",tsal."ChoixPaiement",tsal."ChoixBanque1Ou2",tsal."PaiementBanqueEnTaux",tsal."IdentifiantEpargne",tsal."CleIdentifiantEpargne",tsal."ResidentFiscalEpargne",tsal."SoumisCSGEpargne",tsal."DIFDernierEntProf",tsal."DIFResteAPrendre",tsal."EMail",tsal."InfoDateDeNaissance",tsal."BulletinDematerialise",tsal."Memo",tsal."RangDeNaissance",tsal."Commentaire3",tsal."NumeroDePortable",tsal."TelephoneProfessionnel",tsal."TelephPortableProfessionnel",tsal."FaxProfessionnel",tsal."AdresseMelProfessionnelle",tsal."APrevenirPersonne01",tsal."APrevenirTelephone01",tsal."APrevenirPersonne02",tsal."APrevenirTelephone02",tsal."AEDTransmise",tsal."ModiFiche_date",tsal."ModiFiche_heure",tsal."ModiFiche_utilisateur",tsal."BrutCPPrecedentBis",tsal."AccordSalarie_AdCourriel",tsal."EditiqueBulletin",tsal."MiseAZeroCongesLorsDuDepart",tsal."DSNFCTTransmise",tsal."DebutPeriodeRattachement",tsal."FinPeriodeRattachement",tsal."CodeDistribuALEtranger",tsal."DebutDePriseDesConges",tsal."DureeDePriseDesConges",tsal."CPAcquisPrecedentBis",tsal."CPAcquisFracEnCours",tsal."CPAcquisFracPrecedent",tsal."CPAcquisFracPrecedentBis",tsal."CPAcquisAncEnCours",tsal."CPAcquisAncPrecedent",tsal."CPAcquisAncPrecedentBis",tsal."CPAcquisSupEnCours",tsal."CPAcquisSupPrecedent",tsal."CPAcquisSupPrecedentBis",tsal."ResteAPrendreSuivant",tsal."ResteAPrendrePrecedent",tsal."ResteAPrendreSuivantFrac",tsal."ResteAPrendreFrac",tsal."ResteAPrendrePrecedentFrac",tsal."ResteAPrendreSuivantAnc",tsal."ResteAPrendreAnc",tsal."ResteAPrendrePrecedentAnc",tsal."ResteAPrendreSuivantSup",tsal."ResteAPrendreSup",tsal."ResteAPrendrePrecedentSup",tsal."CongesPrisAnneePrecedente",tsal."ResteAPrendreALaCloture",tsal."ResteAPrendreFracALaCloture",tsal."ResteAPrendreAncALaCloture",tsal."ResteAPrendreSupALaCloture",tsal."PrisCongesInitialEnCours",tsal."PrisCongesInitialPrecedent",tsal."PrisCongesInitialPrecedentBis",tsal."CPFResteAPrendre",tsal."SalarieDesactive",tsal."CodePaysNaissance",tsal."FormCategorieDeclaration",
        histo.id as idhistosyndicat, histo.daty as datehistosyndicat, histo.etat as etathistosyndicat,
        synd.id as idsyndicat, synd.nom as nomsyndicat, synd.DESCRIPTION as descriptionsyndicat, synd.etat as etatsyndicat,
        poste.id as idposte, poste.val as valposte, poste.desce as desceposte
    from spat_rh.t_sal tsal
        join HISTORIQUESYNDICAT histo on to_char(tsal."SA_CompteurNumero")=to_char(histo.IDPERSONNEL)
        join SYNDICAT synd on synd.id=histo.IDSYNDICAT
        join POSTE poste on poste.ID=histo.IDPOSTE;