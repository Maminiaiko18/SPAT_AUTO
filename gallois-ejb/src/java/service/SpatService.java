/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import historique.MapUtilisateur;
import java.sql.Connection;
import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import mg.spat.BonProvisoire;
import mg.spat.JournalCaisse;
import mg.spat.MaterielNaval;
import mg.spat.Mouvement;
import mg.spat.Patrimoine;
import mg.spat.Postedestinataire;
import mg.spat.PrevisionStatistiqueActivite;
import mg.spat.RecapMaterielNaval;
import mg.spat.RecapMouvementQuais;
import mg.spat.StatistiqueSMMC;
import mg.spat.placement.DetailsPlacements;
import mg.spat.placement.Placement;
import mg.spat.placement.PlacementLibComplet;
import mg.spat.relationhumaine.Avantage_nature;
import mg.spat.relationhumaine.Conge;
import mg.spat.relationhumaine.Diplome;
import mg.spat.relationhumaine.Identification;
import mg.spat.relationhumaine.Indemnite;
import mg.spat.relationhumaine.InfoCongePermission;
import mg.spat.relationhumaine.InfoPersonnel;
import mg.spat.relationhumaine.InfoProfessionnel;
import mg.spat.relationhumaine.InfoSalaire;
import mg.spat.relationhumaine.Parcours_professionnel;
import mg.spat.relationhumaine.Permission;
import mg.spat.relationhumaine.Renseigement_interne;
import mg.spat.relationhumaine.Renseignement_familiale;
import mg.spat.relationhumaine.Renseignement_salaire;
import mg.spat.HistoriquePatrimoine;
import mg.spat.HistoriqueSyndicat;
import mg.spat.Prevision;
import mg.spat.StatistiqueActivite;
import mg.spat.StatistiqueMICTSL;
import mg.spat.StatistiquePTP;
import mg.spat.relationhumaine.HistoEvoCarriere;
import mg.spat.relationhumaine.InfoPersonnelGlobal;
import mg.spat.relationhumaine.MouvementEffectif;
import mg.spat.relationhumaine.MouvementPersonnel;
import user.UserEJBBean;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;

/**
 *
 * @author Notiavina
 */
public class SpatService {

    public static Mouvement getLastMouvement(String provenance, String destinataire, String idNavire, String escale, Connection c) throws Exception {
        int verif = 0;
        Mouvement last = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Mouvement[] tMouvement = (Mouvement[]) CGenUtil.rechercher(new Mouvement(), null, null, c, " and navire like '" + idNavire + "' and escale = '" + escale + "' order by daty desc");
            if (tMouvement.length > 0) {
                for (int i = 0; i < tMouvement.length; i++) {
                    if (tMouvement[i].getProvenance().equals(provenance) || tMouvement[i].getDestination().equals(destinataire)) {
                        throw new Exception("Provenance ou destination deja passe");
                    }
                }
                last = tMouvement[0];
            }
            return last;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static boolean testDoulonMouvement(Mouvement mvt, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            String apresWhere = " and escale = '" + mvt.getEscale() + "' or (daty = to_date('" + mvt.getDatearrivee() + "','YYYY-MM-dd') and navire = '" + mvt.getNavire() + "')";

            boolean retour = false;
            Mouvement mvtR[] = (Mouvement[]) CGenUtil.rechercher(new Mouvement(), null, null, c, apresWhere);
            if (mvtR.length != 0) {
                retour = true;
            }
            return retour;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static void nouveauMouvement(Mouvement mvt, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            mvt.setHeure(Utilitaire.formatHeureMinSec(mvt.getHeure()));
            //String typemvt = checkTypeMvt(mvt.getProvenance(), mvt.getDestination(), c);
            //mvt.setTypeMvt(typemvt);
            if (mvt.getTypeMvt().equals(Constante.idtypeMvtArrivee)) {
                mvt.setDuree(0);
                boolean doublon = SpatService.testDoulonMouvement(mvt, c);
                if (doublon) {
                    throw new Exception("Il existe un doublon");
                }
            } else {
                Mouvement lastMvt = SpatService.getLastMouvement(mvt.getProvenance(), mvt.getDestination(), mvt.getNavire(), mvt.getEscale(), c);
                if (lastMvt != null) {
                    mvt.setDuree(Utilitaire.getDureeDates(lastMvt.getDatearrivee(), lastMvt.getHeure(), mvt.getDatearrivee(), mvt.getHeure()));
                }
                if (mvt.getTypeMvt().equals(Constante.idtypeMvt)) {
                    if (lastMvt != null && !lastMvt.getDestination().equals(mvt.getProvenance())) {
                        throw new Exception("Quai invalide");
                    }
                }
            }

            if (verif == 1) {
                c.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    public static String checkTypeMvt(String provenance, String destination, Connection c) throws Exception {
        int verif = 0;
        String idtype = "";
        int etatprovenance = 0, etatdestination = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            Postedestinataire[] poste = (Postedestinataire[]) CGenUtil.rechercher(new Postedestinataire(), null, null, c, " and id in('" + provenance + "','" + destination + "')");
            if (poste != null && poste.length > 1) {
                for (int i = 0; i < poste.length; i++) {
                    if (poste[i].getId().equals(provenance)) {
                        etatprovenance = Integer.valueOf(poste[i].getInterne());
                    } else {
                        etatdestination = Integer.valueOf(poste[i].getInterne());
                    }
                }
            }
            if (etatprovenance == 0 && etatdestination == 0) {
                idtype = Constante.idtypeMvt;
            } else if (etatprovenance == 1 && etatdestination == 0) {
                idtype = Constante.idtypeMvtArrivee;
            } else if (etatprovenance == 0 && etatdestination == 1) {
                idtype = Constante.idtypeMvtDepart;
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return idtype;
    }

    public static HashMap<String, RecapMouvementQuais> getRecapOccup(Date daty, RecapMouvementQuais[] liste) throws Exception {
        HashMap<String, RecapMouvementQuais> listeRecap = null;
        try {
            listeRecap = new HashMap<String, RecapMouvementQuais>();
            if (liste != null && liste.length > 0) {
                int diff = 0;
                for (RecapMouvementQuais rmq : liste) {
                    if (rmq.getOccup_date_arrivee() != null) {
                        diff = Utilitaire.compareDaty(rmq.getOccup_date_arrivee(), daty);
                        if (diff == 0 && listeRecap.get(rmq.getIdquaidestination()) == null) {
                            RecapMouvementQuais rm = new RecapMouvementQuais(rmq.getIdquaidestination(), rmq.getQuaidestination(), rmq.getEscale(), rmq.getOccup_navire(), rmq.getOccup_consignataire(), rmq.getOccup_cargaison(), rmq.getOccup_date_arrivee(), rmq.getOccup_date_depart(), rmq.getOccup_heure_depart(), rmq.getOccup_heure_arrivee(), rmq.getOccup_provenance(), rmq.getOccup_destination(), 0);
                            listeRecap.put(rm.getIdquaidestination(), rm);
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return listeRecap;
    }

    public static void completerQuais(HashMap<String, RecapMouvementQuais> map, TypeObjet[] listeQuais) throws Exception {
        try {
            for (TypeObjet to : listeQuais) {
                if (map.get(to.getId()) == null) {
                    map.put(to.getId(), new RecapMouvementQuais(to.getId(),to.getVal()));
                }
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public static HashMap<String, RecapMouvementQuais> getRecapPrev(Date daty, RecapMouvementQuais[] liste, HashMap<String, RecapMouvementQuais> map) throws Exception {

        HashMap<String, RecapMouvementQuais> listeRecap = null;
        try {
            listeRecap = new HashMap<String, RecapMouvementQuais>();
            if (liste != null && liste.length > 0) {
                int diff = 0;
                for (RecapMouvementQuais rmq : liste) {
                    if (rmq.getPrev_date_arrivee() != null) {
                        diff = Utilitaire.compareDaty(rmq.getPrev_date_arrivee(), daty);
                        
                        if (diff == 1 || (diff == 0 && rmq.getPrev_heure_arrivee()!=null && map.get(rmq.getIdquaidestination()).getOccup_heure_depart() != null && Utilitaire.comparerHeure(map.get(rmq.getIdquaidestination()).getOccup_heure_depart(), rmq.getPrev_heure_arrivee()) == 1) || (diff==0 && rmq.getOccup_cargaison()==null && rmq.getOccup_consignataire()==null && rmq.getOccup_date_arrivee()==null && rmq.getOccup_date_depart()==null && rmq.getOccup_destination()==null && rmq.getOccup_heure_arrivee()==null && rmq.getOccup_heure_depart()==null && rmq.getOccup_navire()==null && rmq.getOccup_provenance()==null)) {     
                            RecapMouvementQuais rm = new RecapMouvementQuais(rmq.getIdquaidestination(), rmq.getQuaidestination(), rmq.getEscale(), rmq.getPrev_navire(), rmq.getPrev_consignataire(), rmq.getPrev_cargaison(), rmq.getPrev_date_arrivee(), rmq.getPrev_date_depart(), rmq.getPrev_heure_depart(), rmq.getPrev_heure_arrivee(), rmq.getPrev_provenance(), rmq.getPrev_destination(), 1);
                            if (listeRecap.get(rm.getIdquaidestination()) == null) {
                                listeRecap.put(rm.getIdquaidestination(), rm);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return listeRecap;
    }

    public static HashMap<String, RecapMouvementQuais> getRecapFinal(Date daty, RecapMouvementQuais[] liste) throws Exception {
        HashMap<String, RecapMouvementQuais> occup = null;
        HashMap<String, RecapMouvementQuais> prev = null;
        TypeObjet[] listeQuais = getQuais(null);
        try {
            occup = getRecapOccup(daty, liste);
            completerQuais(occup, listeQuais);
            prev = getRecapPrev(daty, liste, occup);
            completerQuais(prev, listeQuais);
            RecapMouvementQuais recapOccup = null;
            RecapMouvementQuais recapPrev = null;
            for (Map.Entry occupTemp : occup.entrySet()) {
                recapOccup = (RecapMouvementQuais) occupTemp.getValue();
                recapPrev = (RecapMouvementQuais) prev.get(occupTemp.getKey());
                recapOccup.setPrev_date_arrivee(recapPrev.getPrev_date_arrivee());
                recapOccup.setPrev_date_depart(recapPrev.getPrev_date_depart());
                recapOccup.setPrev_cargaison(recapPrev.getPrev_cargaison());
                recapOccup.setPrev_consignataire(recapPrev.getPrev_consignataire());
                recapOccup.setPrev_navire(recapPrev.getPrev_navire());
            }
        } catch (Exception e) {
            throw e;
        }
        return occup;
    }

    public static HashMap<String, RecapMaterielNaval> getRecapMaterielOccup(Date daty, RecapMaterielNaval[] liste) throws Exception {
        HashMap<String, RecapMaterielNaval> listeRecap = null;
        try {
            listeRecap = new HashMap<String, RecapMaterielNaval>();
            if (liste != null && liste.length > 0) {
                int diff = 0;
                for (RecapMaterielNaval rmq : liste) {
                    if (rmq.getOccup_date_arrivee() != null) {
                        diff = Utilitaire.compareDaty(rmq.getOccup_date_arrivee(), daty);
                        if (diff == 0 && listeRecap.get(rmq.getDenomination()) == null) {
                            RecapMaterielNaval rm = new RecapMaterielNaval(rmq.getId(), rmq.getTypemateriel(), rmq.getDenomination(), rmq.getPosition(), rmq.getOccup_operation(), rmq.getOccup_client(), rmq.getOccup_heure_depart(), rmq.getOccup_heure_arrivee(), rmq.getOccup_date_depart(), rmq.getOccup_date_arrivee(), 0);
                            listeRecap.put(rmq.getDenomination(), rm);
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return listeRecap;
    }

    public static HashMap<String, RecapMaterielNaval> getRecapMaterielPrev(Date daty, RecapMaterielNaval[] liste, HashMap<String, RecapMaterielNaval> map) throws Exception {

        HashMap<String, RecapMaterielNaval> listeRecap = null;
        try {
            listeRecap = new HashMap<String, RecapMaterielNaval>();
            if (liste != null && liste.length > 0) {
                int diff = 0;
                for (RecapMaterielNaval rmq : liste) {
                        if (rmq.getPrev_date_arrivee() != null) {
                            diff = Utilitaire.compareDaty(rmq.getPrev_date_arrivee(), daty);
                            RecapMaterielNaval rmn=map.get(rmq.getDenomination());
                            if (diff == 1 || (diff == 0 && rmn!=null && rmq.getPrev_heure_arrivee()!=null && rmn.getOccup_heure_depart()!=null && Utilitaire.comparerHeure(rmn.getOccup_heure_depart(), rmq.getPrev_heure_arrivee()) == 1) || (diff==0 && rmq.getOccup_client()==null && rmq.getOccup_date_arrivee()==null && rmq.getOccup_date_depart()==null && rmq.getOccup_heure_arrivee()==null && rmq.getOccup_heure_depart()==null && rmq.getOccup_operation()==null)) {
                                RecapMaterielNaval rm = new RecapMaterielNaval(rmq.getId(), rmq.getTypemateriel(), rmq.getDenomination(), rmq.getPosition(), rmq.getPrev_operation(), rmq.getPrev_client(), rmq.getPrev_heure_depart(), rmq.getPrev_heure_arrivee(), rmq.getPrev_date_depart(), rmq.getPrev_date_arrivee(), 1);
                                if (listeRecap.get(rm.getDenomination()) == null) {
                                    listeRecap.put(rm.getDenomination(), rm);
                                }
                            }
                        }
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return listeRecap;
    }

    public static void completerMateriel(HashMap<String, RecapMaterielNaval> map, MaterielNaval[] listeMateriel) throws Exception {
        try {
            for (MaterielNaval to : listeMateriel) {
                if (map.get(to.getDenomination()) == null) {
                    map.put(to.getDenomination(), new RecapMaterielNaval(to.getDenomination()));
                }
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public static HashMap<String, RecapMaterielNaval> getRecapMaterielNaval(Date daty, RecapMaterielNaval[] liste) throws Exception {
        HashMap<String, RecapMaterielNaval> occup = null;
        HashMap<String, RecapMaterielNaval> prev = null;
        MaterielNaval[] listeMateriel = getMateriel(null);
        try {
            occup = getRecapMaterielOccup(daty, liste);
            completerMateriel(occup, listeMateriel);
            prev = getRecapMaterielPrev(daty, liste, occup);
            completerMateriel(prev, listeMateriel);
            RecapMaterielNaval recapOccup = null;
            RecapMaterielNaval recapPrev = null;
            for (Map.Entry occupTemp : occup.entrySet()) {
                recapOccup = (RecapMaterielNaval) occupTemp.getValue();
                recapPrev = (RecapMaterielNaval) prev.get(occupTemp.getKey());
                
                if(recapPrev!=null){
                    recapOccup.setPrev_date_arrivee(recapPrev.getPrev_date_arrivee());
                    recapOccup.setPrev_date_depart(recapPrev.getPrev_date_depart());
                    recapOccup.setPrev_client(recapPrev.getPrev_client());
                    recapOccup.setPrev_operation(recapPrev.getPrev_operation());
                    recapOccup.setPrev_heure_arrivee(recapPrev.getPrev_heure_arrivee());
                    recapOccup.setPrev_heure_depart(recapPrev.getPrev_heure_depart());
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return occup;
    }

    public static MaterielNaval[] getMateriel(Connection c) throws Exception {
        int verif = 0;
        MaterielNaval[] liste;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            MaterielNaval quai = new MaterielNaval();
            liste = (MaterielNaval[]) CGenUtil.rechercher(quai, null, null, c, "");
            return liste;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static TypeObjet[] getQuais(Connection c) throws Exception {
        int verif = 0;
        TypeObjet[] liste;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            TypeObjet quai = new TypeObjet();
            quai.setNomTable("quais");
            liste = (TypeObjet[]) CGenUtil.rechercher(quai, null, null, c, "");
            return liste;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static MaterielNaval[] getDenomminationMateriel(Connection c) throws Exception {
        int verif = 0;
        MaterielNaval[] liste;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            MaterielNaval quai = new MaterielNaval();
            liste = (MaterielNaval[]) CGenUtil.rechercher(quai, null, null, c, "");
            return liste;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static int getNextMonth(int month) {
        int retour = month + 1;
        if (retour == 13) {
            retour = 1;
        }
        return retour;
    }
    public static double calculerTaux(double taux,int duree){
        double retour=0;
        if(taux*duree!=0){
            retour=(taux*duree)/12;
        }
        return retour;
    }
    public static void insertDetailsPlacement(Placement mere, Connection c, String u) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if (c != null && verif == 1) {
                c.setAutoCommit(false);
            }
            int diffMois = Utilitaire.diffMoisDaty(mere.getDate_echeance(), mere.getDate_placement());
            double taux=calculerTaux(mere.getTaux(),diffMois);
            
            double interet_recevoir = (mere.getMontant() * taux) / 100;
            double ircm = (interet_recevoir * Constante.getTauxIRCM()) / 100;
            double interet_net = interet_recevoir - ircm;
            double montant_terme = mere.getMontant() + interet_net;

            
            int moisNombre = getNextMonth(getNextMonth(mere.getDate_placement().getMonth()));
            String moisDep = Utilitaire.nbToMois(moisNombre);

            DetailsPlacements dp = new DetailsPlacements(mere.getId(), moisDep, montant_terme, interet_recevoir, interet_net);
            dp.construirePK(c);
            dp.insertToTableWithHisto(u, c);
            
            if (c != null && verif == 1) {
                c.commit();
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

    /*private static void Exception(String il_existe_déjà_une_prévision_pour_ce_mois) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }*/

    public DetailsPlacements[] getDetailsPlacements(Connection c, String idMere) throws Exception {
        System.out.println(idMere + " idMere DETAILSPLACEMENTTABLES");
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            DetailsPlacements[] liste = (DetailsPlacements[]) CGenUtil.rechercher(new DetailsPlacements(), null, null, c, " and idmere ='" + idMere + "'");

            return liste;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static PlacementLibComplet[] getPlacementDate(Date daty,String idbanque, Connection c) throws Exception {
        PlacementLibComplet[] liste = null;

        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            String requete = "select valentite,valbanque,sum(montant)as montant from placementlibcomplet where etat = "+ConstanteEtat.getEtatValider()+" and idbanque='"+idbanque+"' group by valentite,valbanque,montant";
            //System.out.println("requete = " + requete);
            liste = (PlacementLibComplet[]) CGenUtil.rechercher(new PlacementLibComplet(), requete, c);

            return liste;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    

    public static ClassMAPTable updateInfoPersonnel(ClassMAPTable objet, MapUtilisateur u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            InfoPersonnelGlobal info2 = (InfoPersonnelGlobal) objet;
            InfoPersonnel[] ip=(InfoPersonnel[])CGenUtil.rechercher(info2, null, null, c, " and id='"+info2.getId()+"'");
            if(ip.length==0) throw new Exception("Info personnel introuvable");
            InfoPersonnel info=ip[0];
            Identification identif = new Identification(info.getId(), info.getNom(), info.getPrenom(), info.getAdresse(), info.getGenre(), info.getNumero_cin(), info.getTelephone(), info.getMail(), info.getNumero_matricule(), info.getType_contrat(), info.getCategorie(), info.getPoste(), info.getDirection(), info.getAnciennete_poste(), info.getDatenaissance(), info.getDate_embauche(), info.getAge(), info.getAnciennete());
            identif.updateToTableWithHisto(u.getTuppleID(), c);
            //String id, String idPersonnel, String poste_occupe, String societe,double duree, int annee_parcours_pro
            Parcours_professionnel infopro = new Parcours_professionnel(info.getIdinfoprofessionnel(), info.getId(), info.getPoste_occupe(), info.getSociete(), info.getDuree(), info.getAnnee_parcours_pro());
            infopro.updateToTableWithHisto(u.getTuppleID(), c);

            Renseignement_familiale renseig = new Renseignement_familiale(info.getIdrenseignement(), info.getId(), info.getSituation_matrimoniale(), info.getNom_prenom_epoux(), info.getNom_prenom_pere(), info.getNom_prenom_mere());
            renseig.updateToTableWithHisto(u.getTuppleID(), c);
            return objet;
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static ClassMAPTable updateInfoProfessionnel(ClassMAPTable objet, MapUtilisateur u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            InfoProfessionnel info = (InfoProfessionnel) objet;
            //String id, String idPersonnel, String poste_occupe, String societe,double duree, int annee_parcours_pro
            Parcours_professionnel infopro = new Parcours_professionnel(info.getId(), info.getIdpersonnel(), info.getPoste_occupe(), info.getSociete(), info.getDuree(), info.getAnnee_parcours_pro());
            infopro.updateToTableWithHisto(u.getTuppleID(), c);

            Diplome diplome = new Diplome(info.getIddiplome(), info.getIdpersonnel(), info.getTitre(), info.getOptions(), info.getEtablissement(), info.getAnnee_diplome());
            diplome.updateToTableWithHisto(u.getTuppleID(), c);
            return objet;
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static Object updateInfoCongePermission(ClassMAPTable o, MapUtilisateur u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            InfoCongePermission info = (InfoCongePermission) o;
            System.out.println(" nombre******* :  " + info.getNombre());
            Conge conge = new Conge(info.getId(), info.getIdPersonnel(), info.getDisponibilite(), info.getDate_debut_conge(), info.getDate_fin_conge(), info.getNombre());
            conge.updateToTableWithHisto(u.getTuppleID(), c);

            Permission permission = new Permission(info.getIdPermission(), info.getIdPersonnel(), info.getObjet(), info.getDate_debut_permission(), info.getDate_fin_permission(), info.getNombre());
            permission.updateToTableWithHisto(u.getTuppleID(), c);
            return o;
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static Object updateInfoSalaire(ClassMAPTable o, MapUtilisateur u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            InfoSalaire info = (InfoSalaire) o;
            Renseignement_salaire salaire = new Renseignement_salaire(info.getId(), info.getIdPersonnel(), info.getCategorie(), info.getPalier(), info.getIndice(), info.getSalaire_base());
            salaire.updateToTableWithHisto(u.getTuppleID(), c);

            Indemnite ind = new Indemnite(info.getIdIndemnite(), info.getIdPersonnel(), info.getIndemnite_fonction(), info.getIndemnite_conge_paye(), info.getIndemnite_deplacement(), info.getIndemnite_risque());
            ind.updateToTableWithHisto(u.getTuppleID(), c);

            Avantage_nature diplome = new Avantage_nature(info.getIdAvantagenature(), info.getIdPersonnel(), info.getLogement(), info.getVehicule(), info.getAutre_avantage(), info.getMode_paiement(), info.getNumero_virement(), info.getNumero_cnaps());
            diplome.updateToTableWithHisto(u.getTuppleID(), c);
            return o;
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static Renseigement_interne[] getRenseignementInterne(String idpersonnel, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Renseigement_interne[] liste = (Renseigement_interne[]) CGenUtil.rechercher(new Renseigement_interne(), null, null, c, " and ipersonnel='" + idpersonnel + "'");
            return liste;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public static TypeObjet[] getClientConcessionnaire(Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            TypeObjet to =new TypeObjet();
            to.setNomTable("client_concessionnaire ");
            TypeObjet[] liste=(TypeObjet[]) CGenUtil.rechercher(to, null, null, c, "");
            return liste;
        }catch(Exception e){
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static ClassMAPTable insertJournalCaisse(JournalCaisse o,UserEJBBean u,Connection c)throws Exception {
         int verif = 0;
        try{
             if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
             //(String folio, String caisse, String numPiece, String libelle, String remarque, Date dateSaisie, Date dateEffet, double debit, double credit)
              JournalCaisse j = new JournalCaisse(o.getFolio(), o.getCaisse(),o.getNumPiece(), o.getLibelle(), o.getRemarque(), Utilitaire.dateDuJourSql(), o.getDateEffet(), o.getDebit(), o.getCredit());
              j.construirePK(c);
              j.setTiers(o.getTiers());
              j.setIdTypeCheque(o.getIdTypeCheque());
              j.insertToTableWithHisto(u.getUser().getTuppleID(), c);
              BonProvisoire provisoire = new BonProvisoire();
              provisoire.setId(o.getFolio());
              u.updateEtat(provisoire, ConstanteEtat.getEtatRegulariser(), o.getFolio(), c);
              if(verif == 1)c.commit();
              return j;
        }
        catch(Exception e){
             if (c != null) {
                c.rollback();
            }
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public static int comparerMois(Date inf,Date sup){
        int val=10;
        if(inf.getYear()==sup.getYear()){
            if(inf.getMonth()==sup.getMonth()) val=0;
        }
        return val;
    }
    public static void testMoisPrevisionStatistiqueActivite(PrevisionStatistiqueActivite psa, Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            PrevisionStatistiqueActivite[] liste=(PrevisionStatistiqueActivite[]) CGenUtil.rechercher(new PrevisionStatistiqueActivite(), null, null, c, " and rubrique='"+psa.getRubrique()+"' and idclient='"+psa.getIdclient()+"'");
            if(liste.length>0){
                for(int i=0;i<liste.length;i++){
                    if(comparerMois(psa.getDaty(),liste[i].getDaty())==0)
                        throw new Exception("Il existe déjà une prévision pour ce mois");
                }
            }
        }catch(Exception e){
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static ClassMAPTable updatePatrimoine(ClassMAPTable o, MapUtilisateur u, Connection c)throws Exception{
         int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
              Patrimoine p = (Patrimoine)o;
              p.updateToTableWithHisto(u.getTuppleID(), c);
             HistoriquePatrimoine j = new HistoriquePatrimoine( p.getId(),  u.getRefuser(),  p.getEtat(), Utilitaire.dateDuJourSql(), ConstanteEtat.getEtatCreer());
              j.construirePK(c);
              j.insertToTableWithHisto(u.getTuppleID(), c);
            return o;
        }catch(Exception e){
            if (c != null) {
                c.rollback();
            }
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    /*public static void insertPrevisionStatistiqueSMMC(StatistiqueSMMC smmc,String refUser,Connection c,String idClient) throws Exception{
        try{
            PrevisionStatistiqueActivite psa=new PrevisionStatistiqueActivite(idClient, "Debarquement", smmc.getDaty(), smmc.getDebarquement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            psa.setRubrique("Embarquement");
            psa.setCumul(smmc.getEmbarquement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
        }catch(Exception e){
            throw e;
        }
    }*/
    public static void insertPatrimoineHistorique(Patrimoine pat,String refUser,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(verif==1){ c.setAutoCommit(false);}
            
            pat.controler(c);
            pat.construirePK(c);
            pat.insertToTableWithHisto(refUser, c);
            
            HistoriquePatrimoine h=new HistoriquePatrimoine(pat.getId(), Integer.parseInt(refUser), pat.getEtat(), Utilitaire.dateDuJourSql(), ConstanteEtat.getEtatCreer());
            h.controler(c);
            h.construirePK(c);
            h.insertToTableWithHisto(refUser, c);
            
            if(verif==1) { c.commit(); }
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public static void insertPrevisionStatistiqueSMMC(StatistiqueSMMC smmc,String refUser,Connection c,String idClient) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(verif==1){ c.setAutoCommit(false);}
            PrevisionStatistiqueActivite psa=new PrevisionStatistiqueActivite(idClient, "Debarquement", smmc.getDaty(), smmc.getDebarquement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            psa.setRubrique("Embarquement");
            psa.setCumul(smmc.getEmbarquement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            if(verif==1) { c.commit(); }
        }catch(Exception e){
            if(verif==1) { c.rollback();}
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
     public static void insertStatistiqueSMMC(StatistiqueSMMC smmc,String refUser,Connection c,String idClient) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(verif==1){ c.setAutoCommit(false);}
            StatistiqueActivite psa=new StatistiqueActivite(idClient, "Debarquement", smmc.getDaty(), smmc.getDebarquement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            psa.setRubrique("Embarquement");
            psa.setCumul(smmc.getEmbarquement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            if(verif==1) { c.commit(); }
        }catch(Exception e){
            if(verif==1) { c.rollback();}
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static void insererInfoPersonnelGlobal(InfoPersonnelGlobal ipg, String refuser, Connection c) throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(ipg.getDatenaissance());
        int anneeNaiss = calendar.get(Calendar.YEAR);
        calendar.setTimeInMillis(System.currentTimeMillis());
        int age = calendar.get(Calendar.YEAR) - anneeNaiss;
        if(age < 18) throw new Exception("Age invalide. ( = "+(age)+")");
        ipg.setAge(age);
        ipg.construirePK(c);
        ipg.insertToTableWithHisto(refuser, c);
    }
    
    public static void insertPrevisionStatistiqueMICTSL(StatistiqueMICTSL smmc,String refUser,Connection c,String idClient) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(verif==1){ c.setAutoCommit(false);}
            PrevisionStatistiqueActivite psa=new PrevisionStatistiqueActivite(idClient, "Conteneurs pleins", smmc.getDaty(), smmc.getConteneursPleins());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            psa.setRubrique("Conteneurs vides");
            psa.setCumul(smmc.getConteneursVides());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            if(verif==1) { c.commit(); }
        }catch(Exception e){
            if(verif==1) { c.rollback();}
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    
    public static void insertStatistiqueMICTSL(StatistiqueMICTSL smmc,String refUser,Connection c,String idClient) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(verif==1){ c.setAutoCommit(false);}
            StatistiqueActivite psa=new StatistiqueActivite(idClient, "Conteneurs pleins", smmc.getDaty(), smmc.getConteneursPleins());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            psa.setRubrique("Conteneurs vides");
            psa.setCumul(smmc.getConteneursVides());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            if(verif==1) { c.commit(); }
        }catch(Exception e){
            if(verif==1) { c.rollback();}
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    
    public static void insertPrevisionStatistiquePTP(StatistiquePTP smmc,String refUser,Connection c,String idClient) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(verif==1){ c.setAutoCommit(false);}
            PrevisionStatistiqueActivite psa=new PrevisionStatistiqueActivite(idClient, "Déchargement", smmc.getDaty(), smmc.getDechargement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            psa.setRubrique("Chargement");
            psa.setCumul(smmc.getChargement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            if(verif==1) { c.commit(); }
        }catch(Exception e){
            if(verif==1) { c.rollback();}
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    
    
     public static void insertStatistiquePTP(StatistiquePTP smmc,String refUser,Connection c,String idClient) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(verif==1){ c.setAutoCommit(false);}
            StatistiqueActivite psa=new StatistiqueActivite(idClient, "Déchargement", smmc.getDaty(), smmc.getDechargement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            psa.setRubrique("Chargement");
            psa.setCumul(smmc.getChargement());
            psa.controler(c);
            psa.construirePK(c);
            psa.insertToTableWithHisto(refUser, c);
            if(verif==1) { c.commit(); }
        }catch(Exception e){
            if(verif==1) { c.rollback();}
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    
    public static HashMap<String,String> getPopupPatrimoine(Connection c) throws Exception{
        int verif = 0;
        HashMap<String,String> listeFinale=new HashMap<String,String>();
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            TypeObjet to=new TypeObjet();
            to.setNomTable("typepatrimoine");
            listeFinale.put("TYPE000004","choix/listeMaterielNaval.jsp");
            return listeFinale;
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public static HashMap<String,String> getTypePatrimoineLibelle(Connection c) throws Exception{
        int verif = 0;
        HashMap<String,String> listeFinale=new HashMap<String,String>();
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            TypeObjet to=new TypeObjet();
            to.setNomTable("typepatrimoine");
            TypeObjet[] liste=(TypeObjet[])CGenUtil.rechercher(to, null, null, c, "");
            if(liste.length>0){
                for(int i=0;i<liste.length;i++){
                    listeFinale.put(liste[i].getId(), liste[i].getVal());
                }
            }
            return listeFinale;
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public static void testerBonProvisoire(String id,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            BonProvisoire[] liste=(BonProvisoire[]) CGenUtil.rechercher(new BonProvisoire(), null, null, c, " and id='"+id+"'");
            if(liste.length>0){
                if(liste[0].getEtat()!=ConstanteEtat.getEtatValider()) throw new Exception("Seul un bon provisoire visé peut être régularisé");
            }
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public static int[] getMoisCumul(Date daty) throws Exception{
        int[] mois=null;
        int moisEnCours=Utilitaire.getMois(daty);
        mois=new int[moisEnCours];
        for(int i=0;i<moisEnCours;i++){
            mois[i]=i+1;
        }
        return mois;
    }
    public static int getMoisAnterieur(Date daty) throws Exception{
        int moisAnterieur=0;
        int moisEnCours=Utilitaire.getMois(daty);
        moisAnterieur=moisEnCours-1;
        return moisAnterieur;
    }
    public static boolean testerDateOk(Date daty,int[] moisCumul,int anneeEnCours) throws Exception{
        boolean val=false;
        if(moisCumul.length>0){
            for(int i=0;i<moisCumul.length;i++){
                if(daty==null) daty=Utilitaire.dateDuJourSql();
                if(Utilitaire.getMois(daty)==moisCumul[i] && Utilitaire.getAnnee(daty)==anneeEnCours){
                    val=true;
                    break;
                }
            }
        }
        return val;
    }
    public static void calculerCumul(HistoEvoCarriere hec,int[] moisCumul, int anneeEnCours,int moisAnterieur,int moisEnCours,HashMap<String,MouvementPersonnel> mvtPers) throws Exception{
        try{
            if(testerDateOk(hec.getDebut_fct(),moisCumul,anneeEnCours)){
                if(mvtPers.get(hec.getMotif())!=null){
                    mvtPers.get(hec.getMotif()).setCumul(mvtPers.get(hec.getMotif()).getCumul()+1);
                    if(Utilitaire.getMois(hec.getDebut_fct())==moisAnterieur && Utilitaire.getAnnee(hec.getDebut_fct())==anneeEnCours){
                        mvtPers.get(hec.getMotif()).setMois_anterieur(mvtPers.get(hec.getMotif()).getMois_anterieur()+1);
                    }if(Utilitaire.getMois(hec.getDebut_fct())==moisEnCours && Utilitaire.getAnnee(hec.getDebut_fct())==anneeEnCours){
                        mvtPers.get(hec.getMotif()).setMois_encours(mvtPers.get(hec.getMotif()).getMois_encours()+1);
                    }
                }else{
                    MouvementPersonnel mp=new MouvementPersonnel(hec.getMotif(), 0, 0, 1);
                    if(Utilitaire.getMois(hec.getDebut_fct())==moisEnCours){
                        mp.setMois_encours(1);
                    }if(Utilitaire.getMois(hec.getDebut_fct())==moisAnterieur){
                        mp.setMois_anterieur(1);
                    }
                    mvtPers.put(hec.getMotif(), mp);
                }
            }
        }catch(Exception e){
            throw e;
        }
    }
    public static void calculerCumulMvtEffectif(MouvementEffectif hec,int[] moisCumul, int anneeEnCours,int moisAnterieur,int moisEnCours,HashMap<String,MouvementPersonnel> mvtPers) throws Exception{
        try{
            if(testerDateOk(hec.getDebut_fct(),moisCumul,anneeEnCours)){
                if(mvtPers.get(hec.getMotif())!=null){
                    mvtPers.get(hec.getMotif()).setCumul(mvtPers.get(hec.getMotif()).getCumul()+1);
                    if(Utilitaire.getMois(hec.getDebut_fct())==moisAnterieur && Utilitaire.getAnnee(hec.getDebut_fct())==anneeEnCours){
                        mvtPers.get(hec.getMotif()).setMois_anterieur(mvtPers.get(hec.getMotif()).getMois_anterieur()+1);
                    }if(Utilitaire.getMois(hec.getDebut_fct())==moisEnCours && Utilitaire.getAnnee(hec.getDebut_fct())==anneeEnCours){
                        mvtPers.get(hec.getMotif()).setMois_encours(mvtPers.get(hec.getMotif()).getMois_encours()+1);
                    }
                }else{
                    MouvementPersonnel mp=new MouvementPersonnel(hec.getMotif(), 0, 0, 1);
                    if(Utilitaire.getMois(hec.getDebut_fct())==moisEnCours){
                        mp.setMois_encours(1);
                    }if(Utilitaire.getMois(hec.getDebut_fct())==moisAnterieur){
                        mp.setMois_anterieur(1);
                    }
                    mvtPers.put(hec.getMotif(), mp);
                }
            }
        }catch(Exception e){
            throw e;
        }
    }
    public static HashMap<String,MouvementPersonnel> getMouvementPersonnelEffectif(Date daty) throws Exception{
        Connection c=null;
        HashMap<String,MouvementPersonnel> mvtPers=null;
        try{
            c=new UtilDB().GetConn();
            mvtPers=new HashMap<String,MouvementPersonnel>();
            int[] moisCumul=getMoisCumul(daty);
            int moisEnCours=Utilitaire.getMois(daty);
            int moisAnterieur=getMoisAnterieur(daty);
            int anneeEnCours=Utilitaire.getAnnee(daty);
            MouvementEffectif[] liste=(MouvementEffectif[])CGenUtil.rechercher(new MouvementEffectif(), null, null, c, " and debut_fct<=TO_DATE('"+daty+"','YYYY-MM-DD')");
            if(liste.length>0){
                for(MouvementEffectif hec : liste){
                    calculerCumulMvtEffectif(hec,moisCumul,anneeEnCours,moisAnterieur,moisEnCours,mvtPers);
                }
            }
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null)c.close();
        }
        return mvtPers;
    }
    public static HashMap<String,MouvementPersonnel> getMouvementPersonnel(Date daty) throws Exception{
        Connection c=null;
        HashMap<String,MouvementPersonnel> mvtPers=null;
        try{
            c=new UtilDB().GetConn();
            mvtPers=new HashMap<String,MouvementPersonnel>();
            int[] moisCumul=getMoisCumul(daty);
            int moisEnCours=Utilitaire.getMois(daty);
            int moisAnterieur=getMoisAnterieur(daty);
            int anneeEnCours=Utilitaire.getAnnee(daty);
            HistoEvoCarriere[] liste=(HistoEvoCarriere[])CGenUtil.rechercher(new HistoEvoCarriere(), null, null, c, " and debut_fct<=TO_DATE('"+daty+"','YYYY-MM-DD')");
            if(liste.length>0){
                for(HistoEvoCarriere hec : liste){
                    calculerCumul(hec,moisCumul,anneeEnCours,moisAnterieur,moisEnCours,mvtPers);
                }
            }
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null)c.close();
        }
        return mvtPers;
    }
    
     public static void testerSyndicat(HistoriqueSyndicat syn,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            HistoriqueSyndicat[] liste=(HistoriqueSyndicat[]) CGenUtil.rechercher(new HistoriqueSyndicat(), null, null, c, " and idpersonnel='"+syn.getIdpersonnel()+"' and idposte='POST000000'");
            if(liste.length>0){
              throw new Exception("Un Membre ne peut etre president que d'un seul Syndicat");
            }
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
     
    public static void insertHistoriqueSyndicat(HistoriqueSyndicat hist,String refUser,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            HistoriqueSyndicat historiqueSyndicat = new HistoriqueSyndicat(hist.getIdsyndicat(),hist.getIdposte(),hist.getDaty());
            String[] idpersonnel = hist.getIdpersonnel().substring(0, hist.getIdpersonnel().length() - 1).split(";");
            for(String idpers : idpersonnel){
                historiqueSyndicat.setIdpersonnel(idpers);
                historiqueSyndicat.construirePK(c);
                historiqueSyndicat.insertToTableWithHisto(refUser, c);
            }
            
            if(verif == 1) c.commit();
        }catch(Exception e){
            if(verif == 1) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static void insertConge(Conge conge,String refUser,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            String[] idpersonnel = conge.getIdPersonnel().split(";");
            int nbJour = Utilitaire.diffJourDaty(conge.getDate_fin_conge(), conge.getDate_debut_conge());
            conge.setNombre(nbJour);
            for(String idpers : idpersonnel){
                conge.setIdPersonnel(idpers);
                conge.construirePK(c);
                conge.insertToTableWithHisto(refUser, c);
            }
            
            if(verif == 1) c.commit();
        }catch(Exception e){
            if(verif == 1) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static void insertPermission(Permission permission,String refUser,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            String[] idpersonnel = permission.getIdPersonnel().split(";");
            int nbJour = Utilitaire.diffJourDaty(permission.getDate_fin_permission(), permission.getDate_debut_permission());
            permission.setNombre(nbJour);
            for(String idpers : idpersonnel){
                permission.setIdPersonnel(idpers);
                permission.construirePK(c);
                permission.insertToTableWithHisto(refUser, c);
            }
            
            if(verif == 1) c.commit();
        }catch(Exception e){
            if(verif == 1 && c != null) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static void insertDiplome(Diplome diplome,String refUser,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            String[] idpersonnel = diplome.getIdPersonnel().substring(0, diplome.getIdPersonnel().length()).split(";");
            for(String idpers : idpersonnel){
                diplome.setIdPersonnel(idpers);
                diplome.construirePK(c);
                diplome.insertToTableWithHisto(refUser, c);
            }
            
            if(verif == 1) c.commit();
        }catch(Exception e){
            if(verif == 1 && c != null) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    /**
     * Joh
     * @param prevision
     * @param refUser
     * @param c
     * @throws Exception 
     */
    public static void insertPrevision(Prevision prevision,String refUser,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            if(prevision.getCargaison()!=null){
                String[] idcargaisons = prevision.getCargaison().substring(0, prevision.getCargaison().length()).split(";");

                for(String id : idcargaisons){
                    System.out.println("service.SpatService.insertPrevision() " + id);
                    prevision.setCargaison(id);
                    prevision.construirePK(c);
                    prevision.insertToTableWithHisto(refUser, c);
                }
            }
            if(verif == 1) c.commit();
        }catch(Exception e){
            if(verif == 1 && c != null) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    /**
     * Antsa
     * @param mouvement
     * @param refUser
     * @param c
     * @throws Exception 
     */
    public static void insertMouvement(Mouvement mouvement,String refUser,Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            String[] idcargaisons = mouvement.getCargaison().substring(0, mouvement.getCargaison().length()).split(";");
            for(String id : idcargaisons){
                //System.out.println("service.SpatService.insertPrevision() " + id);
                mouvement.setCargaison(id);
                mouvement.construirePK(c);
                mouvement.insertToTableWithHisto(refUser, c);
            }
            
            if(verif == 1) c.commit();
        }catch(Exception e){
            if(verif == 1 && c != null) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
}
