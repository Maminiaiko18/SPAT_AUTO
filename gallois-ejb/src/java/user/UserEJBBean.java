package user;

import avoir.AvoirFC;
import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassFille;
import bean.ClassMAPTable;
import bean.ClassMere;
import bean.ClassUser;
import bean.ErreurDAO;
import bean.ListeColonneTable;
import bean.RejetTable;
import bean.ResultatEtSomme;
import bean.TypeObjet;
import bean.TypeObjetUtil;
import bean.UnionIntraTable;
import bean.UploadPj;
import bean.ValidationException;
import config.Config;
import historique.HistoriqueEJBClient;
import historique.HistoriqueEtat;
import historique.HistoriqueLocal;
import historique.MapHistorique;
import historique.MapRoles;
import historique.MapUtilisateur;
import historique.MapUtilisateurServiceDirection;
import historique.UtilisateurUtil;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.ejb.AccessTimeout;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.Stateful;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import lc.Direction;
import lc.DirectionUtil;
import mg.allosakafo.fin.MvtCaisse;
import mg.cnaps.configuration.Configuration;
import mg.cnaps.formation.FormFormation;
import mg.cnaps.formation.FormParticipantDemande;
import mg.cnaps.formation.FormService;
import mg.cnaps.log.LogService;
import mg.cnaps.messagecommunication.Message;
import mg.cnaps.messagecommunication.MessageLibelle;
import mg.cnaps.messagecommunication.MessageNonLu;
import mg.cnaps.notification.NotificationLibelle;
import mg.cnaps.notification.NotificationMessage;
import mg.cnaps.notification.NotificationService;
import mg.cnaps.utilisateur.CNAPSUser;
import mg.spat.Cloture;
import mg.spat.JournalCaisse;
import mg.spat.Navire;
import mg.spat.StatistiqueMICTSL;
import mg.spat.StatistiquePTP;
import mg.spat.StatistiqueSMMC;
import mg.spat.placement.Placement;
import mg.spat.relationhumaine.InfoCongePermission;
import mg.spat.relationhumaine.InfoPersonnel;
import mg.spat.relationhumaine.InfoPersonnelGlobal;
import mg.spat.relationhumaine.InfoProfessionnel;
import mg.spat.relationhumaine.InfoSalaire;
import mg.spat.stock.BonDeCommande;
import mg.spat.stock.BonDeCommandeFille;
import mg.spat.stock.BonDeCommandeFilleReste;
import mg.spat.stock.BonDeLivraison;
import mg.spat.stock.BonDeLivraisonFille;
import modules.GestionMessage;
import modules.GestionRole;
import service.ClotureService;
import service.SpatService;
import service.UploadService;
import utilisateur.ConstanteUtilisateur;
import utilisateur.HomePageURL;
import utilisateur.UtilisateurInterim;
import utilisateur.UtilisateurRole;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.ConstanteUser;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utilitaire.UtilitaireMetier;
import ded.OrdonnerPayement;
import facturefournisseur.EtatFactureMontantDaty;
import facture.*;
import mg.cnaps.formation.CodeEtablissement;
import mg.spat.Prevision;

@Stateful
@AccessTimeout(10000)
@TransactionAttribute(TransactionAttributeType.SUPPORTS)
public class UserEJBBean implements UserEJB, UserEJBRemote, SessionBean {

    SessionContext sessionContext;
    //MapUtilisateur u;
    MapUtilisateurServiceDirection u;
    MapUtilisateur uVue;
    String type;
    String idDirection;
    String usersInferieurEnCours = "";
    String home_page = "utilisateur/homepage.jsp";
    Config c;
    Configuration[] listeConfig;
    TypeObjet[] listeSource = null;
    private int exercice;
    private String addrIp;
    CNAPSUser cnapsUser;
    TypeObjet caisse = null;
    private HashMap<String, String> mapAutoComplete = new HashMap<>();
    TypeObjet commandant = null;
    Prevision prevision;
    public ValidationException validation;
    CodeEtablissement codeEtablissement;

    @Override
    public CodeEtablissement getCodeEtablissement() {
        return codeEtablissement;
    }

    public void setCodeEtablissement(CodeEtablissement codeEtablissement) {
        this.codeEtablissement = codeEtablissement;
    }

    @Override
    public Prevision getPrevision() {
        return prevision;
    }

    public TypeObjet getCommandant() {
        return commandant;
    }

    public TypeObjet getCaisse() {
        return caisse;
    }

    public void setCaisse(TypeObjet caisse) {
        this.caisse = caisse;
    }

    public String getAddrIp() {
        return addrIp;
    }

    public void setAddrIp(String addrIp) {
        this.addrIp = addrIp;
    }

    public Configuration[] getListeConfig() {
        return listeConfig;
    }

    public void setListeConfig(Configuration[] listeConfig) {
        this.listeConfig = listeConfig;
    }

    public TypeObjet[] getListeSource() {
        return listeSource;
    }

    public void setListeSource(TypeObjet[] listeSource) {
        this.listeSource = listeSource;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public UserEJBBean() {
        u = null;
    }

    public void ejbRemove() {
//        try {
//            Config.vider();
//            MapHistorique histo = new MapHistorique("logout", "logout", String.valueOf(u.getRefuser()), String.valueOf(u.getRefuser()));
//            histo.insertToTable();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }

    public void ejbActivate() {
    }

    public void ejbPassivate() {
    }

    public void setSessionContext(SessionContext sessionContext) {
        this.sessionContext = sessionContext;
    }

    /*
     * public TypeObjet[] findTypeObjet(String nomTable, String id, String typ)
     * throws Exception { try { TypeObjetUtil to = new TypeObjetUtil();
     * TypeObjet atypeobjet[] = to.findTypeObjet(nomTable, id, typ); return
     * atypeobjet; } catch(Exception ex) { throw new Exception(ex.getMessage());
     * } }
     */
    public Configuration[] getListeConfiguration() {
        return listeConfig;
    }

    @Override
    public String createUtilisateurs(String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception {
        HistoriqueLocal rl = null;
        try {
            if (u.getIdrole().compareTo("dg") == 0) {
                rl = HistoriqueEJBClient.lookupHistoriqueEJBBeanLocal();
                String s = rl.createUtilisateurs(loginuser, pwduser, nomuser, adruser, teluser, idrole, u.getTuppleID());
                return s;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public String updateUtilisateurs(String refuser, String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception {
        HistoriqueLocal rl = null;
        try {
            rl = HistoriqueEJBClient.lookupHistoriqueEJBBeanLocal();
            if (u.getIdrole().compareTo("dg") == 0) {
                return rl.updateUtilisateurs(refuser, loginuser, pwduser, nomuser, adruser, teluser, idrole, u.getTuppleID());
            } else if (String.valueOf(u.getRefuser()).compareTo(refuser) == 0) {
                return rl.updateUtilisateurs(refuser, loginuser, pwduser, nomuser, adruser, teluser, u.getIdrole(), u.getTuppleID());
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public int deleteUtilisateurs(String refuser) throws Exception {
        HistoriqueLocal rl = null;

        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueEJBClient.lookupHistoriqueEJBBeanLocal();
                int i = rl.deleteUtilisateurs(refuser, u.getTuppleID());
                return i;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public ClassMAPTable estIlExiste(ClassMAPTable o) throws Exception {
        try {
            ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(o, null, null, "");
            if (liste.length > 0) {
                return liste[0];
            } else {
                return null;
            }
        } catch (Exception ex) {
            throw ex;
        }
    }

    @Override
    public String createTypeObjet(String nomTable, String proc, String pref, String typ, String desc) throws Exception {
        try {
            if (u.getRang() >= 4) {
                TypeObjet to = new TypeObjet(nomTable, proc, pref, typ, desc);
                String refuser = u.getTuppleID();
                if (refuser != null && refuser.contains("/")) {
                    String[] g = Utilitaire.split(u.getTuppleID(), "/");
                    refuser = g[0];
                }

                MapHistorique histo = new MapHistorique(nomTable, "Insertion par " + u.getTuppleID(), refuser, to.getId());
                histo.setObjet("bean.TypeObjet");
                to.insertToTable(histo);
                String s = to.getId();
                return s;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw ex;
        }
    }

    public String updateBCAvecDetails(BonDeCommande bc, String[] id, String[] pu, String[] quantite, String[] produit, String[] remarque) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            bc.setNomTable("AS_BONDECOMMANDE");
            bc.updateToTableWithHisto(u.getTuppleID(), c);
            for (int i = 0; i < id.length; i++) {
                double qte = Utilitaire.stringToDouble(quantite[i]);
                if (qte >= 0) {
                    BonDeCommandeFille p = new BonDeCommandeFille();
                    p.setId(id[i]);
                    BonDeCommandeFille[] lsd = (BonDeCommandeFille[]) CGenUtil.rechercher(p, null, null, c, " AND IDBC = '" + bc.getTuppleID() + "'");
                    BonDeCommandeFille fille = lsd[0];
                    fille.setPu(Utilitaire.stringToDouble(pu[i]));
//                    fille.setQuantiteparpack(Utilitaire.stringToDouble(quantiteparpack[i]));
                    fille.setQuantite(qte);
                    fille.setProduit(produit[i]);
                    fille.setRemarque(remarque[i]);
                    fille.updateToTableWithHisto(u.getTuppleID(), c);
                }
            }
            c.commit();
            return bc.getTuppleID();
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String saveBCAvecDetails(BonDeCommande bc, String[] id, String[] pu, String[] quantite, String[] remarque, String[] unite, String[] tva) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

//            bc.createObject(""+this.getUser().getRefuser(), c);
            createObject(bc, c);
            double prixu = 0, tvaDouble = 0;
            for (int i = 0; i < id.length; i++) {
                double qte = Utilitaire.stringToDouble(quantite[i]);
                if (qte > 0) {
                    prixu = Utilitaire.stringToDouble(pu[i]);
                    tvaDouble = Utilitaire.stringToDouble(tva[i]);
                    BonDeCommandeFille fille = new BonDeCommandeFille(id[i], bc.getTuppleID(), remarque[i], prixu, 0, qte, unite[i], tvaDouble);
//                    fille.createObject(""+this.getUser().getRefuser(), c);
                    createObject(fille, c);
                }
            }
            c.commit();
            return bc.getTuppleID();
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String updateMontantUnionIntra(String nomTable, String id1, String[] id2, String[] montant) throws Exception {
        Connection c = null;
        Statement st = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            st = c.createStatement();
            for (int i = 0; i < id2.length; i++) {
                bean.UnionIntraTableUtil uiti = new bean.UnionIntraTableUtil();
                uiti.setNomTable(nomTable);
                UnionIntraTable[] liefflc = (UnionIntraTable[]) uiti.rechercher(1, id2[i], c);
                if (liefflc.length == 0) {
                    throw new Exception("le lien n existe pas");
                }
                if (liefflc[0].estIlModifiable() == true) {
                    liefflc[0].setMontantMere(Double.parseDouble(montant[i]));
                    liefflc[0].setNomTable(nomTable);
                    String rek = "update " + nomTable + "  set montantMere = " + montant[i] + " where id1 = '" + liefflc[0].getId1() + "' and id2 = '" + liefflc[0].getId2() + "'";
                    st.executeUpdate(rek);
                }
            }
            c.commit();
            return "ok";
        } catch (SQLException ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception();
        } finally {
            if (c != null) {
                c.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    public String updateMontantUnionORDR(String nomTable, String id1, String[] id2, String[] montant) throws Exception {
        Connection c = null;
        Statement st = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            st = c.createStatement();
            for (int i = 0; i < id2.length; i++) {
                bean.UnionIntraTableUtil uiti = new bean.UnionIntraTableUtil();
                uiti.setNomTable(nomTable);
                UnionIntraTable[] liefflc = (UnionIntraTable[]) uiti.rechercher(1, id2[i], c);
                if (liefflc.length == 0) {
                    throw new Exception("le lien n existe pas");
                }
                if (liefflc[0].estIlModifiable() == true) {
                    liefflc[0].setMontantMere(Double.parseDouble(montant[i]));
                    liefflc[0].setNomTable(nomTable);
                    String rek = "update " + nomTable + "  set montantMere = " + montant[i] + " where id1 = '" + liefflc[0].getId1() + "' and id2 = '" + liefflc[0].getId2() + "'";
                    st.executeUpdate(rek);
                }
            }
            c.commit();
            return "ok";
        } catch (SQLException ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception();
        } finally {
            if (c != null) {
                c.close();
            }
            if (st != null) {
                st.close();
            }
        }
    }

    @Override
    public String updateTypeObjet(String table, String id, String typ, String desc) throws Exception {
        try {
            if (u.getRang() >= 4) {
                TypeObjet to = new TypeObjet(table, id, typ, desc);
                String refuser = u.getTuppleID();
                if (refuser != null && refuser.contains("/")) {
                    String[] g = Utilitaire.split(u.getTuppleID(), "/");
                    refuser = g[0];
                }

                MapHistorique histo = new MapHistorique(table, "update", refuser, to.getId());
                histo.setObjet("bean.TypeObjet");
                to.updateToTableWithHisto(histo);
                String s = to.getId();
                return s;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw ex;
        }
    }

    @Override
    public int deleteTypeObjet(String nomTable, String id) throws Exception {
        try {
            if (u.getRang() >= 4) {
                TypeObjet to = new TypeObjet(nomTable, id, "-", "-");
                String refuser = u.getTuppleID();
                if (refuser != null && refuser.contains("/")) {
                    String[] g = Utilitaire.split(u.getTuppleID(), "/");
                    refuser = g[0];
                }

                MapHistorique h = new MapHistorique(nomTable, "delete", refuser, id);
                h.setObjet("bean.TypeObjet");
                to.deleteToTable(h);
                int i = 1;
                return i;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public MapUtilisateur[] findUtilisateurs(String refuser, String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception {
        try {
            int[] a = {1, 2, 3, 4, 5, 6, 7}; //Donne le numero des champs sur lesquelles on va mettre des criteres
            String[] val = new String[a.length];
            val[0] = refuser;
            val[1] = loginuser;
            val[2] = pwduser;
            val[3] = nomuser;
            val[4] = adruser;
            val[5] = teluser;
            val[6] = idrole; //Affecte des valeurs aux criteres
            UtilisateurUtil cu = new UtilisateurUtil();
            return (MapUtilisateur[]) cu.rechercher(a, val);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public ResultatEtSomme findResultatFinalePage(String nomTable, String apresW, String colonne, String ordre) throws Exception {
//        PassageOptionnelComplet crt = new PassageOptionnelComplet();
//        crt.setNomTable(nomTable);
//        return CGenUtil.rechercherParCritere(crt, apresW + " " + colonne + " " + ordre);
        return null;
    }

    /*
     * public MapUtilisateur[] findUtilisateurs(String refuser, String
     * loginuser, String pwduser, String nomuser, String adruser, String
     * teluser, String idrole) throws Exception { HistoriqueLocal rl = null; try
     * { rl = RecupereLocaleHistorique.recupHome().create(); MapUtilisateur
     * amaputilisateur[] = rl.findUtilisateurs(refuser, loginuser, pwduser,
     * nomuser, adruser, teluser, idrole); return amaputilisateur; }
     * catch(Exception ex) { throw new Exception(ex.getMessage()); } }
     */
    @Override
    public MapRoles[] findRole(String rol) {
        return (MapRoles[]) (new historique.RoleUtil().rechercher(1, rol));
    }

    /*
     * public MapRoles[] findRole(String descRole) throws Exception {
     * HistoriqueLocal rl = null; try { rl =
     * RecupereLocaleHistorique.recupHome().create(); MapRoles amaproles[] =
     * rl.findRole(descRole); return amaproles; } catch(Exception ex) {
     * throw new Exception(ex.getMessage()); } }
     */
    @Override
    public MapUtilisateur getUser() {
        return u;
    }

    public int getMontantBilletage(String dix, String cinq, String deux, String un, String deuxCinq, String deuxCent, String cent, String cinquante, String vingt) {
        int retour1 = Utilitaire.stringToInt(dix) * 10000 + 5000 * Utilitaire.stringToInt(cinq) + 2000 * Utilitaire.stringToInt(deux) + 1000 * Utilitaire.stringToInt(un);
        int retour2 = Utilitaire.stringToInt(deuxCinq) * 500 + 200 * Utilitaire.stringToInt(deuxCent) + 100 * Utilitaire.stringToInt(cent) + 50 * Utilitaire.stringToInt(cinquante) + 20 * Utilitaire.stringToInt(vingt);
        return retour1 + retour2;
    }

    /*
     * public Objet[] findObjet(String obj, String des) throws Exception { try {
     * Objet aobjet[] =
     * RecupereLocaleHistorique.recupHome().create().findObjet(obj, des); return
     * aobjet; } catch(Exception ex) { throw new
     * Exception(ex.getMessage()); } }
     */
    public int desactiveUtilisateur(String ref, String refUser) throws Exception {
        try {
            historique.AnnulationUtilisateur au = new historique.AnnulationUtilisateur(ref);
            historique.MapHistorique h = new historique.MapHistorique("Utilisateurs", "annule", refUser, ref);
            h.setObjet("historique.AnnulationUtilisateur");
            au.insertToTable(h);
            return 1;
        } catch (ErreurDAO ex) {
            throw new bean.ErreurDAO(ex.getMessage());
        }
    }

    public int terminerInterimUtilisateur(String ref, String refUser) throws Exception {
        try {
            String temps = refUser;
            if (refUser != null && refUser.contains("/")) {
                String[] g = Utilitaire.split(refUser, "/");
                refUser = g[0];
            }
            UtilisateurInterim[] lui = (UtilisateurInterim[]) CGenUtil.rechercher(new UtilisateurInterim(), null, null, " AND ID='" + ref + "'");
            if (lui[0].getEtat() == ConstanteEtat.getEtatCreer()) {
                throw new Exception("Impossible de terminer. Utilisateur interim non activer");
            }
            if (lui[0].getEtat() == ConstanteUtilisateur.acteTerminer) {
                throw new Exception("Impossible de terminer. Utilisateur interim terminer");
            }

            lui[0].setEtat(ConstanteUtilisateur.acteTerminer);
            lui[0].setDate_fin(Utilitaire.dateDuJourSql());
            lui[0].upDateToTable();
            historique.MapHistorique h = new historique.MapHistorique("utilisateur.UtilisateurInterim", "Utilisateur interim terminer par " + temps, refUser, ref);
            h.setObjet("utilisateur.UtilisateurInterim");
            h.insertToTable();
            return 1;
        } catch (Exception ex) {
            throw ex;
        }
    }

    @Override
    public int desactiveUtilisateur(String ref) throws Exception {

        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {

                int i = desactiveUtilisateur(ref, u.getTuppleID());
                return i;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public int terminerInterimUtilisateur(String ref) throws Exception {

        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {

                int i = terminerInterimUtilisateur(ref, u.getTuppleID());
                return i;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw ex;
        }
    }

    public int activeUtilisateur(String ref, String refUser) throws Exception {
        try {
            String temps = refUser;
            if (refUser != null && refUser.contains("/")) {
                String[] g = Utilitaire.split(refUser, "/");
                refUser = g[0];
            }
            UtilisateurInterim[] lui = (UtilisateurInterim[]) CGenUtil.rechercher(new UtilisateurInterim(), null, null, " AND ID='" + ref + "'");
            if (lui[0].getEtat() == ConstanteUtilisateur.acteActiver) {
                throw new Exception("Impossible de activer. Utilisateur interim activer");
            }
            lui[0].setEtat(ConstanteUtilisateur.acteActiver);
            lui[0].setDate_debut(Utilitaire.dateDuJourSql());
            lui[0].setDate_fin(null);
            lui[0].upDateToTable();
            historique.MapHistorique h = new historique.MapHistorique("utilisateur.UtilisateurInterim", "Utilisateur interim activer par " + temps, refUser, ref);
            h.setObjet("utilisateur.UtilisateurInterim");
            h.insertToTable();
            return 1;
        } catch (Exception ex) {
            throw ex;
        }
    }

    @Override
    public int activeUtilisateur(String ref) throws Exception {

        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {

                int i = activeUtilisateur(ref, u.getTuppleID());
                return i;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapUtilisateurServiceDirection testeValide(String user, String pass, String interim, String service) throws Exception {
        try {
            historique.UtilisateurUtil uI = new UtilisateurUtil();
            return uI.testeValide(user, pass, interim, service);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    /*
     * public Direction[] findDirection(String idDir, String libelledir, String
     * descdir, String abbrevDir, String idDirecteur) throws Exception {
     * Direction crt=new Direction(); crt.setIdDir(idDir);
     * crt.setLibelledir(libelledir); crt.setDescdir(descdir);
     * crt.setAbbrevDir(abbrevDir); //
     * crt.setIdDirecteur((double)(idDirecteur)); return
     * (Direction[])CGenUtil.rechercher(crt,null,null,""); //LCEjbLocal lci =
     * null;
     *
     * }
     */
    public String findHomePageServices(String codeService) throws Exception {
        Connection connection = null;
        try {
            connection = (new UtilDB()).GetConn();
            HomePageURL[] hommePageList = (HomePageURL[]) CGenUtil.rechercher(new HomePageURL(), null, null, connection, " and idrole = '" + codeService + "'");
            if (hommePageList != null && hommePageList.length > 0) {
                this.home_page = hommePageList[0].getUrlpage();
            }
            return this.home_page;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    @Override
    public Configuration[] findConfiguration() throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Configuration[] liste = (Configuration[]) CGenUtil.rechercher(new Configuration(), null, null, c, " order by typeconfig desc");
            return liste;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public Direction[] findDirection(String idDir, String libelledir, String descdir, String abbrevDir, String idDirecteur) throws Exception {

        try {
            String afterW = "";
            int[] numChamp = {1, 2, 3, 5};
            String[] val = {idDir, libelledir, descdir, abbrevDir};
            DirectionUtil du = new DirectionUtil();
            du.utiliserChampBase();
            //if(idDirecteur.compareToIgnoreCase("")==0 || idDirecteur.compareToIgnoreCase("%")==0) idDirecteur = "%";
            //afterW=" AND idDirecteur like  '" + idDirecteur +"'";
            return (Direction[]) du.rechercher(numChamp, val, "");

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    @Override
    public TypeObjet[] findTypeObjet(String nomTable, String id, String typ) throws Exception {
        try {
            TypeObjetUtil to = new TypeObjetUtil();
            TypeObjet atypeobjet[] = to.findTypeObjet(nomTable, id, typ);
            return atypeobjet;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void testLogin(String user, String pass, String interim, String service) throws Exception {
        testLogin(user, pass, interim, service, null);
    }

    @Override
    public void testLogin(String user, String pass, String interim, String service, String escale) throws Exception {
        Connection c = null;
        try {

            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            u = testeValide(user, pass, interim, service);
            TypeObjet tob = new TypeObjet();
            tob.setNomTable("caisse");
            TypeObjet[] li = (TypeObjet[]) CGenUtil.rechercher(tob, null, null, c, "");
            if (li.length > 0) {
                caisse = li[0];
            }
            //System.out.println("passe mot : "+pass);
            //System.out.println("hita le vue utilisateur !!!!!!!!!!!!!!!!!!!!");
            UtilisateurUtil crt = new UtilisateurUtil();
            // System.out.println("hatreto mety");
            uVue = crt.testeValide("utilisateurVue", user, pass);
            //System.out.println("hatreto mety");
            type = u.getIdrole();
            if (type.compareToIgnoreCase(utilitaire.Constante.getIdRoleDirecteur()) == 0) {
                Direction d[] = findDirection("", "", "", "", String.valueOf(u.getRefuser()));
                //System.out.println("hatreto mety "+d.length);
                if (d.length > 0) {
                    this.setIdDirection(d[0].getIdDir());
                } else {
                    //u.setIdrole("compta"); //atao compta parDefaut aloha
                    type = u.getIdrole();
                }
            }
            CNAPSUser[] cnp = (CNAPSUser[]) CGenUtil.rechercher(new CNAPSUser(), null, null, c, " and id_utilisateur = '" + u.getRefuser() + "'");
            if (type.compareToIgnoreCase(Constante.getRoleCommandant()) == 0) {
                TypeObjet to = new TypeObjet();
                to.setNomTable("commandant");
                TypeObjet[] listeCommandant = (TypeObjet[]) CGenUtil.rechercher(to, null, null, c, " and iduser='" + u.getRefuser() + "'");
                if (listeCommandant == null || listeCommandant.length == 0) {
                    throw new Exception("Commandant introuvable");
                }
                this.commandant = listeCommandant[0];
                if (escale != null && escale.length() > 0) {
                    Prevision previsionTemp = new Prevision();
                    previsionTemp.setEscale(escale);
                    this.prevision = (Prevision) previsionTemp.getById(null, "PREVISION", c);
                }
            }
            this.cnapsUser = (cnp != null) ? cnp[0] : null;
            if (interim != null && interim.compareToIgnoreCase("1") == 0 && cnp.length > 0) {
                LogService[] ls = (LogService[]) CGenUtil.rechercher(new LogService(), null, null, c, " AND ID = '" + service + "'");
                if (ls.length == 0) {
                    throw new Exception("SERVICE INTROUVABLE");
                }
                this.cnapsUser = new CNAPSUser(cnp[0].getCode_dr(), cnp[0].getUser_init(), cnp[0].getAgent_mo(), cnp[0].getAgent_disponible(), cnp[0].getUsername(), ls[0].getCode_service(), u.getRefuser() + "");
            }

            String idCodeEtablissement = u.getCodeEtablissement();
            if (idCodeEtablissement != null && !idCodeEtablissement.isEmpty()) {
                this.codeEtablissement = (CodeEtablissement) CGenUtil.rechercher(new CodeEtablissement(), null, null, c, String.format(" and id like '%s'", idCodeEtablissement))[0];
            }

            this.listeConfig = this.findConfiguration();

            TypeObjet to = new TypeObjet();
            to.setNomTable("SOURCE");
            setListeSource((TypeObjet[]) CGenUtil.rechercher(to, null, null, c, ""));

            /*UtilisateurRole[] liste_util = (UtilisateurRole[]) CGenUtil.rechercher(new UtilisateurRole(), null, null, c, " and rang <= " + u.getRang());
             String[] users = new String[liste_util.length];
             for (int i = 0; i < liste_util.length; i++) {
             users[i] = liste_util[i].getRefuser() + "";
             }
             String retour = Utilitaire.tabToString(users, "'", ",");
             usersInferieurEnCours = retour;*/
            //u.setRefuser(u.getRefuser());
            u.setPwduser(getAddrIp());
            MapHistorique histo = new MapHistorique("login", "login", String.valueOf(u.getRefuser()), String.valueOf(u.getRefuser()));
            histo.setObjet("mg.cnaps.utilisateur.CNAPSUser");
            histo.setAction(histo.getAction() + "-" + getAddrIp());
            histo.insertToTable();
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void ejbCreate() throws Exception {
    }

    @Override
    public String getIdDirection() {
        return idDirection;
    }

    @Override
    public void setIdDirection(String idDirection) {
        this.idDirection = idDirection;
    }

    @Override
    public String mapperMereFille(ClassMAPTable e, String idMere, String[] idFille, String rem, String montant, String etat) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            mapperMereFille(e.getNomTable(), e.getNomProcedureSequence(), e.getINDICE_PK(), idMere, idFille, rem, montant, etat, c);
            c.commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return null;
    }

    @Override
    public String mapperMereFille(ClassMAPTable e, String nomTable, String idMere, String[] idFille, String rem, String montant, String etat) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String nomProcedure = "getSeq" + Utilitaire.convertDebutMajuscule(nomTable);
            String indicePK = nomTable.substring(0, 3).toUpperCase();
            mapperMereFille(nomTable, nomProcedure, indicePK, idMere, idFille, rem, montant, etat, c);
            c.commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return null;
    }

    @Override
    public void deleteMereFille(ClassMAPTable e, String idMere, String[] liste_id_fille) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            deleteMereFille(e.getNomTable(), idMere, liste_id_fille, c);
            c.commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String mapperMereFille(String nomtableMappage, String nomProcedure, String suffixeMap, String idMere, String[] idFille, String rem, String montant, String etat, Connection c) throws Exception {
        try {
            for (int i = 0; i < idFille.length; i++) {
                UtilitaireMetier.mapperMereToFille(nomtableMappage, nomProcedure, suffixeMap, idMere, idFille[i], rem, montant, u.getTuppleID(), etat, c);
            }

        } catch (Exception e) {
            throw e;
        }
        return null;
    }

    public void deleteMereFille(String nomtableMappage, String idMere, String[] idFille, Connection c) throws Exception {
        try {
            for (int i = 0; i < idFille.length; i++) {
                UtilitaireMetier.deleteMereToFille(nomtableMappage, idMere, idFille[i], u.getTuppleID(), c);
            }
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void deleteMereFille(ClassMAPTable e, String nomTable, String idMere, String[] liste_id_fille) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            deleteMereFille(nomTable, idMere, liste_id_fille, c);

            c.commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public boolean testMemeUser(int userAutres) throws Exception {
        if (u.getRefuser() != (userAutres)) {
            throw new Exception("Utilisateur different de vous");
        }
        return true;
    }

    public boolean testMemeDirection(int userAutres) throws Exception {
        boolean retour = true;
        MapUtilisateur crt = new MapUtilisateur();
        MapUtilisateur[] t = (MapUtilisateur[]) (bean.CGenUtil.rechercher(crt, null, null, " and refuser=" + userAutres));
        if (t.length == 0) {
            throw new Exception("Utilisateur finale " + userAutres + " non existante");
        }
        //System.out.println("u adre user = "+t.length+" t[0] adr user = "+t[0].getAdruser()+" t[0] id user = "+userAutres);
        if (u.getAdruser().compareToIgnoreCase(t[0].getAdruser()) != 0) {
            throw new Exception("Utilisateur dans une autre direction");
        }
        return retour;
    }

    public String testRangUser(ClassMAPTable e, Connection c) throws Exception {
        String retour = "";
        if (e instanceof bean.ClassEtat || e instanceof bean.ClassUser) {
            if (e instanceof mg.cnaps.notification.NotificationLibelle) {
                return NotificationService.conditionLectureNotification(u);
            } else {
                UtilisateurRole[] utilEnCours = (UtilisateurRole[]) CGenUtil.rechercher(new UtilisateurRole(), null, null, c, " and refuser=" + u.getTuppleID());
                if (utilEnCours.length > 0) {
                    if (utilEnCours[0].getRang() < Constante.getRangMahitaNyHafa()) {
                        retour += " and iduser='" + utilEnCours[0].getRefuser() + "' ";

                        if (this.getCodeEtablissement() != null) {
                            if(CGenUtil.getField(e, "codeetablissement") != null) {
                                String codeEtablissement = this.getCodeEtablissement().getId();
                                if (codeEtablissement != null && !codeEtablissement.isEmpty()) {
                                    retour += String.format(" and codeetablissement like '%s'", codeEtablissement);
                                }
                            }
                        }
                    }
                }
            }
        }
        return retour;
    }

    @Override
    public ResultatEtSomme getDataPageMax(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c) throws Exception {
        return getDataPageMax(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, 0);
    }

    @Override
    public ResultatEtSomme getDataPageMax(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int npp) throws Exception {
        e.setMode("select");
        if (ListeColonneTable.getChamp(e, "iduser", c) != null) {
            ClassUser temp = (ClassUser) e;
            apresWhere = testRangUser(e, c) + apresWhere;
        }
        if (e.getNomTableSelect().compareToIgnoreCase("SIG_TRAVAILLEUR_INFO_COMPLET") == 0) {
            return CGenUtil.rechercherPageMaxSansRecap(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, npp);
        }
        //System.out.println("apres where vaovao oooo "+apresWhere+ "user vaovao ooo"+u.getTuppleID());
        return CGenUtil.rechercherPageMax(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, npp);
    }

    @Override
    public ResultatEtSomme getDataPageMaxSansRecap(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int npp) throws Exception {
        e.setMode("select");
        if (ListeColonneTable.getChamp(e, "iduser", c) != null) {
            ClassUser temp = (ClassUser) e;
            apresWhere = testRangUser(e, c) + apresWhere;
        }

        return CGenUtil.rechercherPageMaxSansRecap(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, npp);
    }

    @Override
    public ResultatEtSomme getDataPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c) throws Exception {
        return getDataPage(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, 0);
    }

    @Override
    public ResultatEtSomme getDataPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int npp) throws Exception {
        e.setMode("select");
        if (ListeColonneTable.getChamp(e, "iduser", c) != null) {
            apresWhere = testRangUser(e, c) + apresWhere;
        }
        return CGenUtil.rechercherPage(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, npp);
    }

    @Override
    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        e.setMode("select");
        if (ListeColonneTable.getChamp(e, "iduser", c) != null) {
            apresWhere = testRangUser(e, c) + apresWhere;
        }
        return CGenUtil.rechercherPageGroupe(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c);
    }

    @Override
    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception {
        e.setMode("select");
        if (ListeColonneTable.getChamp(e, "iduser", c) != null) {
            apresWhere = testRangUser(e, c) + apresWhere;
        }
        return CGenUtil.rechercherPageGroupe(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c, npp);
    }

    @Override
    public Object[] getData(ClassMAPTable e, String[] colInt, String[] valInt, Connection c, String apresWhere) throws Exception {
        e.setMode("select");
        if (ListeColonneTable.getChamp(e, "iduser", c) != null) {
            apresWhere = testRangUser(e, c) + apresWhere;
        }
        if (c == null) {
            return CGenUtil.rechercher(e, colInt, valInt, apresWhere);
        }
        return CGenUtil.rechercher(e, colInt, valInt, c, apresWhere);
    }

    public int getint() {
        return 0;
    }

    public String getMaxId(String table) throws Exception {
        Connection c = null;
        String retour = "---";
        try {
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            java.sql.ResultSet res = sta.executeQuery("select max(id) from " + table);
            res.next();
            retour = res.getString(1);
        } catch (Exception e) {
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return retour;
    }

    public String getMaxId(String table, String[] colonne, String[] listeCritere) throws Exception {
        String retour = "----";
        int tailleCrt = listeCritere.length;
        Connection c = null;
        try {
            String temp = "select max(id) from " + table + " ";
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            temp += "where " + colonne[0] + " ='" + listeCritere[0] + "'";
            //System.out.println("TY LE TEMP "+temp);
            if (tailleCrt > 1) {
                for (int i = 1; i < tailleCrt; i++) {
                    temp += " and " + colonne[i] + " = '" + listeCritere[i] + "'";
                }
            }
            java.sql.ResultSet res = sta.executeQuery(temp);
            res.next();
            retour = res.getString(1);
        } catch (Exception e) {
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return retour;
    }

    public static String getMaxColonne(String table, String colonne, String champCritere, String critere) throws Exception {
        String retour = "----";
        Connection c = null;
        try {
            String temp = "select max(" + colonne + ") from " + table + " where " + champCritere + "= " + critere;
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();

            //System.out.println("TY LE TEMP "+temp);
            java.sql.ResultSet res = sta.executeQuery(temp);
            res.next();
            retour = res.getString(1);
        } catch (Exception e) {
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return retour;
    }

    public Object validerObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object ob = validerObject(o, c);
            c.commit();
            return ob;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void testValidationEtat(ClassMAPTable o, Connection c) throws Exception {
        try {
            String id = o.getValInsert("id");
            ClassMAPTable cl = (ClassMAPTable) Class.forName(o.getClassName()).newInstance();
            cl.setNomTable(o.getNomTable());
            ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(cl, null, null, c, " and id = '" + id + "'");

            if (liste.length == 0) {
                throw new Exception("Objet inexistant");
            }
            if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0) {
                int ret = Utilitaire.stringToInt(liste[0].getValInsert("etat")) % 10;
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) == ConstanteEtat.getEtatAnnuler()) {
                    throw new Exception("IMPOSSIBLE DE VISER. OBJET ANNULE");
                }
                if (ret == 0 && Utilitaire.stringToInt(liste[0].getValInsert("etat")) > 0) {
                    throw new Exception("IMPOSSIBLE DE VISER. OBJET REJETE");
                }
                //System.out.println("etaaaaaaaaaaaaaaaaaaaaaaaaaaa"+Utilitaire.stringToInt(liste[0].getValInsert("etat")));
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) >= ConstanteEtat.getEtatValider()) {
                    throw new Exception("IMPOSSIBLE DE VISER. OBJET DEJA VISE");
                }
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public Object validerObject(ClassMAPTable o, Connection c) throws Exception {
        if (u.getRang() < 4 && o.getClassName().compareTo("mg.cnaps.compta.ComptaEcriture") != 0) // (testRestriction(u.getIdrole(), "ACT000006", o.getNomTable(), c) == 1)
        {
            throw new Exception("ERREUR DE DROIT");
        }
        if (o.getClassName().compareTo("cotation.Cotation") == 0 && u.getRang() < 4) {
            throw new Exception("ERREUR DE DROIT");
        }
        if (o.getClassName().compareTo("cotation.InfoManquant") == 0 && u.getRang() < 4) {
            throw new Exception("ERREUR DE DROIT");
        }
        if (o.getClassName().compareTo("cotation.DemandeCotation") == 0 && u.getRang() < 4) {
            throw new Exception("ERREUR DE DROIT");
        }
        if (u.getRang() < 4) {
            throw new Exception("ERREUR DE DROIT");
        }
        //testValidationEtat(o, c);
        try {
            return ValiderObject.validerObject(c, o, this, u, listeConfig);
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        }
    }

    public Object cloturerObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object ob = cloturerObject(o, c);
            c.commit();
            return ob;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void testClotureEtat(ClassMAPTable o, Connection c) throws Exception {
        try {
            String id = o.getValInsert("id");
            ClassMAPTable cl = (ClassMAPTable) Class.forName(o.getClassName()).newInstance();
            cl.setNomTable(o.getNomTable());
            ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(cl, null, null, c, " and id = '" + id + "'");
            if (liste.length == 0) {
                throw new Exception("Objet inexistante");
            }
            if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0) {
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) == ConstanteEtat.getEtatAnnuler()) {
                    throw new Exception("Impossible de cloturer. Objet annul�");
                }
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) >= ConstanteEtat.getEtatCloture()) {
                    throw new Exception("Impossible de cloturer. Objet d�j� vis� ou rejet� ou clotur�");
                }
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public Object cloturerObject(ClassMAPTable o, Connection c) throws Exception {
        //System.out.println("u.getRang() = " + u.getRang());
        if (u.getRang() < 6) {
            throw new Exception("ERREUR DE DROIT");
        }
        testClotureEtat(o, c);
        try {
            o.setMode("modif");

            //this.updateEtat(o, ConstanteEtat.getEtatCloture(), o.getValInsert("id"), c);
            c.commit();
            return o;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public Object rejeterObject(ClassMAPTable o, ClassMAPTable mere) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object ob = rejeterObject(o, mere, c);
            c.commit();
            return ob;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void testRejectEtat(ClassMAPTable o, ClassMAPTable mere, Connection c) throws Exception {
        try {
            String id = o.getValInsert("mere");
            ClassMAPTable cl = (ClassMAPTable) Class.forName(mere.getClassName()).newInstance();
            cl.setNomTable(mere.getNomTable());
            ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(cl, null, null, c, " and id = '" + id + "'");
            if (liste.length == 0) {
                throw new Exception("Objet inexistante");
            }
            if (mere.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0) {
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) == ConstanteEtat.getEtatAnnuler()) {
                    throw new Exception(" Impossible de rejeter. Objet annul�");
                }
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) == ConstanteEtat.getEtatRejeter()) {
                    throw new Exception(" Impossible de rejeter. Objet d�j� rejet�");
                }
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) >= ConstanteEtat.getEtatValider()) {
                    throw new Exception(" Impossible de rejeter. Objet d�j� vis�");
                }
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public Object rejeterObject(ClassMAPTable o, ClassMAPTable mere, Connection c) throws Exception {
        if (testRestriction(u.getIdrole(), "ACT000007", o.getNomTable(), c) == 1) {
            throw new Exception("ERREUR DE DROIT");
        }

        testRejectEtat(o, mere, c);
        try {
            o.setMode("modif");

            //this.updateEtat(o, ConstanteEtat.getEtatRejeter(), o.getValInsert("id"), c);
            c.commit();
            return o;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public void setEtat(ClassEtat o, Integer paramT) throws Exception {
        String nomChamp = "etat";
        o.setValChamp(nomChamp, paramT);
    }

    public Object createObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object ob = createObject(o, c);
            c.commit();
            return ob;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }

    }

    @Override
    public Object[] createObjectMultiple(ClassMAPTable[] o, Connection c) throws Exception {
        try {
            Object[] ret = new Object[o.length];
            for (int i = 0; i < o.length; i++) {
                ret[i] = createObject(o[i], c);
            }

            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        }

    }

    public Object[] updateObjectMultiple(ClassMAPTable[] o, Connection c) throws Exception {
        try {
            Object[] ret = new Object[o.length];
            //System.out.println("o.length = " + o.length);
            for (int i = 0; i < o.length; i++) {
                ret[i] = updateObject(o[i], c);
            }
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        }

    }

    public Object[] createObjectMultiple(ClassMAPTable[] o) throws Exception {
        Connection c = null;
        Object[] ret = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            ret = createObjectMultiple(o, c);
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public Object[] updateObjectMultiple(ClassMAPTable[] o) throws Exception {
        Connection c = null;
        Object[] ret = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            ret = updateObjectMultiple(o, c);
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public void createAvancementMultiple(String idavac, String sem, String entree, String prom, String option) throws Exception {
        Connection c = null;
        PreparedStatement stmt = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String sql = "INSERT INTO avancement VALUES(?,?,?,?,?)";
            stmt = c.prepareStatement(sql);
            stmt.setString(1, idavac);
            stmt.setString(2, sem);
            stmt.setString(3, entree);
            stmt.setString(4, prom);
            stmt.setString(5, option);
            stmt.executeUpdate();
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void updateEtat(ClassMAPTable e, int valeurEtat, String id) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            //updateEtat(e, valeurEtat, id, c);
            c.commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void marquerLuMessage(Message[] listMessage) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            for (int i = 0; i < listMessage.length; i++) {
                if (listMessage[i].getStatut().compareToIgnoreCase("nonlu") == 0) {
                    listMessage[i].setStatut("lu");
                    listMessage[i].updateToTable(c);
                }
            }
            c.commit();
        } catch (Exception e) {
            c.rollback();
            throw e;
        }
    }

    public int validerObjectMultiple(ClassEtat[] o, Connection c) throws Exception {
        try {
            for (int i = 0; i < o.length; i++) {
                ClassEtat map = ((ClassEtat[]) CGenUtil.rechercher(o[i], null, null, c, ""))[0];
                map.setMode("modif");
                setEtat(map, ConstanteEtat.getEtatObjetValider());
                map.updateToTableWithHisto(u.getTuppleID(), c);
            }
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int viserObjectMultiple(ClassEtat o, String[] listeIdObjet, Connection c) throws Exception {
        try {
            String script = Utilitaire.tabToString(listeIdObjet, "'", ",");
            String table_name = o.getNomTable();
            if (table_name.compareToIgnoreCase("POINT_HEURESUPP_LIBELLE_AVISER") == 0) {
                script = "Select id from POINT_HEURESUPP_LIBELLE_AVISER ";
                o.setNomTable("point_heuresupp");
            }
            if (o.getClassName().compareTo("mg.gallois.facture.FactureClient") == 0) {
                o.setNomTable("facture_client");
            }
            if (o.getClassName().compareTo("mg.cnaps.paie.Elementpaiemanuel") == 0) {
                o.setNomTable("elementpaiemanuel");
            }
            if (o.getClassName().compareTo("mg.spat.JournalCaisse") == 0) {
                String id = Utilitaire.tabToString(listeIdObjet, "'", ",");
                JournalCaisse[] tJournalCaisse = (JournalCaisse[]) CGenUtil.rechercher(new JournalCaisse(), null, null, c, " and id in (" + id + ")");
                for (int i = 0; i < tJournalCaisse.length; i++) {
                    if (tJournalCaisse[0].getDateEffet() != tJournalCaisse[i].getDateEffet()) {
                        throw new Exception("Impossible de viser sur des dates differentes");
                    }
                }
            }
            String apw = " and " + o.getAttributIDName() + " in (" + script + " )";
            //System.out.println("apw = " + apw);
            ClassEtat[] mapTableListe = (ClassEtat[]) CGenUtil.rechercher(o, null, null, c, apw);
            for (int i = 0; i < mapTableListe.length; i++) {
                mapTableListe[i].setMode("modif");
                mapTableListe[i].setNomTable(o.getNomTable());
                this.validerObject(mapTableListe[i], c);
            }
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public int marquerLuMultiple(ClassEtat o, String[] listeIdObjet, Connection c) throws Exception {
        try {
            String script = Utilitaire.tabToString(listeIdObjet, "'", ",");
            String apresSet = " etat = 2 where " + o.getAttributIDName() + " in (" + script + " )";
            o.updateToTable(apresSet, c);
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public int viserObjectMultiple(ClassEtat o, String[] listeIdObjet) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int r = viserObjectMultiple(o, listeIdObjet, c);

            c.commit();
            return r;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int marquerLuMultiple(ClassEtat o, String[] listeIdObjet) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int r = marquerLuMultiple(o, listeIdObjet, c);

            c.commit();
            return r;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public int retournerObjectMultiple(ClassEtat o, String[] listeIdObjet, String motif) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int r = retournerObjectMultiple(o, listeIdObjet, motif, c);
            c.commit();
            return r;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public int recuObjectMultiple(ClassEtat o, String[] listeIdObjet) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int r = recuObjectMultiple(o, listeIdObjet, c);
            c.commit();
            return r;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int recuObjectMultiple(ClassEtat o, String[] listeIdObjet, Connection c) throws Exception {
        try {

            String script = Utilitaire.tabToString(listeIdObjet, "'", ",");
            String apw = " and " + o.getAttributIDName() + " in (" + script + " )";

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int retournerObjectMultiple(ClassEtat o, String[] listeIdObjet, String motif, Connection c) throws Exception {
        try {

            String script = Utilitaire.tabToString(listeIdObjet, "'", ",");
            String apw = " and " + o.getAttributIDName() + " in (" + script + " )";

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int rejeterObjectMultiple(ClassEtat o, String[] listeIdObjet, Connection c, String nomTableRejet, String nomTableCategorieRejet) throws Exception {
        try {
            String script = Utilitaire.tabToString(listeIdObjet, "'", ",");
            ClassEtat[] mapTableListe = (ClassEtat[]) CGenUtil.rechercher(o, null, null, c, " and upper(" + o.getAttributIDName() + ") in (" + script + " )");
            if (mapTableListe != null && testRestriction(u.getIdrole(), "ACT000006", mapTableListe[0].getNomTable(), c) == 1) {
                throw new Exception("ERREUR DE DROIT");
            }
            TypeObjet to = new TypeObjet();
            to.setNomTable(nomTableCategorieRejet);
            TypeObjet toVal = (TypeObjet) CGenUtil.rechercher(to, null, null, c, "")[0];
            for (int i = 0; i < mapTableListe.length; i++) {
                mapTableListe[i].setMode("modif");
                setEtat(mapTableListe[i], ConstanteEtat.getEtatObjetRejeter());
                mapTableListe[i].updateToTableWithHisto(u.getTuppleID(), c);
                RejetTable rejet = new RejetTable(Utilitaire.dateDuJourSql(), "rejet multiple", listeIdObjet[i], "rejet multiple", toVal.getId());
                rejet.setNomTable(nomTableRejet);
                this.createObject(rejet, c);
            }
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int rejeterObjectMultiple(ClassEtat o, String[] listeIdObjet, String nomTableRejet, String nomTableCategorieRejet) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int r = rejeterObjectMultiple(o, listeIdObjet, c, nomTableRejet, nomTableCategorieRejet);
            c.commit();
            return r;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int cloturerObjectMultiple(ClassEtat o, String[] listeIdObjet) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            //int r = cloturerObjectMultiple(o, listeIdObjet, c);
            c.commit();
            return 0; //r
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int validerObjectMultiple(ClassEtat[] o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int r = validerObjectMultiple(o, c);
            c.commit();
            return r;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int saveDNMultiple(String periode, Connection c) throws Exception {
        CallableStatement cst = null;
        try {
            String sqlstatement = "{call saveTypeContactEmployeurs(?,?)}";
            //String sqlstatement = "{call saveTypeContactEmployeurs('"+periode+"','"+u.getTuppleID()+"')}";
            cst = c.prepareCall(sqlstatement);
            cst.setString(1, periode);
            String refuser = u.getTuppleID();
            if (refuser != null && refuser.contains("/")) {
                String[] g = Utilitaire.split(refuser, "/");
                refuser = g[0];
            }
            cst.setString(2, refuser);
            //cst = c.prepareCall(sqlstatement);
            cst.executeUpdate();
            //cst.executeUpdate();
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (cst != null) {
                cst.close();
            }
        }
    }

    public int saveDNMultiple(String periode) throws Exception {
        Connection connection = null;

        try {
            connection = (new UtilDB()).GetConn();
            connection.setAutoCommit(false);
            int i = saveDNMultiple(periode, connection);
            connection.commit();
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    public String genererEnfantMatricule(String motherName, String sexe, Date dateNaissance, String nationalite, String numActe) throws Exception {
        try {
            System.out.println("----------------------motherName = " + motherName);
            String anneeDeNaissance = Utilitaire.getAnnee(dateNaissance) + "";
            int moisDeNaissance = Utilitaire.getMois(dateNaissance);
            String jour = Utilitaire.getJour(Utilitaire.datetostring(dateNaissance));

            String premierChiffreAnnee = anneeDeNaissance.substring(0, 1);
            String rangMoisLettre = "";
            String millenismeAnnee = anneeDeNaissance.substring(2, 4);
            int rangMoisNaissance;
            int rangJourNaissance;

            if (sexe.compareToIgnoreCase("0") == 0) { //1989
                rangMoisLettre = Utilitaire.getRangMoisLettre(moisDeNaissance + 12);
            } else {
                rangMoisLettre = Utilitaire.getRangMoisLettre(moisDeNaissance);
            }

            if (nationalite.compareToIgnoreCase("1") == 0) { //1989
                rangJourNaissance = Integer.parseInt(jour) + 40;
            } else {
                rangJourNaissance = Integer.parseInt(jour);
            }

            // System.out.println("premierChiffreAnnee == " + premierChiffreAnnee + "millenismeAnnee = " + millenismeAnnee + " rangMoisLettre = " + rangMoisLettre + " rangJourNaissance = " + rangJourNaissance + " numActe = " + numActe);
            // System.out.println(premierChiffreAnnee + "" + millenismeAnnee + "" + rangMoisLettre + "" + rangJourNaissance + "" + numActe);
            String temp = premierChiffreAnnee + "" + millenismeAnnee + "" + rangMoisLettre + "" + String.format("%02d", rangJourNaissance) + "" + numActe;
            // cryptage du mere

            // dechifrer
            double nom_dechiffrer = Utilitaire.dechiffrer(motherName);

            //System.out.println(" dechiffrement ========= " + nom_dechiffrer);
            String val_hex_nom = Utilitaire.completerInt(6, (int) nom_dechiffrer);

            System.out.println(" valeur hexa ========= " + val_hex_nom);

            temp += val_hex_nom;
            return temp;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }

    public String genererTravailleurMatricule(String idTravailleur, String sexe, Date dateNaissance) throws Exception {
        try {
            String anneeDeNaissance = Utilitaire.getAnnee(dateNaissance) + "";
            int moisDeNaissance = Utilitaire.getMois(dateNaissance);
            String jour = Utilitaire.getJour(Utilitaire.datetostring(dateNaissance));
            //System.out.println("naiss au depart : "+jour+"|"+moisDeNaissance+"|"+anneeDeNaissance);
            String millenismeAnnee = anneeDeNaissance.substring(2, 4);
            int rangMoisNaissance;
            int rangJourNaissance = Integer.parseInt(jour);
            String numeroSequence = idTravailleur.substring(6, 10);

            if (sexe.compareToIgnoreCase("0") == 0) { //1989
                rangMoisNaissance = moisDeNaissance + 20;
            } else {
                rangMoisNaissance = moisDeNaissance;
            }

            //rangMoisNaissance = Integer.parseInt(String.format("%1$02d", rangMoisNaissance));
            String numTemp = millenismeAnnee + "" + String.format("%1$02d", rangMoisNaissance) + "" + String.format("%1$02d", rangJourNaissance) + "" + numeroSequence;
            //System.out.println("numTemp = " + numTemp);
            long randumNumber = Long.parseLong(numTemp) % 97;
            System.out.println("randumNumber = " + randumNumber);
            //System.out.println("millenismeAnnee = " + millenismeAnnee + " rangMoisNaissance = " + rangMoisNaissance + " rangJourNaissance = " + rangJourNaissance + " numeroSequence = " + numeroSequence + " randumNumber = " + randumNumber);
            numTemp += randumNumber + "";

            return numTemp;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }

    public Object finaliser(ClassMAPTable o, Connection c) throws Exception {
        try {
            o.setMode("modif");

        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
        return null;
    }

    public Object finaliser(ClassMAPTable map) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            Object ret = finaliser(map, c);
            //c.commit();
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object createObject(ClassMAPTable o, Connection c) throws Exception {
        if (u.getRang() < 1) // (testRestriction(u.getIdrole(), "ACT000006", o.getNomTable(), c) == 1)
        {
            throw new Exception("ERREUR DE DROIT");
        }
        try {
            if (o.getMode() != null && o.getMode().compareToIgnoreCase("annul") == 0) {
                o.setMode("annul");
                CreateObject.createObject(o, c, u, this, listeConfig, getListeSource());
                return ValiderObject.validerObject(c, o, this, uVue, listeConfig);
            } else {
                o.setMode("modif");
                return CreateObject.createObject(o, c, u, this, listeConfig, getListeSource());
            }
        } catch (Exception ex) {
            //c.rollback();
            ex.printStackTrace();
            throw ex;
        }
    }

    public Object updateObject(ClassMAPTable o) throws Exception {
        Connection c = null;

        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            updateObject(o, c);
            c.commit();
            return o;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void testUpdate(ClassMAPTable o, Connection c) throws Exception {
        try {
            if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0) {
                String id = o.getValInsert(o.getAttributIDName());
                ClassMAPTable cl = (ClassMAPTable) Class.forName(o.getClassName()).newInstance();
                cl.setNomTable(o.getNomTable());
                ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(cl, null, null, c, " and " + o.getAttributIDName() + " = '" + id + "'");
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) == ConstanteEtat.getEtatAnnuler()) {
                    throw new Exception(" Impossible de modifier. Objet annulé");
                }
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) >= ConstanteEtat.getEtatValider()) {
                    throw new Exception(" Impossible de modifier. Objet déja visé");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public Object updateObject(ClassMAPTable o, Connection c) throws Exception {
        //Connection c=null;
        //System.out.println("ato updateObject");
        /*if (testRestriction(u.getIdrole(), ConstanteUtilisateur.acteUpdate, o.getNomTable(), c) == 1) {
            throw new Exception("ERREUR DE DROIT");
        }*/
        if (o.getClassName().compareToIgnoreCase("mg.spat.Tiers") != 0 && o.getClassName().compareToIgnoreCase("mg.cnaps.paie.EmployeComplet") != 0 && o.getClassName().compareToIgnoreCase("mg.spat.compta.ContratChantier") != 0) {
            testUpdate(o, c);
        }

        try {
            return UpdateObject.updateObject(o, c, u, this);
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        }

    }

    public void testDelete(ClassMAPTable o, Connection c) throws Exception {
        try {
            //System.out.println("miditra delete");
            if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0) {
                String id = o.getValInsert("id");
                ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(o, null, null, c, "");
                // System.out.println("ffffffffffffffffffffff=="+liste[0].getValInsert("etat"));
                if (liste.length == 0) {
                    throw new Exception("Objet inexistant");
                }
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) >= ConstanteEtat.getEtatValider()) {
                    throw new Exception("IMPOSSIBLE DE SUPPRIMER. OBJET DEJA VISER");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void deleteObjetFille(ClassMAPTable o) throws Exception {
        Connection conn = null;
        try {
            conn = new UtilDB().GetConn();
            conn.setAutoCommit(false);
            deleteObjetFille(o, conn);
            conn.commit();
        } catch (Exception ex) {
            if (conn != null) {
                conn.rollback();
            }
            ex.printStackTrace();
            throw ex;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public void deleteObjetFille(ClassMAPTable o, Connection conn) throws Exception {
        try {

            o.deleteToTableWithHisto(u.getTuppleID(), conn);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void deleteObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            deleteObject(o, c);
            c.commit();
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public void deleteObjectMultiple(ClassMAPTable[] o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            for (int i = 0; i < o.length; i++) {
                deleteObject(o[i], c);
            }
            c.commit();
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void deleteObject(ClassMAPTable o, Connection c) throws Exception {

        try {
            /*
             * if (u.isSuperUser() == false) { throw new Exception("Pas de
             * droit"); }
             */
            //System.out.println("objet supprimer: " + o.getTuppleID());
            testDelete(o, c);
            ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(o, null, null, c, "");
            if (liste.length > 0) {
                if (o instanceof mg.spat.Navire) {
                    this.updateEtat(liste[0], ConstanteEtat.getEtatAnnuler(), ((Navire) liste[0]).getId(), c);
                } else {
                    liste[0].deleteToTableWithHisto(u.getTuppleID(), c);
                }

            } else {
                throw new Exception("Erreur durant la suppression, Objet introuvable");
            }
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            ex.printStackTrace();
            throw ex;
        }
    }

    public boolean isSuperUser() {
        return u.isSuperUser();
    }

    @Override
    public int testRestriction(String user, String permission, String table, Connection con) throws Exception {
        try {
            GestionRole g = new GestionRole();
            //System.out.println("uuuu:" + u.getAdruser());
//            return g.testRestriction(user, permission, table, u.getAdruser(), con);

            // Temporaire
            return 0;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    @Override
    public String[] getAllTable() throws Exception {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();
            GestionRole g = new GestionRole();
            return g.getAllTAble(con);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    @Override
    public void ajoutrestriction(String[] val, String idrole, String act, String direc) throws Exception {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();
            ajoutrestriction(val, idrole, act, direc, con);
        } catch (Exception e) {
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    @Override
    public void ajoutrestriction(String[] val, String idrole, String act, String direc, Connection c) throws Exception {
        try {
            GestionRole g = new GestionRole();
            g.ajoutrestriction(val, idrole, act, direc, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public config.Table[] getListeTable(String role, String adr) throws Exception {
        try {
            GestionRole g = new GestionRole();
            return g.getListeTable(role, adr);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public int deletePJ(String idDossier, String idPj) throws Exception {
        return 0;
    }

    @Override
    public int deletePJ(String idDossier, String idPj, Connection con) throws Exception {
        return 0;
    }

    @Override
    public int ajouterPJInfo(String info_valeur, String pieces_id, String info_id, String info_ok) throws Exception {
        return 0;
    }

    public int ajouterPJInfo(String info_valeur, String pieces_id, String info_id, String info_ok, Connection con) throws Exception {
        return 0;
    }

    @Override
    public MessageLibelle[] getMessages(String cat, int limit, int offset) throws Exception {
        Connection con = null;
        Connection tsotra = null;
        try {
            tsotra = new UtilDB().GetConn();
            con = new UtilDB().GetConn();
            return new GestionMessage().getMessages(u.getTuppleID(), cat, limit, offset, tsotra, con);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
            if (tsotra != null) {
                tsotra.close();
            }
        }
    }

    @Override
    public MessageLibelle[] getMessageById(String idconversation) throws Exception {
        Connection con = null;
        return null;

//        try {
//            con = new UtilDB().GetConnMessage();
//            Message[] liste = (Message[]) CGenUtil.rechercher(new Message(), null, null, con, " AND RECEIVER = '" + u.getTuppleID() + "' AND STATUT = 'nonlu'");
//            for (Message element : liste) {
//                element.setStatut("lu");
//                element.updateToTable(con);
//            }
//            return new GestionMessage().getMessageById(u.getTuppleID(), idconversation, con);
//        } catch (Exception ex) {
//            throw ex;
//        } finally {
//            if (con != null) {
//                con.close();
//            }
//        }
    }

    @Override
    public int getMessagesNonLu() throws Exception {

        Connection con = null;
        int ret = 0;
        try {
            con = new UtilDB().GetConn();
            Message msg = new Message();
            msg.setStatut("nonlu");
            Message[] liste = (Message[]) CGenUtil.rechercher(msg, null, null, con, " AND RECEIVER = '" + u.getTeluser() + "' AND STATUT = 'nonlu'");
            if (liste != null && liste.length > 0) {
                ret = liste.length;
            }
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public MessageNonLu[] getMessagesNonLus(String awhere) throws Exception {

        Connection con = null;

        try {
            con = new UtilDB().GetConn();
            MessageNonLu msg = new MessageNonLu();

            MessageNonLu[] liste = (MessageNonLu[]) CGenUtil.rechercher(msg, null, null, con, awhere);

            return liste;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    @Override
    public int getNotificationNonLus() throws Exception {

        Connection con = null;
        int ret = 0;
        try {
            con = new UtilDB().GetConn();
            //UtilisateurRole[] currentUser = (UtilisateurRole[]) CGenUtil.rechercher(new UtilisateurRole(), null, null, con, " and refuser=" + u.getTuppleID());
            //if (currentUser != null && currentUser.length > 0) {
            String where = NotificationService.conditionLectureNotification(u);
            where = where + " AND ETAT = 1";
            NotificationLibelle[] liste = (NotificationLibelle[]) this.getData(new NotificationLibelle(), null, null, con, where);
            if (liste != null && liste.length > 0) {
                ret = liste.length;
            }
            //}
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public void testEtatExercice(int exercice, Connection c) throws Exception {
        try {
            int etatExercice = 0;//ComptaExerciceService.etatExercice(exercice, c);
            if (etatExercice == 0) {
                throw new Exception("IMPOSSIBLE DE VISER OU INSERER. EXERCICE NON OUVERT");
            }
            if (etatExercice == 9) {
                throw new Exception("IMPOSSIBLE DE VISER OU INSERER. EXERCICE CLOTURE");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void createUploadedPj(String nomtable, String nomprocedure, String libelle, String chemin, String mere) throws Exception {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();

            UploadPj fichier = new UploadPj(nomtable, nomprocedure, "FLE", libelle, chemin, mere);
            fichier.construirePK(con);
            fichier.insertToTableWithHisto(u.getTuppleID(), con);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    @Override
    public void deleteUploadedPj(String nomtable, String id) throws Exception {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();
            con.setAutoCommit(false);
            UploadPj up = new UploadPj(nomtable);
            UploadPj[] fichiers = (UploadPj[]) CGenUtil.rechercher(up, null, null, con, " AND ID = '" + id + "'");
            //  Utilitaire.deleteFileFromCdn(fichiers[0].getChemin());
            MapHistorique h = new MapHistorique(nomtable, "delete", u.getTuppleID(), id);
            h.setObjet("bean.UploadPj");
            fichiers[0].deleteToTable(con);
            con.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            con.rollback();
            throw ex;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public void testAnnulerVisaEtat(ClassMAPTable o, Connection c) throws Exception {
        try {
            String id = o.getValInsert("id");
            ClassMAPTable cl = (ClassMAPTable) Class.forName(o.getClassName()).newInstance();
            cl.setNomTable(o.getNomTable());
            ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(cl, null, null, c, " and id = '" + id + "'");
            if (liste.length == 0) {
                throw new Exception("Objet inexistante");
            }
            if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0) {
                if (Utilitaire.stringToInt(liste[0].getValInsert("etat")) < ConstanteEtat.getEtatValider()) {
                    throw new Exception("Impossible Annuler VISA. Objet non vis?");
                }
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public Configuration getConfigurationById(String idconf) throws Exception {
        Configuration[] listeconf = this.getListeConfiguration();
        String[] attributET = {"id"};
        String[] valET = {idconf};
        Configuration[] liste_conf = (Configuration[]) AdminGen.findAvecOrder(listeconf, attributET, valET);
        if (liste_conf.length > 0) {
            return liste_conf[0];
        }
        return null;
    }

    public void modifierRetourCapital(String id, String idplacement, String idecriture, double capital) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            //PrtfService.modifierRetourCapital(id, idplacement, idecriture, capital, this.getUser(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void supprimerRetourCapital(String id, String idplacement, String idecriture) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
//            PrtfService.supprimerRetourCapital(id, idplacement, idecriture, this.getUser(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public void updateEtatConfiguration(String[] id, String[] idetat, String[] colonne, String[] idligne, String[] valeur, String[] commentaires) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void echangerBillet(String billet_a_echanger, String[] billet, String[] nbreSortie) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            double total_montant = 0;//iementEspeceService.saveBilletage(billet, nbreSortie, c, u, "");
            if (total_montant != Utilitaire.stringToDouble(billet_a_echanger)) {
                throw new Exception("Montant diff?rent");
            }
            c.commit();
        } catch (Exception e) {
            c.rollback();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String envoyerObjectNotification(String objetDeLaNotification, String message, String destinataire, String idobjet, String lien, Connection c) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                indice = 1;
                c.setAutoCommit(false);
            }
//            String retour = NotificationService.createNotification(Utilitaire.dateDuJourSql(), objetDeLaNotification, message, destinataire, idobjet, lien, u, c);
            String retour = NotificationService.createNotification(u.getTuppleID(), objetDeLaNotification, message, null, destinataire, null, idobjet, lien, c);
            if (indice == 1) {
                c.commit();
            }
            return retour;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && indice == 1) {
                c.close();
            }
        }
    }

    public String envoyerObjectNotification(String objetDeLaNotification, String message, String personnel, String destinataire, String idobjet, String lien, Connection c) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                indice = 1;
                c.setAutoCommit(false);
            }
//            String retour = NotificationService.createNotification(Utilitaire.dateDuJourSql(), objetDeLaNotification, message, destinataire, idobjet, lien, u, c);
            String retour = NotificationService.createNotification(u.getTuppleID(), objetDeLaNotification, message, personnel, destinataire, null, idobjet, lien, c);
            if (indice == 1) {
                c.commit();
            }
            return retour;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && indice == 1) {
                c.close();
            }
        }
    }

    public String lireNotification(String idnotif) throws Exception {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();
            con.setAutoCommit(false);
            NotificationMessage[] notif = (NotificationMessage[]) CGenUtil.rechercher(new NotificationMessage(), null, null, con, " and id = '" + idnotif + "'");
            if (notif.length != 0) {
                notif[0].setMode("modif");
                notif[0].setIduser_recevant(u.getTuppleID());
                notif[0].updateToTable(con);
            } else {
                throw new Exception("Erreur notification non trouv?e");
            }
            con.commit();
            return notif[0].getId();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public String mapperMereToFilleMetier(String nomtableMappage, String nomProcedure, String suffixeMap, String idMere, String[] idFille, String rem, String montant, String etat, Connection c) throws Exception {
        try {
            for (int i = 0; i < idFille.length; i++) {
                UtilitaireMetier.mapperMereToFilleMetier(nomtableMappage, nomProcedure, suffixeMap, idMere, idFille[i], rem, montant, u.getTuppleID(), etat, c);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return null;
    }

    @Override
    public String mapperMereToFilleMetier(ClassMAPTable e, String nomTable, String idMere, String[] idFille, String rem, String montant, String etat) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String nomProcedure = "getSeq" + Utilitaire.convertDebutMajuscule(nomTable);
            String indicePK = nomTable.substring(0, 3).toUpperCase();
            if (nomTable.compareTo("log_vehicule_entretien") == 0) {
                nomProcedure = "GETSEQLogVehiculeEntretien";
                indicePK = "LVE";
            }
            if (nomTable.compareTo("LOG_MARQUE_ENTRETIEN") == 0) {
                System.out.println("================================= atooo");
                String l[] = {idMere};
                for (String idF : idFille) {
                    mapperMereToFilleMetier("log_vehicule_entretien", "GETSEQLogVehiculeEntretien", "LVE", idF, l, rem, montant, etat, c);
                }
            } else {
                mapperMereToFilleMetier(nomTable, nomProcedure, indicePK, idMere, idFille, rem, montant, etat, c);
            }
            c.commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return null;
    }

    @Override
    public String mapperMereToFilleMetier(ClassMAPTable e, String idMere, String[] idFille, String rem, String montant, String etat) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            mapperMereToFilleMetier(e.getNomTable(), e.getNomProcedureSequence(), e.getINDICE_PK(), idMere, idFille, rem, montant, etat, c);
            c.commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return null;
    }

    public void saveRetournerMedicament(String[] idordo_fille) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            // double[] qte = new double[quantite.length];

            for (int i = 0; i < idordo_fille.length; i++) {
                //this.updateEtat(new MedOrdonnanceFille(), ConstanteEtat.getEtatCourrierRetourner(), idordo_fille[i], c);
            }

            c.commit();
        } catch (Exception e) {
            c.rollback();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public void transfererNotification(String idNotification, String idpers, String service, String direction) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            NotificationService.updateNotif(idNotification, service, direction, idpers, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public void createNotification(Date daty, String objetDeLaNotification, String message, String destinataire, String idobjet, String lien, int priorite, MapUtilisateur u) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            NotificationService.createNotification(daty, objetDeLaNotification, message, destinataire, idobjet, lien, u, c);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            c.close();
        }
    }

    public void testRestrictionEcriture(String journal, Connection c) throws Exception {
        try {
//            VisaEcriture[] ve = (VisaEcriture[]) CGenUtil.rechercher(new VisaEcriture(), null, null, c, " AND JOURNAL like '" + journal + "'");
//            if (ve.length > 0) {
//                boolean isContent = false;
//                for (int i = 0; i < ve.length; i++) {
//                    if (ve[i].getRefuser() == u.getRefuser()) {
//                        isContent = true;
//                    }
//                }
//                if (isContent == false) {
//                    throw new Exception("VOUS N AVEZ PAS DE DROIT POUR CE JOURNAL");
//                }
//            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void lireMessage(String sender, String receiver, Connection c) throws Exception {
        try {
            String awhere = " and (sender='" + sender + "' and receiver='" + receiver + "') ";
            Message[] alire = (Message[]) CGenUtil.rechercher(new Message(), null, null, c, awhere);
            if (alire != null && alire.length > 0) {
                for (int l = 0; l < alire.length; l++) {
                    alire[l].setStatut("Vu");
                    alire[l].updateToTable(c);
                }
            }
        } catch (Exception e) {
            throw e;
        }

    }

    public void lireMessage(String sender, String receiver) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            lireMessage(sender, receiver, c);
        } catch (Exception d) {
            throw d;
        }
    }

    public ResultatEtSomme getDataPageGroupeMultiple(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        return CGenUtil.rechercherPageGroupeM(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c);
    }

    public ResultatEtSomme getDataPageGroupeMultiple(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception {
        return CGenUtil.rechercherPageGroupeM(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c, npp);
    }

    public ResultatEtSomme getDataPageGroupeMultiple(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp, String count) throws Exception {
        return CGenUtil.rechercherPageGroupeM(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c, npp, count);
    }

    public CNAPSUser getCnapsUser() {
        return cnapsUser;
    }

    public Object annulerObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            o = o.getById(o.getTuppleID(), null, c);
            if (o instanceof ClassEtat) {
                ((ClassEtat) o).annuler(this.getUser().getTuppleID(), c);
            }
            c.commit();
            return o;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object annulerObject(ClassMAPTable o, Connection c) throws Exception {
        if (testRestriction(u.getIdrole(), "ACT000005", o.getNomTable(), c) == 1) {
            throw new Exception("ERREUR DE DROIT");
        }
        testValidationEtat(o, c);
        try {
            o.setMode("modif");
            if (o instanceof ClassEtat) {
                ((ClassEtat) o).annuler(this.getUser().getTuppleID(), c);
            }
            return o;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        }
    }

    public void updateEtat(ClassMAPTable e, int valeurEtat, String id, Connection c) throws Exception {
        try {
            /*String req = "update " + e.getNomTable() + " set etat='" + valeurEtat + "' where id = '" + id + "'";
            cmd = c.createStatement();
            cmd.executeUpdate(req);*/
            e.setValChamp("etat", valeurEtat);
            e.updateToTableWithHisto(this.getUser().getTuppleID(), c);
        } catch (Exception ex) {
            throw ex;
        }
    }

    public void annulerVisa(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            this.annulerVisa(o, c);
            c.commit();
        } catch (Exception e) {
            c.rollback();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void annulerVisa(ClassMAPTable o, Connection c) throws Exception {
        try {
//            if (/*
//                     * testRestriction(u.getIdrole(), "ACT000009",
//                     * o.getNomTable(), c) == 1
//                     */u.getRang() < ConstanteUser.rangDir && o.getClassName().compareTo("mg.cnaps.compta.ComptaEcriture") != 0) {
//                throw new Exception("ERREUR DE DROIT");
//            }
            boolean defaultVisa = true;
            String id = o.getValInsert("id");
            o.setValChamp("id", id);
//            ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(o, null, null, c, "");
//
//            if (liste.length == 0) {
//                throw new Exception("Objet inexistante");
//            }
//            if(liste[0] instanceof facture.FactureClient) {
//                ((facture.FactureClient) liste[0]).controlerAnnulation(c);
//            }
//            
//            this.updateEtat(liste[0], ConstanteEtat.getEtatCreer(), id, c);

            if (o instanceof ClassEtat) {
                ClassEtat[] liste = (ClassEtat[]) CGenUtil.rechercher(o, null, null, c, "");

                if (liste.length == 0) {
                    throw new Exception("Objet inexistante");
                }

                liste[0].annulerValidation("" + u.getRefuser(), c);
            }
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void ouvrirCloture(Cloture cl) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Cloture clo = (Cloture) CGenUtil.rechercher(cl, null, null, c, " and id='" + cl.getId() + "'")[0];
            ClotureService.ouvrirCloture(clo.getCaisse(), clo.getDaty().toString(), c, u);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object[] createObjectMultiple(ClassMAPTable[] o, String colonneMere, String idmere, Connection c) throws Exception {
        try {
            Object[] ret = new Object[o.length];
            for (int i = 0; i < o.length; i++) {
                o[i].setValChamp(colonneMere, idmere);
                ret[i] = createObject(o[i], c);
            }
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        }

    }

    public Object createObjectMultiple(ClassMAPTable mere, String colonneMere, ClassMAPTable[] fille) throws Exception {
        Connection c = null;
        Object ret = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            if (mere instanceof mg.spat.Billetage) {
                mg.spat.Billetage billetage = (mg.spat.Billetage) mere;
                double montant = 0;
                int size = fille.length;
                //System.out.println("SIZE: " + size);
                for (int i = 0; i < size; i++) {
                    //System.out.println("ATO: "+((mg.spat.DetailsBilletage)fille[i]).getMontant());
                    montant += ((mg.spat.DetailsBilletage) fille[i]).getMontant();
                }
                billetage.setMontant(montant);
                mere = billetage;
                //System.out.println("AAAAAAAAAAAAAAAAAAAA: "+montant);
            }
            /*if (mere instanceof facture.FactureClient) {
                for (int i = 0; i < fille.length; i++) {
                    ((facture.FactureClientDetails) fille[i]).setMere((facture.FactureClient) mere);
                }
            }*/
            if (mere instanceof ClassMere && fille.length > 0 && fille[0] instanceof ClassFille) {
                if (mere instanceof bean.ClassEtat) {
                    mere.setValChamp("etat", ConstanteEtat.getEtatCreer());
                    mere.setValChamp("iduser", u.getTuppleID());
                }

                ((ClassMere) mere).setFille((ClassFille[]) fille);
                ((ClassMere) mere).createObject(this.getUser().getTuppleID(), c);
                return mere;
            }

            Object idmere = createObject(mere, c);
            //System.out.println(" ((ClassMAPTable)idmere).getTuppleID() === " + ((ClassMAPTable) idmere).getTuppleID());
            ret = createObjectMultiple(fille, colonneMere, ((ClassMAPTable) idmere).getTuppleID(), c);
            ret = idmere;

            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public void createUploadedPjService(String iddossier, HashMap<String, String> listeVal, Iterator it, String nomtable, String nomprocedure, String mere) throws Exception {
        try {
            UploadService.createUploadedPj(iddossier, u.getTuppleID(), listeVal, it, nomtable, nomprocedure, mere);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public void insertDetailsPlacementFille(Placement mere, Connection c) throws Exception {
        try {
            SpatService.insertDetailsPlacement(mere, c, u.getTuppleID());
        } catch (Exception e) {
            throw e;
        }
    }

    public void echuPlacement(Placement p) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            this.updateEtat(p, ConstanteEtat.getEtatEchu(), p.getId(), c);
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void ajouterMenuUtilisateur(String utilisateur, String menus, String role, String acces) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();

            String[] user = utilisateur.split(";");
            String[] menu = menus.split(";");

            String req = Utilitaire.tabToString(menu, "'", ",");
            String req2 = Utilitaire.tabToString(user, "'", ",");
            utilisateur.UserMenu[] listE = (utilisateur.UserMenu[]) CGenUtil.rechercher(new utilisateur.UserMenu(), null, null, c, " and IDMENU in (" + req + ") and REFUSER in (" + req2 + ")");
            if (user != null && user.length > 0) {
                for (int i = 0; i < user.length; i++) {
                    if (menu != null && menu.length > 0) {
                        for (int j = 0; j < menu.length; j++) {
                            String idmenu = isExistMenu(listE, menu[j], user[i]);
                            if (idmenu == null) {
                                utilisateur.UserMenu um = new utilisateur.UserMenu(role, menu[j], "", "", Integer.parseInt(acces), user[i]);
                                um.setNomTable("usermenu");
                                um.construirePK(c);
                                um.insertToTableWithHisto(u.getTuppleID(), c);
                            } else {
                                utilisateur.UserMenu um = new utilisateur.UserMenu(role, menu[j], "", "", Integer.parseInt(acces), user[i]);
                                um.setNomTable("usermenu");
                                um.setId(idmenu);
                                um.updateToTableWithHisto(u.getTuppleID(), c);
                            }

                        }
                    } else {
                        throw new Exception("Veuillez choisir au moin un menu");
                    }
                }
            } else {
                throw new Exception("Veuillez choisir au moin un utilisateur");
            }

            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String isExistMenu(utilisateur.UserMenu[] listE, String menu, String refuser) throws Exception {
        for (int i = 0; i < listE.length; i++) {
            if (listE[i].getIdmenu().compareToIgnoreCase(menu) == 0 && listE[i].getRefuser() == refuser) {
                return listE[i].getId();
            }
        }
        return null;
    }

    @Override
    public void insertPrevisionStatistiqueSMMC(StatistiqueSMMC smmc, Connection c, String idClient) throws Exception {
        try {
            SpatService.insertPrevisionStatistiqueSMMC(smmc, u.getTuppleID(), c, idClient);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void insertStatistiqueSMMC(StatistiqueSMMC smmc, Connection c, String idClient) throws Exception {
        try {
            SpatService.insertStatistiqueSMMC(smmc, u.getTuppleID(), c, idClient);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void insertPrevisionStatistiquePTP(StatistiquePTP smmc, Connection c, String idClient) throws Exception {
        try {
            SpatService.insertPrevisionStatistiquePTP(smmc, u.getTuppleID(), c, idClient);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void insertStatistiquePTP(StatistiquePTP smmc, Connection c, String idClient) throws Exception {
        try {
            SpatService.insertStatistiquePTP(smmc, u.getTuppleID(), c, idClient);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void insertPrevisionStatistiqueMICTSL(StatistiqueMICTSL smmc, Connection c, String idClient) throws Exception {
        try {
            SpatService.insertPrevisionStatistiqueMICTSL(smmc, u.getTuppleID(), c, idClient);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void insertStatistiqueMICTSL(StatistiqueMICTSL smmc, Connection c, String idClient) throws Exception {
        try {
            SpatService.insertStatistiqueMICTSL(smmc, u.getTuppleID(), c, idClient);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public boolean ajoutParticipantMultiple(String idformation, String[] val, String nomTable, Connection c) throws Exception {
        try {
            return FormService.ajoutParticipantMultiple(idformation, val, nomTable, c, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public boolean ajoutParticipantMultiple(String idformation, String[] val, String nomTable) throws Exception {
        Connection c = null;
        boolean b = false;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            b = ajoutParticipantMultiple(idformation, val, nomTable, c);
            c.commit();
            return b;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public boolean enleverParticipantMultiple(String idformation, String[] val, String nomTable, Connection c) throws Exception {
        try {
            return FormService.enleverParticipantMultiple(idformation, val, nomTable, c);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public boolean enleverParticipantMultiple(String idformation, String[] val, String nomTable) throws Exception {
        Connection c = null;
        boolean ret = false;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            ret = enleverParticipantMultiple(idformation, val, nomTable, c);
            c.commit();
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object dupliquerObject(ClassMAPTable o, String mapFille, String nomColonneMere, Connection c) throws Exception {
//        if (testRestriction(u.getIdrole(), "ACT000010", o.getNomTable(), c) == 1) {
//            throw new Exception("ERREUR DE DROIT");
//        }
        try {
            o.setMode("modif");
            String id = o.getValInsert("id");
//            if (o.getClassName().compareToIgnoreCase("mg.cnaps.bibliotheque.BibltEmpruntInfo") == 0) {
//                throw new Exception("Duplication impossible pour emprunt de livre");
//            }
            if (o instanceof bean.ClassMere) {
                ClassMere mere = (ClassMere) (Class.forName(o.getClassName()).newInstance());
                mere.setValChamp("id", id);
                mere.setNomTable(o.getNomTable());

                ClassMere[] liste = (ClassMere[]) CGenUtil.rechercher(mere, null, null, c, "");

                if (liste.length == 0) {
                    throw new Exception("Objet inexistant");
                }

                o = liste[0].dupliquer(u.getTuppleID(), c);

                return o.getValInsert("id");
            }
            if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0) {
                ClassEtat te = (ClassEtat) (Class.forName(o.getClassName()).newInstance());
                te.setValChamp("id", id);
                te.setNomTable(o.getNomTable());
                ClassEtat[] liste = (ClassEtat[]) CGenUtil.rechercher(te, null, null, c, "");
                liste[0].setEtat(1);
                liste[0].construirePK(c);
                liste[0].insertToTableWithHisto(u.getTuppleID(), c);

                if (liste.length == 0) {
                    throw new Exception("Objet inexistant");
                }
                if (mapFille.compareToIgnoreCase("") != 0) {
                    ClassMAPTable mf = (ClassMAPTable) (Class.forName(mapFille).newInstance());
                    ClassMAPTable[] liste_mf = (ClassMAPTable[]) CGenUtil.rechercher(mf, null, null, c, " and " + nomColonneMere + " = '" + te.getValInsert("id") + "'");
                    for (int i = 0; i < liste_mf.length; i++) {
                        liste_mf[i].setValChamp(nomColonneMere, liste[0].getValInsert("id"));
                        liste_mf[i].construirePK(c);
                        liste_mf[i].insertToTableWithHisto(u.getTuppleID(), c);
                    }
                }
                return liste[0].getValInsert("id");
            } else {
                ClassMAPTable t = (ClassMAPTable) (Class.forName(o.getClassName()).newInstance());
                t.setValChamp("id", id);
                ClassMAPTable[] liste = (ClassMAPTable[]) CGenUtil.rechercher(t, null, null, c, "");
                liste[0].construirePK(c);
                liste[0].insertToTableWithHisto(u.getTuppleID(), c);

                if (liste.length == 0) {
                    throw new Exception("Objet inexistant");
                }
                if (mapFille.compareToIgnoreCase("") != 0) {
                    ClassMAPTable mf = (ClassMAPTable) (Class.forName(mapFille).newInstance());
                    ClassMAPTable[] liste_mf = (ClassMAPTable[]) CGenUtil.rechercher(mf, null, null, c, " and " + nomColonneMere + " = '" + t.getValInsert("id") + "'");
                    for (int i = 0; i < liste_mf.length; i++) {
                        liste_mf[i].setValChamp(nomColonneMere, liste[0].getValInsert("id"));
                        liste_mf[i].construirePK(c);
                        liste_mf[i].insertToTableWithHisto(u.getTuppleID(), c);
                    }
                }
                return liste[0].getValInsert("id");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        }
    }

    public Object dupliquerObject(ClassMAPTable o, String mapFille, String nomColonneMere) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object ob = dupliquerObject(o, mapFille, nomColonneMere, c);
            c.commit();
            return ob;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String updateNoteFormationMutliple(String idFormation, String[] logPersonnel, String[] note, String noteFormateur) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            FormFormation ft = new FormFormation();
            ft.setId(idFormation);
            FormFormation[] lft = (FormFormation[]) CGenUtil.rechercher(ft, null, null, "");
            if (lft.length == 0) {
                throw new Exception("Formation non existante");
            }
            if (lft[0].getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Formation non visée");
            }
            lft[0].setObjett(Utilitaire.stringToDouble(noteFormateur));
            //lft[0].setEtat(ConstanteEtat.etatFormationRealise);
            lft[0].updateToTableWithHisto(u.getTuppleID(), c);

            for (int i = 0; i < logPersonnel.length; i++) {
                FormParticipantDemande participantTmp = new FormParticipantDemande();
                participantTmp.setNomTable("FORM_PARTICIPANT");
                participantTmp.setId_formation(idFormation);
                participantTmp.setLog_personnel(logPersonnel[i]);
                if (Utilitaire.stringToDouble(note[i]) > 20) {
                    throw new Exception("note supperieur a 20");
                }
                if (Utilitaire.stringToDouble(note[i]) < -1) {
                    throw new Exception("note inferieure a -1");
                }
                FormParticipantDemande[] listPart = (FormParticipantDemande[]) CGenUtil.rechercher(participantTmp, null, null, c, "");
                listPart[0].setNote(Utilitaire.stringToDouble(note[i]));
                System.out.println("id : " + listPart[0].getId() + " pers : " + listPart[0].getLog_personnel() + " note : " + listPart[0].getNote());
                listPart[0].updateToTableWithHisto(u.getTuppleID(), c);
            }
            return idFormation;

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object createObject(ClassMAPTable o, String action) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object ob = createObject(o, c, action);
            c.commit();
            return ob;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }

    }

    public Object createObject(ClassMAPTable o, Connection c, String action) throws Exception {
        if (u.getRang() < 1) // (testRestriction(u.getIdrole(), "ACT000006", o.getNomTable(), c) == 1)
        {
            throw new Exception("ERREUR DE DROIT");
        }
        try {
            if (o.getMode() != null && o.getMode().compareToIgnoreCase("annul") == 0) {
                o.setMode("annul");
                CreateObject.createObject(o, c, u, this, listeConfig, getListeSource());
                return ValiderObject.validerObject(c, o, this, uVue, listeConfig);
            } else {
                o.setMode("modif");
                return CreateObject.createObject(o, c, u, this, listeConfig, getListeSource(), action);
            }
        } catch (Exception ex) {
            //c.rollback();
            ex.printStackTrace();
            throw ex;
        }
    }

    @Override
    public void createTypeObjetMultiple(String nomTable, String proc, String pref, String[] typ, String[] desc) throws Exception {
        Connection c = null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            for (int i = 0; i < typ.length; i++) {
                this.createTypeObjet(nomTable, proc, pref, typ[i], desc[i], c);
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    @Override
    public String createTypeObjet(String nomTable, String proc, String pref, String typ, String desc, Connection c) throws Exception {
        try {
            if (u.getRang() >= 4) {
                if (typ.compareTo("") == 0) {
                    throw new Exception("Le champs Libelle est obligatoire");
                }
                TypeObjet to = new TypeObjet(nomTable, proc, pref, typ, desc);
                String refuser = u.getTuppleID();
                if (refuser != null && refuser.contains("/")) {
                    String[] g = Utilitaire.split(u.getTuppleID(), "/");
                    refuser = g[0];
                }

                MapHistorique histo = new MapHistorique(nomTable, "Insertion par " + u.getTuppleID(), refuser, to.getId());
                histo.setObjet("bean.TypeObjet");
                to.insertToTable(histo, c);
                String s = to.getId();
                return s;
            } else {
                throw new Exception("ERREUR DE DROIT");
            }
        } catch (Exception ex) {
            throw ex;
        }
    }

    @Override
    public Object createMvtCaisse(MvtCaisse mvt) throws Exception {
        Connection c = null;
        try {
            //test efa misy report @io daty io ve??
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object o = createMvtCaisse(mvt, c);
            c.commit();
            return o;

        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public Object createMvtCaisse(MvtCaisse mvt, Connection c) throws Exception {
        //Report report = new Report();
//        Date dateavant = Utilitaire.ajoutJourDate(mvt.getDaty(), 1);
        //Report[] repts = (Report[]) CGenUtil.rechercher(report, null, null, c, " and caisse like '" + mvt.getIdcaisse() + "' and daty='" + Utilitaire.datetostring(dateavant) + "'");
        //if (repts.length > 0) {
        //  throw new Exception("Impossible d effectuer ce mouvement, la caisse est deja cloturee pour cette date");
        //}
        mvt.controler(c);
        /*EtatOP[] sop = (EtatOP[])CGenUtil.rechercher(new EtatOP(), null, null, " AND ID = '"+mvt.getIdordre()+"'");
                if(sop.length>0){
                    System.out.println("OPOPOPOPO "+sop[0].getId()+" RESTE === "+sop[0].getReste());
                    if(sop[0].getReste() == 0) throw new Exception("OP DEJA PAYE");
                    if(mvt.getDebit() > sop[0].getReste()) throw new Exception("Montant superieur reste a payer");
                }*/
        return createObject(mvt, c);
    }

    @Override
    public String updateBLAvecDetails(BonDeLivraison bl, String[] id, String[] quantiteparpack, String[] quantite) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            bl.setNomTable("AS_BONDELIVRAISON");
            //this.updateObject(bl, c);
            bl.updateToTableWithHisto(u.getTuppleID(), c);
            if (id != null & id.length > 0) {
                for (int i = 0; i < id.length; i++) {
                    double qte = Utilitaire.stringToDouble(quantite[i]);
                    if (qte >= 0) {
                        BonDeLivraisonFille p = new BonDeLivraisonFille();
                        p.setId(id[i]);
                        BonDeLivraisonFille[] lsd = (BonDeLivraisonFille[]) CGenUtil.rechercher(p, null, null, c, " AND numbl = '" + bl.getTuppleID() + "'");
                        BonDeLivraisonFille fille = lsd[0];
//                        fille.setQuantiteparpack(Utilitaire.stringToDouble(quantiteparpack[i]));
                        fille.setQuantite(qte);
                        fille.updateToTableWithHisto(u.getTuppleID(), c);
                    }
                }
            }
            c.commit();
            return bl.getTuppleID();
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public String saveBLAvecDetails(BonDeLivraison bl, String[] idbc, String[] idproduit, String[] quantite) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            createObject(bl, c);

            BonDeCommandeFilleReste inst = new BonDeCommandeFilleReste();
//            inst.setNomTable("AS_BONDECOMMANDE_DETSUMLIV");
            inst.setNomTable("BC_BL_LIVRE");
            BonDeCommandeFilleReste[] bcF = (BonDeCommandeFilleReste[]) CGenUtil.rechercher(inst, null, null, c, String.format(" and idbc = '%s'", bl.getId_bc()));

            for (int i = 0; i < idproduit.length; i++) {
                double qte = Utilitaire.stringToDouble(quantite[i]);
                if (qte > 0) {
                    //double qtepack = Utilitaire.stringToDouble(quantiteparpack[i]);
                    BonDeLivraisonFille fille = new BonDeLivraisonFille(idbc[i], idproduit[i], bl.getTuppleID(), qte);
                    fille.controlQuantite(bcF);
                    createObject(fille, c);
                }
            }
            c.commit();
            return bl.getTuppleID();
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object updateObjectMultiple(ClassMAPTable mere, String colonneMere, ClassMAPTable[] fille, Connection c) throws Exception {
        boolean in = false;
        Object ret = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                in = true;
            }
            Object idmere = updateObject(mere, c);
            ret = updateObjectMultiple(fille, colonneMere, ((ClassMAPTable) idmere).getTuppleID(), c);
            ret = idmere;
            if (in) {
                c.commit();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            if (in && c != null) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (in && c != null) {
                c.close();
            }
        }
        return ret;
    }

    @Override
    public Object updateObjectMultiple(ClassMAPTable mere, String colonneMere, ClassMAPTable[] fille) throws Exception {
        return updateObjectMultiple(mere, colonneMere, fille, null);
    }

    public Object[] updateObjectMultiple(ClassMAPTable[] o, String colonneMere, String idmere, Connection c) throws Exception {
        try {
            Object[] ret = new Object[o.length];
            for (int i = 0; i < o.length; i++) {
                o[i].setValChamp(colonneMere, idmere);
                if (!o[i].getTuppleID().equals("")) {
                    ret[i] = updateObject(o[i], c);
                } else {
                    ret[i] = createObject(o[i], c);
                }
            }
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        }

    }

    public OrdonnerPayement creerOPViseFF(String idfacture, Connection c) throws Exception {
        OrdonnerPayement op = null;
        EtatFactureMontantDaty temp = new EtatFactureMontantDaty();
        EtatFactureMontantDaty[] factures = temp.getByIds(new String[]{idfacture}, c);
        if (factures.length > 0) {
            EtatFactureMontantDaty facture = factures[0];
            op = new OrdonnerPayement(facture.getId(), facture.getReste(), facture.getDaty(), this.getUser().getTuppleID(), "Paiement facture " + facture.getId() + "via caisse", ConstanteEtat.getEtatCreer());
            op.createObject(this.getUser().getRefuser() + "", c);
            op.validerObject(this.getUser().getRefuser() + "", c);
        }
        return op;
    }

    @Override
    public String creerOPviseCaisse(String idfacture, Connection c) throws Exception {
        OrdonnerPayement op = null;
        int verif = 0;
        try {
            if (idfacture != null) {
                if (c == null) {
                    c = new UtilDB().GetConn();
                    c.setAutoCommit(false);
                    verif = 1;
                }
                op = creerOPViseFF(idfacture, c);
                if (op != null) {
                    return op.getId();
                }
                op = creerOPViseAvoir(idfacture, c);
                if (c != null && verif == 1) {
                    c.commit();
                }
            } else {
                throw new Exception("Avoir(s) introuvable(s)");
            }
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return op.getId();
    }

    @Override
    public String checkPageSelonUtilisateur(String idfacture, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            String retour = "";
            UtilisateurRole[] utilisateurRoles = (UtilisateurRole[]) CGenUtil.rechercher(new UtilisateurRole(), null, null, c, " and  refuser='" + this.getUser().getRefuser() + "' ");
            for (int i = 0; i < utilisateurRoles.length; i++) {
                if (utilisateurRoles[i].getRang() < Constante.getRangMahitaNyHafa()) {
                    retour = "ded/ordonnerpayement-saisie.jsp&ded_id=" + idfacture;

                } else {
                    String idOp = this.creerOPviseCaisse(idfacture, c);
                    retour = "treso/journalcaisse-saisie.jsp&id=" + idOp;
                }
            }
            if (c != null && verif == 1) {
                c.commit();
            }
            return retour;
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    @Override
    public HashMap<String, String> getMapAutoComplete() {
        return mapAutoComplete;
    }

    @Override
    public void setMapAutoComplete(HashMap<String, String> mapAutoComplete) {
        this.mapAutoComplete = mapAutoComplete;
    }

    @Override
    public Object[] annulerObjectMultiple(ClassEtat o, String[] listeIdObjet, Connection c) throws Exception {
        Object[] ret = null;

        try {
            String ids = Utilitaire.tabToString(listeIdObjet, "'", ",");
            ClassEtat[] objs = (ClassEtat[]) CGenUtil.rechercher(o, null, null, c, " and id in (" + ids + ")");

            for (ClassEtat obj : objs) {
                annulerObject(obj, c);
            }

            ret = objs;
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw ex;
        }

        return ret;
    }

    @Override
    public Object[] annulerObjectMultiple(ClassEtat o, String[] listeIdObjet) throws Exception {
        Connection c = null;
        Object[] ret = null;

        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            ret = annulerObjectMultiple(o, listeIdObjet, c);
            c.commit();
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }

        return ret;
    }

    public void payerFCMultiple(String[] listeId, TransitionPaiementVide t) throws Exception {
        Connection c = null;

        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);

            AdminFactureClient adminFC = new AdminFactureClient(t);
            adminFC.findFactureClient(listeId, c);
            adminFC.payer(this, c);

            c.commit();
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public OrdonnerPayement creerOPViseAvoir(String idfacture, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            AvoirFC avoir = new AvoirFC();
            avoir.setNomTable("avoirFC_montant");
            String awhere = String.format(" and id = '%s' ", idfacture);
            AvoirFC[] result = (AvoirFC[]) CGenUtil.rechercher(avoir, null, null, c, awhere);
            if (result == null || result.length == 0) {
                throw new Exception("Pas d'avoir pour la facture " + idfacture);
            }
            avoir = result[0];
            OrdonnerPayement op = new OrdonnerPayement();
            op.setDed_Id(avoir.getId());
            op.setMontant(avoir.getMontant());
            op.setDaty(avoir.getDaty());
            op.setIduser(String.valueOf(this.getUser().getRefuser()));
            op.setRemarque("paiement avoir " + avoir.getCode());
            op.setEtat(1);

            this.createObject(op, c);
            this.validerObject(op, c);

            if (verif == 1) {
                c.commit();
            }

            return op;

        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

    }

    @Override
    public Object createObjectValidation(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            Object ob = createObjectValidation(o, c);
            c.commit();
            return ob;
        } catch (ValidationException valid) {
            throw valid;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public Object createObjectValidation(ClassMAPTable o, Connection c) throws Exception {
        try {
            boolean nandalo = false;
            o.setMode("insert");
            /*if (o.getClassName().compareToIgnoreCase("jeton.MouvementJeton") == 0) {
             return null;
             }*/
            o.controler(c);
            o.construirePK(c);

            if (getValidation() == null) {
                ValidationException validat = new ValidationException(" Voulez vous continuez? ");
                setValidation(validat);
                nandalo = true;
            }

            if (getValidation().isResponse() == false && nandalo == true) {
                getValidation().setObjet(o);
                throw getValidation();
            }
            if (getValidation() == null || getValidation() != null && getValidation().isResponse() == true) {
                o.insertToTable(c);
            }
            setValidation(null);
            return o;
        } catch (ValidationException valid) {
            throw valid;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    @Override
    public Object updateObjectValidation(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Object ob = updateObjectValidation(o, c);
            c.commit();
            return ob;
        } catch (ValidationException valid) {
            throw valid;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public Object updateObjectValidation(ClassMAPTable o, Connection c) throws Exception {
        try {
            o.setMode("update");
            boolean nandalo = false;
            if (getValidation() == null) {
                ValidationException validat = new ValidationException(" Voulez vous continuez l'update ? ");
                setValidation(validat);
                nandalo = true;
            }

            if (getValidation().isResponse() == false && nandalo == true) {
                getValidation().setObjet(o);
                throw getValidation();
            }
            if (getValidation() == null || getValidation() != null && getValidation().isResponse() == true) {
                o.controlerUpdate(c);
                o.updateToTableWithHisto(u.getTuppleID(), c);
            }
            setValidation(null);
            return o;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    @Override
    public void deleteObjectValidation(ClassMAPTable o) throws Exception {
        Connection c = null;
        boolean nandalo = false;
        try {
            if (u.isSuperUser() == false) {
                throw new Exception("Pas de droit");
            }
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            o.controler(c);
            o.construirePK(c);

            if (getValidation() == null) {
                ValidationException validat = new ValidationException(" Voulez vous continuez? ");
                setValidation(validat);
                nandalo = true;
            }

            if (getValidation().isResponse() == false && nandalo == true) {
                getValidation().setObjet(o);
                throw getValidation();
            }
            if (getValidation() == null || getValidation() != null && getValidation().isResponse() == true) {
                o.deleteToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            setValidation(null);

        } catch (ValidationException valid) {
            throw valid;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    @Override
    public ValidationException getValidation() {
        return validation;
    }

    @Override
    public void setValidation(ValidationException validation) {
        this.validation = validation;
    }

}
