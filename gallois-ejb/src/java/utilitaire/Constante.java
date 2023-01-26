package utilitaire;

public class Constante {
    public static  final String  idmodeVirement="pay3";
    public static  final String  idCatDroitDePort="CATFC006";
    public static  final String  idCategorieFCDefinitive="CATFCO3";
    public static  final String  idCatRubConteneur="CATFC002";
    public static String idCategorieFCProvision="CATFCO2";
    public static String idCategorieFCProforma="CATFCO1";
    public static String idcategorieCapitainerie="CATFC001";
    public static String idCessionEauDouce="RBR0126";
    public static String idServiceHauteMere="RBR0127";
    public static String idPiquagePeinture="RBR0128";
    public static String idImmobilisationNavire="RBR0129";
    public static String idEnlevementOrdures="RBR0130";
    public static String idStationnement="RB0000000021170449";
    public static String idDroitDePortCalcule="RB0000000021170444";
    public static String idRedevanceCommunaleCalcule="RB0000000021170448";
    public static String idRedevanceFixe="RB0000000026172740";
    public static String idRedevanceVariable="RB0000000027173349";
    public static String compteTransbordement="70627";
    public static String idPilotageCalcule="RB0000000021170445";
    public static String idRemorquageCalcule="RB0000000021170446";
    public static String cptNonBudgetise = "00000000000";


    public static String idLamanageCalcule="RB0000000021170447";
    public static String idPavillonMada="PAYS000057";
    public static String idCargaisonPetrole="CGM00001";
    public static String conteneurTypeSaisie = "TSAI001";
    public static String tonnage = "TMES001";
    public static String conteneur = "TS0001";
    public static String societe = "TS0002";
    public static String typesociete = "TSAI002";
    public static String typeconteneur = "TSAI001";
    public static String idMICTSL = "0120037";
    public static String idMICTSL2 = "clt1";
    public static String mictsl = "NS004";
    private static String idTypeLCRecette = "TLC00001";
    private static String idTypeLCDepense = "TLC00002";
    public static String idRoleDirecteur = "directeur";
    public static String idRoleUtilisateur = "utilisateur";
    public static String idRoleAdmin = "admin";
    public static String idRoleAdminFacture = "adminFacture";
    public static String idRoleAdminCompta = "compta";
    public static String idRoleDg = "dg";
    public static String idRoleSaisie = "saisie";
    public static String tableOpFfLc = "OpFfLc";
    private static String mois[] = {"Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"};
    private static String moisRang[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    private static String objetDepense = "depense";
    private static String objetRecette = "recette";
    private static String objetFacture = "facture";
    private static String objetFactureF = "factureF";
    static private String tableRecetteLC = "recettesLC";
    static private String tableFactureLC = "factureLigneCredit";
    static private String tableFactureFLC = "FactureFournisseurLC";
    static private String tableDepenseLC = "sortieFF";
    private static String idFournAuto = "clt1";
    static private String objFactureProf = "FactureProfFournisseur";
    static private String objetBc = "BC";
    static private String objetCDetailFactProf = "detFactProf";
    static private String objetDetailBC = "detBC";
    static private String objetDetailFactFourn = "detFactF";
    static private String dedFactProfFourn = "DedFACTUREProfFOURNISSEUR";
    static private String DetailLcCree = "0";
    static private String DetailLcValide = "1";
    static public String estMictsl = "1";
    static private String objetDedBc = "DedBc";
    static private String objetLcDetMvt = "LcDetailMvtCaisse";
    static private String objetLcDetDed = "LcDetailDed";
    static private String objetLcDetOp = "LcDetailop";
    static private String objetOpFf = "OPFACTUREFOURNISSEUR";
    static private String objetDed = "ded";
    static private String objetOp = "ORDONNERPAYEMENT";
    static private String objetLcDetail = "LcDetails";
    static private String tableDetailBC = "detailBC";
    private static String objetMvtCaisse = "mvtCaisse";
    static private String objectDetailFPF = "detailFPF";
    public static String objetFactureFournisseur = "FactureFournisseur";
    static private String opFactureFournisseur = "OPFACTUREFOURNISSEUR";
    static private String objetLigneCredit = "LigneCredit";
    static private String objetLigneCreditRecette = "LigneCreditRecette";
    static private String visaOp = "VISAORDREPAYEMENT";
    static private String visaOr = "VISAOR";
    static public String typeOpFacture = "facture";
    static public String typeOpNormale = "normale";
    static public String tableVisaOp = "VISAORDREPAYEMENT";
    static public String objetFactureClient = "FACTURECLIENT";
    public static String tableOrFcLc = "ORFCLC";
    static public String tableFactureCLC = "FactureClientLC";
    static public String factureClient = "FACTURECLIENT";
    public static final String fcPrefix = "FCL";
    public static final String constanteTiersStock = "TIERS1";
    public static final String constantePeriode = "T";
     public static final String financeTypeAnnulation = "3";
    
    public static final String constanteEntreeStock = "MVT000002";
    public static final String constanteSortieStock = "MVT000003";
    public static final String constanteReintegrStock = "MVT000001";
    public static final String conge = "CONGE";
    public static final String mouvement = "MOUVEMENT";
    public static final String depart = "DEPART";
    public static final String deplacement = "DEPLACEMENT";
    public static final String deces = "DECES";

    public static final String constanteCouleur = "#103a8e";
    public static final String constanteCouleurEnteteListe = "#ffb401";
    
    public static final String idtypeMvtDepart = "TPMM00003";
    public static final String idtypeMvt = "TPMM00002";
    public static final String idtypeMvtArrivee = "TPMM00001";
    public static final String manoeuvreEntree = "MDB_0003";
    public static final String manoeuvreSortie = "MDB_0005";
    private static double tauxIRCM=20;

    public static final String typeCheque = "TCHQ00001";
    public static final String posteMembre = "POST000001";
    public static final String posteAutre = "POST000000";
    public static final String tpmvtarrive = "TPMM00004";
    public static final String tpmvtdepart = "TPMM00003";
    public static final String typeff = "TFF0001";
    public static final String modepaiementDefaut = "pay1";
    public static final String caisseCentrale = "CAIS000016";
    public static final String caisseCentraleBP = "CAIS000016";
    public static final String caisseCentraleEspece = "CAIS000015";
    public static final String deviseAr = "Ar";
    public static final String deviseEuro = "Eur";
    public static final String deviseDollars = "Dollars";
    public static final String idprovision = "TFC003";
    public static final int rangMahitaNyHafa = 6;
    public static String bc = "/SPAT/DG/DECOMAA-";
    public static final int longueurNumeroBordereau = 4;
    public static int tvaDefaut = 20;
    private static String roleCommandant="ROL001300";
    private static String typeFCAcredit="TFC001";
    private static String categorieFFBP="CATGFF002";
    private static String stationnementBP="RB0000000021170495";
    private static String droitDePortBP="RB0000000021170493";
    private static String redevanceSanitaire="RB0000000059112123";
    private static String redevanceCommBP="RB0000000060112257"; 
    private static String navireBornageEtPeche="TYPES0001";
    public static final String categorieAvoirFC="CT006";
    public static final String motifAvoirFC="MT008";
    public static final String typeAvoirFC="2";
    public static final String categorieFFdefault="CATGFF001";
    public static final String categorieAvoirFF="CT001X";
    
    public static final String modePaiementEspece = "pay1";
    public static final String typeChequeAuComptant = "TCHQ00001";
    public static final String idBonProvisoire = "CATGFF002";
    public static final String typeChequeAuComptantFF = "TFC002";
    public static final String typeAuComptant = "TFC002";
    public static final String typeFCAuComptant  = "TFC002";
    public static final String dirAppuiAdm="CODE000023";
    public static final String projMissionHebergement="PR000115";
    public static final String compteHorsCircuit="00000000000";
    public static final String compteBP="121MHI62512";
    private static String traite = "pay6";
    private static String caisseTraite = "CAIS00000T00016"; 
    public static String caisseDepense = "CAI0000000015200311"; 
    private static String typeCaissePhysique = "2"; 
    public static String EFFETSARECEVOIRREMISALENCAISSEMENT="CAIS000017";
    private static String typeACredit = "TCHQ00002";

    public static String getTypeACredit(){
        return typeACredit;
    }
    
    public static String getEFFETSARECEVOIRREMISALENCAISSEMENT() {
        return EFFETSARECEVOIRREMISALENCAISSEMENT;
    }

    public static void setEFFETSARECEVOIRREMISALENCAISSEMENT(String EFFETSARECEVOIRREMISALENCAISSEMENT) {
        Constante.EFFETSARECEVOIRREMISALENCAISSEMENT = EFFETSARECEVOIRREMISALENCAISSEMENT;
    }

    public static String getTypeCaissePhysique() {
        return typeCaissePhysique;
    }


    public static void setTypeCaissePhysique(String typeCaissePhysique) {
        Constante.typeCaissePhysique = typeCaissePhysique;
    }


    public static String getCaisseDepense() {
        return caisseDepense;
    }


    public static void setCaisseDepense(String caisseDepense) {
        Constante.caisseDepense = caisseDepense;
    }


    public static String getCaisseTraite(){
        return caisseTraite;
    }


    public static String getTypeFCAuComptant() {
        return typeFCAuComptant;
    }
    
    public static String getNavireBornageEtPeche() {
        return navireBornageEtPeche;
    }

    public static String getStationnementBP() {
        return stationnementBP;
    }

    public static String getDroitDePortBP() {
        return droitDePortBP;
    }

    public static String getRedevanceSanitaire() {
        return redevanceSanitaire;
    }

    public static String getRedevanceCommBP() {
        return redevanceCommBP;
    }

    public static String getTypeFCAcredit() {
        return typeFCAcredit;
    }

    public static String getCategorieFFBP() {
        return categorieFFBP;
    }

    public static String getRoleCommandant() {
        return roleCommandant;
    }

    public static int getTvaDefaut() {
        return tvaDefaut;
    }

    public static void setTvaDefaut(int tvaDefaut) {
        Constante.tvaDefaut = tvaDefaut;
    }

    public static int getRangMahitaNyHafa() {
        return rangMahitaNyHafa;
    }

    public static String getTpmvtarrive() {
        return tpmvtarrive;
    }

    public static String getTpmvtdepart() {
        return tpmvtdepart;
    }
    
    public static double getTauxIRCM() {
        return tauxIRCM;
    }

    public static void setTauxIRCM(double tauxIRCM) {
        Constante.tauxIRCM = tauxIRCM;
    }
    
    
    
    public static String getIdTypeLCDepense() {
        return idTypeLCDepense;
    }

    public static String getDetailLcCree() {
        return DetailLcCree;
    }

    public static String getDetailLcValide() {
        return DetailLcValide;
    }

    public static String getIdTypeLCRecette() {
        return idTypeLCRecette;
    }

    public static String getIdRoleDirecteur() {
        return idRoleDirecteur;
    }

    public static String[] getMois() {
        return mois;
    }

    public static String[] getMoisRang() {
        return moisRang;
    }

    public static String getObjetDepense() {
        return objetDepense;
    }

    public static String getObjetRecette() {
        return objetRecette;
    }

    public static String getObjetFacture() {
        return objetFacture;
    }

    public static String getObjetFactureF() {
        return objetFactureF;
    }

    public static String getTableRecetteLC() {
        return tableRecetteLC;
    }

    public static String getTableFactureLC() {
        return tableFactureLC;
    }

    public static String getTableFactureFLC() {
        return tableFactureFLC;
    }

    public static String getTableDepenseLC() {
        return tableDepenseLC;
    }

    public static String getIdFournAuto() {
        return idFournAuto;
    }

    public static String getObjFactureProf() {
        return objFactureProf;
    }

    public static String getObjetBc() {
        return objetBc;
    }

    public static String getObjetCDetailFactProf() {
        return objetCDetailFactProf;
    }

    public static String getObjetDetailBC() {
        return objetDetailBC;
    }

    public static String getObjetDetailFactFourn() {
        return objetDetailFactFourn;
    }

    public static String getDedFactProfFourn() {
        return dedFactProfFourn;
    }

    public static void setObjetDedBc(String objetDedBce) {
        objetDedBc = objetDedBce;
    }

    public static String getObjetDedBc() {
        return objetDedBc;
    }

    public static void setObjetLcDetMvt(String objetLcDetMvte) {
        objetLcDetMvt = objetLcDetMvte;
    }

    public static String getObjetLcDetMvt() {
        return objetLcDetMvt;
    }

    public static String getObjetLcDetDed() {
        return objetLcDetDed;
    }

    public static String getObjetLcDetOp() {
        return objetLcDetOp;
    }

    public static String getObjetOpFf() {
        return objetOpFf;
    }

    public static String getObjetDed() {
        return objetDed;
    }

    public static String getObjetOp() {
        return objetOp;
    }

    public static String getObjetLcDetail() {
        return objetLcDetail;
    }

    public static String getTableDetailBC() {
        return tableDetailBC;
    }

    public static String getObjetMvtCaisse() {
        return objetMvtCaisse;
    }

    public static String getObjectDetailFPF() {
        return objectDetailFPF;
    }

    public static String getObjetFactureFournisseur() {
        return objetFactureFournisseur;
    }

    public static String getOpFactureFournisseur() {
        return opFactureFournisseur;
    }

    public static String getObjetLigneCredit() {
        return objetLigneCredit;
    }

    public static String getObjetLigneCreditRecette() {
        return objetLigneCreditRecette;
    }

    public static String getVisaOp() {
        return visaOp;
    }

    public static String getVisaOr() {
        return visaOr;
    }

    public static String getTraite() {
        return traite;
    }

    public static void setTraite(String traite) {
        Constante.traite = traite;
    }

}
