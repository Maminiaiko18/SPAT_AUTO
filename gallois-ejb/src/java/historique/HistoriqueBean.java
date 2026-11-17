package historique;

import javax.ejb.*;
import bean.*;
import utilitaire.Utilitaire;
import utilitaire.UtilDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import mg.cnaps.utilisateur.CNAPSUser;

@Stateless
public class HistoriqueBean implements HistoriqueRemote, HistoriqueLocal, SessionBean {

    SessionContext sessionContext;

    public void ejbCreate() throws CreateException {
        /**
         * @todo Complete this method
         */
    }

    public void ejbRemove() {
        /**
         * @todo Complete this method
         */
    }

    public void ejbActivate() {
        /**
         * @todo Complete this method
         */
    }

    public void ejbPassivate() {
        /**
         * @todo Complete this method
         */
    }

    public void setSessionContext(SessionContext sessionContext) {
        this.sessionContext = sessionContext;
    }

    public MapHistorique[] findHistorique(String refuser, String refObjet, String objet, String action, String daty1, String daty2) throws Exception {
        try {
            HistoriqueUtil hu = new HistoriqueUtil();
            int[] a = {4, 5, 6, 7};
            String[] val = new String[a.length];
            val[3] = new String(refObjet);
            val[0] = new String(objet);
            val[1] = new String(action);
            val[2] = new String(refuser);
            if (daty1.compareTo("") == 0 & daty2.compareTo("") == 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " order by idHistorique desc");
            }
            if (daty1.compareTo("") > 0 & daty2.compareTo("") == 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " and datehistorique>='" + daty1 + "' order by idHistorique desc");
            }
            if (daty1.compareTo("") == 0 & daty2.compareTo("") > 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " and datehistorique<='" + daty2 + "' order by idHistorique desc");
            }
            if (daty1.compareTo("") != 0 & daty2.compareTo("") != 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " and datehistorique>='" + daty1 + "' and datehistorique<='" + daty2 + "'  order by idHistorique desc");
            }
            return null;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapHistorique[] findHistoriquePage(String refuser, String refObjet, String objet, String action, String daty1, String daty2, int numPage) throws Exception {
        try {
            HistoriqueUtil hu = new HistoriqueUtil();
            int[] a = {4, 5, 6, 7};
            String[] val = new String[a.length];
            val[3] = new String(refObjet);
            val[0] = new String(objet);
            val[1] = new String(action);
            val[2] = new String(refuser);
            if (daty1.compareTo("") == 0 & daty2.compareTo("") == 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " order by idHistorique desc", numPage);
            }
            if (daty1.compareTo("") > 0 & daty2.compareTo("") == 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " and datehistorique>='" + daty1 + "' order by idHistorique desc", numPage);
            }
            if (daty1.compareTo("") == 0 & daty2.compareTo("") > 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " and datehistorique<='" + daty2 + "' order by idHistorique desc", numPage);
            }
            if (daty1.compareTo("") != 0 & daty2.compareTo("") != 0) {
                return (MapHistorique[]) hu.rechercher(a, val, " and datehistorique>='" + daty1 + "' and datehistorique<='" + daty2 + "'  order by idHistorique desc", numPage);
            }
            return null;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int calculHistoriquePage(String refuser, String refObjet, String objet, String action, String daty1, String daty2) throws Exception {
        try {
            HistoriqueUtil hu = new HistoriqueUtil();
            int[] a = {4, 5, 6, 7};
            String[] val = new String[a.length];
            val[3] = new String(refObjet);
            val[0] = new String(objet);
            val[1] = new String(action);
            val[2] = new String(refuser);
            if (daty1.compareTo("") == 0 & daty2.compareTo("") == 0) {
                return hu.calculNombreLigne(a, val, " order by idHistorique desc");
            }
            if (daty1.compareTo("") > 0 & daty2.compareTo("") == 0) {
                return hu.calculNombreLigne(a, val, " and datehistorique>='" + daty1 + "' order by idHistorique desc");
            }
            if (daty1.compareTo("") == 0 & daty2.compareTo("") > 0) {
                return hu.calculNombreLigne(a, val, " and datehistorique<='" + daty2 + "' order by idHistorique desc");
            }
            if (daty1.compareTo("") != 0 & daty2.compareTo("") != 0) {
                return hu.calculNombreLigne(a, val, " and datehistorique>='" + daty1 + "' and datehistorique<='" + daty2 + "'  order by idHistorique desc");
            }
            return 0;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Objet[] findObjet(String obj, String des) throws Exception {
        try {
            ObjetUtil ou = new ObjetUtil();
            int[] a = {1, 2};
            String[] val = new String[a.length];
            val[0] = obj;
            val[1] = des;
            return (Objet[]) ou.rechercher(a, val);
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapRoles[] findRole(String rol) {
        return (MapRoles[]) (new RoleUtil().rechercher(1, rol));
    }

    public String createUtilisateurs(String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole, String refUser) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            MapUtilisateur[] uT = this.findUtilisateurs("%", loginuser, "%", "%", "%", "%", "%");
            if (uT.length > 0) {
                throw new Exception("Login deja utilise!");
            }

            String passCrypt = null;
            int niveau = (int) Math.round(Math.random() * 10);
            int sens = (int) Math.round(Math.random());
            if (niveau == 0) {
                niveau = -5; //raha zero ny niveau de atao -5
            }
            if (sens == 0) {
                passCrypt = Utilitaire.cryptWord(pwduser.toLowerCase(), niveau, true);
            } else {
                passCrypt = Utilitaire.cryptWord(pwduser.toLowerCase(), niveau, false);
            }

            MapUtilisateur u = new MapUtilisateur(loginuser, passCrypt, nomuser, adruser, teluser, idrole);
            u.insertToTableWithHisto(refUser, c);
            ParamCrypt pc = new ParamCrypt(niveau, sens, u.getTuppleID());
            pc.insertToTable(c);
            
            CNAPSUser cu=new CNAPSUser("DIR00001", "1", "1", "1", nomuser, "2030", u.getTuppleID());
            cu.construirePK(c);
            cu.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return u.getTuppleID();
        } catch (CreateException ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        }catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String createUtilisateurs(String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole, String refUser,String codeetb) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            MapUtilisateur[] uT = this.findUtilisateurs("%", loginuser, "%", "%", "%", "%", "%");
            if (uT.length > 0) {
                throw new Exception("Login deja utilise!");
            }

            String passCrypt = null;
            int niveau = (int) Math.round(Math.random() * 10);
            int sens = (int) Math.round(Math.random());
            if (niveau == 0) {
                niveau = -5; //raha zero ny niveau de atao -5
            }
            if (sens == 0) {
                passCrypt = Utilitaire.cryptWord(pwduser.toLowerCase(), niveau, true);
            } else {
                passCrypt = Utilitaire.cryptWord(pwduser.toLowerCase(), niveau, false);
            }

            MapUtilisateur u = new MapUtilisateur(loginuser, passCrypt, nomuser, adruser, teluser, idrole);
            if(codeetb==null || codeetb.length() == 0) throw new Exception("Code établissement obligatoire.");
            u.setCodeEtablissement(codeetb);
            u.insertToTableWithHisto(refUser, c);
            ParamCrypt pc = new ParamCrypt(niveau, sens, u.getTuppleID());
            pc.insertToTable(c);
            
            CNAPSUser cu=new CNAPSUser("DIR00001", "1", "1", "1", nomuser, "2030", u.getTuppleID());
            cu.construirePK(c);
            cu.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return u.getTuppleID();
        } catch (CreateException ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        }catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String updateUtilisateurs(String iduser, String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole, String refUser) throws Exception {
//    MapUtilisateur u=new MapUtilisateur(utilitaire.Utilitaire.stringToInt(iduser),loginuser, pwduser, nomuser, adruser, teluser, idrole);
        try {
            ParamCrypt[] pc = (ParamCrypt[]) new ParamCryptUtil().rechercher(4, iduser);
            if (pc.length == 0) {
                throw new Exception("Pas de cryptage associe");
            }
            Connection c = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                c = new UtilDB().GetConn();
                MapUtilisateur modele = new MapUtilisateur();
                ps = c.prepareStatement("SELECT * FROM " + modele.getNomTableSelect() + " WHERE REFUSER = ?");
                ps.setString(1, iduser);
                rs = ps.executeQuery();
                MapUtilisateur[] utils = (MapUtilisateur[])CGenUtil.transformeDataReader(rs, modele, c);
                rs.close();
                rs = null;
                ps.close();
                ps = null;
                if(utils.length>0 && utils[0].getLoginuser().compareToIgnoreCase(loginuser)!=0){
                    ps = c.prepareStatement("SELECT * FROM " + modele.getNomTableSelect() + " WHERE LOGINUSER = ?");
                    ps.setString(1, loginuser);
                    rs = ps.executeQuery();
                    MapUtilisateur[] util = (MapUtilisateur[])CGenUtil.transformeDataReader(rs, modele, c);
                    if(util.length>0) throw new Exception("LOGIN DEJA UTILISE");
                }
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (c != null) {
                    c.close();
                }
            }
            String passCrypt = Utilitaire.cryptWord(pwduser, pc[0].getNiveau(), pc[0].getCroissante());
            MapUtilisateur u = new MapUtilisateur(iduser, loginuser, passCrypt, nomuser, adruser, teluser, idrole);
            historique.MapHistorique h = new historique.MapHistorique("Utilisateurs", "update", refUser, u.getTuppleID());
            u.updateToTableWithHisto(h);
            return u.getTuppleID();
        } catch (Exception ex) {
            throw ex;
        }
    }

    public int deleteUtilisateurs(String iduser, String refUser) {
        /**
         * @todo Complete this method
         */
        return 0;
    }

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

    public String createHistorique(String dateHistorique, String heure, String objet, String action, String refuser, String refObjet) {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String updateHistorique(String idHistorique, String dateHistorique, String heure, String objet, String action, String refuser, String refObjet) {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public int deleteHistorique(String idHistorique, String refUser) {
        /**
         * @todo Complete this method
         */
        return 0;
    }

    public String createHistoriqueEtat(String idMere, String idUser, String idEtat, String dateModification) {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String updateHistoriqueEtat(String idHistoriqueEtat, String idMere, String idUser, String idEtat, String dateModification) {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public int deleteHistoriqueEtat(String idHistoriqueEtat, String refUser) {
        /**
         * @todo Complete this method
         */
        return 0;
    }

    public HistoriqueEtat[] findHistoriqueEtat(String idHistoriqueEtat, String idMere, String idUser, String idEtat, String dateModification) {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public int desactiveUtilisateur(String ref, String refUser) throws Exception {
        try {
            AnnulationUtilisateur au = new AnnulationUtilisateur(ref);
            historique.MapHistorique h = new historique.MapHistorique("Utilisateurs", "annule", refUser, ref);
            au.insertToTable(h);
            return 1;
        } catch (ErreurDAO ex) {
            throw new bean.ErreurDAO(ex.getMessage());
        }
    }

    public int activeUtilisateur(String ref, String refUser) throws bean.ErreurDAO {
        try {
            AnnulationUtilisateur[] au = (AnnulationUtilisateur[]) new AnnulationUtilisateurUtil().rechercher(2, ref);
            if (au == null) {
                throw new bean.ErreurDAO("Impossible de vérifier le statut du compte utilisateur");
            }
            if (au.length == 0) {
                throw new bean.ErreurDAO("Utilisateur déjà actif");
            }
            historique.MapHistorique h = new historique.MapHistorique("Utilisateurs", "active", refUser, ref);
            for (int i = 0; i < au.length; i++) {
                au[i].deleteToTable(h);
            }
            return 1;
        } catch (ErreurDAO ex) {
            throw ex;
        } catch (Exception ex) {
            Logger.getLogger(HistoriqueBean.class.getName()).log(Level.SEVERE, null, ex);
            throw new bean.ErreurDAO("Erreur lors de la réactivation du compte utilisateur : " + ex.getMessage());
        }
    }

    public MapUtilisateur testeValide(String user, String pass, String interim, String service) throws Exception {
        try {
            historique.UtilisateurUtil uI = new UtilisateurUtil();
            return uI.testeValide(user, pass, interim, service);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerSortie(String idSortie) {
        /**
         * @todo Complete this method
         */
        return 0;
    }

    public int testException() throws bean.ErreurDAO {
        historique.HistoriqueUtil hl = new HistoriqueUtil();
        try {
            hl.testException();
            //if(1>2)
            return 0;
            //throw new Exception("Exception apres IF");
        } catch (Exception ex) {
            throw new bean.ErreurDAO(ex.getMessage());
        }
    }

    @Override
    public int create(ClassMAPTable value1, MapUtilisateur value2) throws Exception {
        return 0;
    }

    @Override
    public int update(ClassMAPTable value1, MapUtilisateur value2) throws Exception {
        return 0;
    }

    @Override
    public int delete(ClassMAPTable value1, MapUtilisateur value2) throws Exception {
        return 0;
    }
}
