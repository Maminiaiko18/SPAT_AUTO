/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.CGenUtil;
import bean.UnionIntraTable;
import historique.MapUtilisateur;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import reporting.ServeurPDF;
import reporting.UtilitaireServeurPDF;
import user.UserEJB;
import user.UserEJBBean;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author user
 */
public class FormService {

    public static void finFormation(String id, String refUser) throws Exception{
        System.out.println("------------------------------ Update Start");
        FormFormation ff = new FormFormation();
        ff.setId(id);
        FormFormation[] ffs = (FormFormation[]) CGenUtil.rechercher(ff, null, null, null, "");
        if(ffs.length==0) throw new Exception("Formation introuvable");
        ff=ffs[0];
        if(ff.getEtat()<ConstanteEtat.getEtatValider()) throw new Exception("Formation pas encore visée");
        if(ff.getEtat()==ConstanteEtat.etatFormationRealise) throw new Exception("Formation déjà réalisé");
        if(!ff.getDate_fin().before(Utilitaire.dateDuJourSql())) throw new Exception("Fin Formation impossible. Date fin formation inférieure à la date du jour");
        ff.setEtat(ConstanteEtat.etatFormationRealise);
        ff.updateToTableWithHisto(refUser);
        System.out.println("------------------------------ Update Fin");
    }    
    
    public static List<ConvocationFormation> getConvocationFormationMod2(String id, String materiel, String titreFormation, String autre) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            String formationId = " AND IDFORMATION = '" + id + "'";
            FormationEtat[] formationetat = (FormationEtat[]) CGenUtil.rechercher(new FormationEtat(), null, null, c, formationId);
            String formationCode = UtilitaireServeurPDF.getNumeroIdentificationPDF("convocation", c) + "/" + Utilitaire.getAnneeEnCours() + "/DG/DRH/SPERS-FORM";
            List<ConvocationFormation> listeConvocationFormation = new ArrayList<ConvocationFormation>();
            for(int i=0;i<formationetat.length;i++){
                ConvocationFormation convocationFormation = new ConvocationFormation();
                convocationFormation.setEmploye(formationetat[i].getEmploye());
                convocationFormation.setMatricule(formationetat[i].getMatricule());
                convocationFormation.setFonction(formationetat[i].getFonction());
                convocationFormation.setService(formationetat[i].getService());
                convocationFormation.setIdformation(formationCode);
                convocationFormation.setObjet("Convocation");
                convocationFormation.setSexe(formationetat[i].getSexe());
                String sexe = formationetat[i].getSexe().equals("0")?"e":"";
                convocationFormation.setFormation("Nous vous informons que vous êtes désigné"+sexe+" à participer "+Utilitaire.champNull(titreFormation)+" qui se déroulera à "+Utilitaire.champNull(formationetat[i].getLieu()));
                convocationFormation.setDate_debut(Utilitaire.formatterDaty(formationetat[i].getDate_debut()));
                convocationFormation.setDate_fin(Utilitaire.formatterDaty(formationetat[i].getDate_fin()));
                convocationFormation.setHeure_debut(formationetat[i].getDuree_heure_debut());
                convocationFormation.setMateriel(materiel);
                convocationFormation.setAutres(autre);
                convocationFormation.setDate_jour(Utilitaire.datedujourlettre(Utilitaire.dateDuJour()));
                convocationFormation.setDrh("Directeur des Ressources Humaines");
                listeConvocationFormation.add(convocationFormation);
            }
            return listeConvocationFormation;
        }
        catch(Exception e){
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }    
    
    public static String makeDescriptionHtml(FormFormation p) throws Exception {
        String ret = "<h2><u>Liste des participants</u></h2> <h3>Du " + Utilitaire.datetostring(p.getDate_debut()) + " au " + Utilitaire.datetostring(p.getDate_fin()) + "  </h3>";
        if (p.getLieu() != null && !p.getLieu().isEmpty()) {
            ret += "<h3>Lieu : " + p.getLieu() + " </h3>";
        }
        ret += "<ul>";
        FormParticipantInfoComplet crt = new FormParticipantInfoComplet();
        crt.setNomTable("FORM_PART_INFOCOMPLET_VISE");

        FormParticipantInfoComplet[] listeparticipant = (FormParticipantInfoComplet[]) CGenUtil.rechercher(crt, null, null, " and ID_FORMATION = '" + p.getId() + "'");
        for (int i = 0; i < listeparticipant.length; i++) {
            ret += "<li>" + listeparticipant[i].getNom() + " " + listeparticipant[i].getPrenom() + "</li>";
        }

        ret += "</ul>";
        return ret;
    }

    public static List<AttestationFormation> getAttestationFormation(String id) throws Exception {
        Connection c = null;
        try {
            List<AttestationFormation> laf = new ArrayList<AttestationFormation>();
            FormFormation formation = new FormFormation();
            formation.setNomTable("FORM_FORMATION_LIBELLE5");
            FormFormation[] formations = (FormFormation[]) CGenUtil.rechercher(formation, null, null, c, " AND ID = '" + id + "'");
            String demandeId = "AND ID_FORMATION = '" + id + "'";
            FormParticipantInfo[] participantdemandes = (FormParticipantInfo[]) CGenUtil.rechercher(new FormParticipantInfo(), null, null, c, demandeId);
            for (int i = 0; i < participantdemandes.length; i++) {
                AttestationFormation af = new AttestationFormation();
                if (formations[0].getDate_debut() != null) {
                    af.setDate_debut(Utilitaire.datedujourlettre(Utilitaire.formatterDaty(formations[0].getDate_debut())));
                }
                if (formations[0].getDate_fin() != null) {
                    af.setDate_fin(Utilitaire.datedujourlettre(Utilitaire.formatterDaty(formations[0].getDate_fin())));
                }
                af.setDg("");
                String nom = "";
                if (participantdemandes[i].getNom() != null) {
                    nom = participantdemandes[i].getNom().toUpperCase();
                }
                String prenom = "";
                if (participantdemandes[i].getPrenom() != null) {
                    prenom = participantdemandes[i].getPrenom().toUpperCase();
                }
                af.setEmploye(nom + "  " + prenom);
                af.setFormateur(Utilitaire.champNull(formations[0].getForm_formateur()));
                af.setFormation(Utilitaire.champNull(formations[0].getIntitule()));
                laf.add(af);
            }
            return laf;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static String creerFormationViaDemande(FormFormation formation, String idDemande, Connection c, MapUtilisateur u) throws Exception {
        UnionIntraTable formFormationDemande = new UnionIntraTable();
        formFormationDemande.setNomTable("FORM_FORMATION_DEMANDE");
        UnionIntraTable[] formFormationDemandes = (UnionIntraTable[]) CGenUtil.rechercher(formFormationDemande, null, null, c, " AND ID2='" + idDemande + "'");
        if (formFormationDemandes.length > 0) {
            throw new Exception("Une Formation est déjà crée pour cette demande");
        } else {
            System.out.println("formation.getIntitule() = " + formation.getIntitule());
            System.out.println("formation.getDate_fin() = " + formation.getDate_fin());
            FormDemande[] demandes = (FormDemande[]) CGenUtil.rechercher(new FormDemande(), null, null, c, " AND ID = '" + idDemande + "'");
            FormDemande demande;
            if (demandes.length > 0) {
                demande = demandes[0];
            } else {
                throw new Exception("La demande de formation n\' extiste pas");
            }
            formation.setEtat(ConstanteEtat.getEtatCreer());
            formation.construirePK(c);
            formation.setIduser(u.getTuppleID());
            formation.insertToTableWithHisto(u.getTuppleID(), c);
            UnionIntraTable ut = new UnionIntraTable("FORM_FORMATION_DEMANDE", "", formation.getTuppleID(), demande.getId(), "", 0, 0);
            ut.preparePk("FFD", "GETSEQFORMFORMATIONDEMANDE");
            ut.setId(ut.makePK(c));
            ut.insertToTableWithHisto(u.getTuppleID(), c);
            demande.setEtat(11);
            demande.updateToTableWithHisto(u.getTuppleID(), c);
            FormParticipantDemande fpd = new FormParticipantDemande();
            fpd.setId_formation(idDemande);
            FormParticipantDemande[] fpds = (FormParticipantDemande[]) CGenUtil.rechercher(fpd, null, null, c, "");
            for (int e = 0; e < fpds.length; e++) {
                FormParticipantDemande fp = new FormParticipantDemande();
                fp.setNomTable("FORM_PARTICIPANT");
                fp.preparePk("FRP", "GETSEQFORMPARTICIPANT");
                fp.setId(ut.makePK(c));
                fp.setId_formation(formation.getTuppleID());
                fp.setLog_personnel(fpds[e].getLog_personnel());
                fp.setRemarque(fpds[e].getRemarque());
                fp.setNote(-1);
                fp.setCout(fpds[e].getCout());
                fp.setIndemnite(fpds[e].getIndemnite());
                fp.insertToTableWithHisto(u.getTuppleID(), c);
            }
            return formation.getTuppleID();
        }
    }

    public static String creerFormationViaPlusieursDemande(String[] idDemande, String formateur, String intitule, Connection c, MapUtilisateur u) throws Exception {
        UnionIntraTable formFormationDemande = new UnionIntraTable();
        formFormationDemande.setNomTable("FORM_FORMATION_DEMANDE");
        UnionIntraTable[] formFormationDemandes = (UnionIntraTable[]) CGenUtil.rechercher(formFormationDemande, null, null, c, " AND ID2='" + idDemande + "'");
        for (int i = 0; i < idDemande.length; i++) {

        }

        if (formFormationDemandes.length > 0) {
            throw new Exception("Une Formation est déjà crée pour cette demande");
        } else {
            FormDemande[] demandes = (FormDemande[]) CGenUtil.rechercher(new FormDemande(), null, null, c, " AND ID = '" + idDemande + "'");
            FormDemande demande;
            if (demandes.length > 0) {
                demande = demandes[0];
            } else {
                throw new Exception("La demande de formation n\' extiste pas");
            }
            FormFormation formation = new FormFormation(demande.getId(), demande.getForm_domaine(), demande.getLog_service(), formateur, demande.getId_categorie(), demande.getId_type(), "", demande.getDate_debut(), demande.getDate_fin(), demande.getLieu(), demande.getObjett(), demande.getNiveau_requis(), demande.getCout_offre(), demande.getId_etablissement(), 1, demande.getExercice());
            formation.setEtat(ConstanteEtat.getEtatCreer());
            formation.construirePK(c);
            formation.setIduser(u.getTuppleID());
            formation.insertToTableWithHisto(u.getTuppleID(), c);
            UnionIntraTable ut = new UnionIntraTable("FORM_FORMATION_DEMANDE", "", formation.getTuppleID(), demande.getId(), "", 0, 0);
            ut.preparePk("FFD", "GETSEQFORMFORMATIONDEMANDE");
            ut.setId(ut.makePK(c));
            ut.insertToTableWithHisto(u.getTuppleID(), c);
            demande.setEtat(11);
            demande.updateToTableWithHisto(u.getTuppleID(), c);
            return formation.getTuppleID();
        }
    }

    public static String creerFormationViaPlusieursDemande(String[] idDemande, Connection c, MapUtilisateur u) throws Exception {
        for (int i = 0; i < idDemande.length; i++) {
            UnionIntraTable formFormationDemande = new UnionIntraTable();
            formFormationDemande.setNomTable("FORM_FORMATION_DEMANDE");
            UnionIntraTable[] formFormationDemandes = (UnionIntraTable[]) CGenUtil.rechercher(formFormationDemande, null, null, c, " AND ID2='" + idDemande[i] + "'");
            if (formFormationDemandes.length > 0) {
                throw new Exception("Une Formation est déjà crée pour la demande numéro " + idDemande[i]);
            }
        }
        FormDemande[] demandeInitial = (FormDemande[]) CGenUtil.rechercher(new FormDemande(), null, null, c, " AND ID='" + idDemande[0] + "'");
        FormFormation formation = new FormFormation();
        formation.setDate_debut(Utilitaire.dateDuJourSql());
        formation.setAnnee_scolaire(demandeInitial.length > 0 ? demandeInitial[0].getAnnee_scolaire() : "");
        formation.setExercice(demandeInitial.length > 0 ? demandeInitial[0].getExercice() : Utilitaire.getAneeEnCours());
        formation.setForm_domaine(demandeInitial.length > 0 ? demandeInitial[0].getForm_domaine() : null);
        formation.setDate_fin(Utilitaire.dateDuJourSql());
        formation.setEtat(ConstanteEtat.getEtatCreer());
        formation.construirePK(c);
        formation.setIduser(u.getTuppleID());
        formation.insertToTableWithHisto(u.getTuppleID(), c);
        for (int i = 0; i < idDemande.length; i++) {
            FormDemande[] demandes = (FormDemande[]) CGenUtil.rechercher(new FormDemande(), null, null, c, " AND ID = '" + idDemande[i] + "'");
            FormDemande demande;
            if (demandes.length > 0) {
                demande = demandes[0];
            } else {
                throw new Exception("La demande de formation n\' extiste pas");
            }
            demande.setEtat(11);
            demande.updateToTableWithHisto(u.getTuppleID(), c);
            UnionIntraTable ut = new UnionIntraTable("FORM_FORMATION_DEMANDE", "", formation.getTuppleID(), demande.getId(), "", 0, 0);
            ut.preparePk("FFD", "GETSEQFORMFORMATIONDEMANDE");
            ut.setId(ut.makePK(c));
            ut.insertToTableWithHisto(u.getTuppleID(), c);
            FormParticipantDemande fpd = new FormParticipantDemande();
            fpd.setId_formation(demande.getId());
            FormParticipantDemande[] fpds = (FormParticipantDemande[]) CGenUtil.rechercher(fpd, null, null, c, "");
            for (int e = 0; e < fpds.length; e++) {
                FormParticipantDemande fp = new FormParticipantDemande();
                fp.setNomTable("FORM_PARTICIPANT");
                fp.preparePk("FRP", "GETSEQFORMPARTICIPANT");
                fp.setId(ut.makePK(c));
                fp.setId_formation(formation.getTuppleID());
                fp.setLog_personnel(fpds[e].getLog_personnel());
                fp.setRemarque(fpds[e].getRemarque());
                fp.setNote(-1);
                fp.setCout(fpds[e].getCout());
                fp.setIndemnite(fpds[e].getIndemnite());
                fp.insertToTableWithHisto(u.getTuppleID(), c);
            }
        }
        return formation.getTuppleID();
    }

    public static boolean ajoutParticipantMultiple(String idformation, String[] val, String nomTable, Connection c, String tuppleId) throws Exception {
        try {
            System.out.println("nomTable = " + nomTable);
            if (nomTable.equalsIgnoreCase("form_participant")) {
                FormFormation[] listeFormFormation = (FormFormation[]) CGenUtil.rechercher(new FormFormation(), null, null, c, " and id='" + idformation + "'");
                if (listeFormFormation == null) {
                    throw new Exception("Formation introuvable");
                } else if (listeFormFormation[0].getEtat() >= ConstanteEtat.getEtatCloture()) {
                    throw new Exception("Formation deja vise");
                } else {
                    FormParticipantDemande participant = new FormParticipantDemande();
                    participant.setNomTable("FORM_PARTICIPANT");
                    FormParticipantDemande[] effectifs = (FormParticipantDemande[]) CGenUtil.rechercher(participant, null, null, c, " and id_formation='" + idformation + "'");
                    listeFormFormation[0].setEffectif(effectifs.length + val.length);
                    listeFormFormation[0].updateToTable(c);
                }
                FormParticipantDemande item = null;
                for (int i = 0; i < val.length; i++) {
                    System.out.println("From------>" + nomTable + " val  " + val[i]);
                    item = new FormParticipantDemande(idformation, val[i], "", -1, 0);
                    item.setNomTable(nomTable);
                    item.construirePK(c);
                    item.insertToTableWithHisto(tuppleId, c);
                }
            } else if (nomTable.equalsIgnoreCase("form_participant_demande")) {
                FormDemande[] listeFormDemande = (FormDemande[]) CGenUtil.rechercher(new FormDemande(), null, null, c, " and id='" + idformation + "'");
                if (listeFormDemande == null) {
                    throw new Exception("Demande de formation introuvable");
                } else if (listeFormDemande[0].getEtat() == ConstanteEtat.getEtatValider()) {
                    throw new Exception("Demande de formation deja vise");
                } else {
                    FormParticipantDemande[] effectifs = (FormParticipantDemande[]) CGenUtil.rechercher(new FormParticipantDemande(), null, null, c, " and id_formation='" + idformation + "'");
                    listeFormDemande[0].setEffectif(effectifs.length + val.length);
                    listeFormDemande[0].updateToTable(c);
                }
                FormParticipantDemande item = null;
                for (int i = 0; i < val.length; i++) {
                    item = new FormParticipantDemande(idformation, val[i], "", -1, 0);
                    item.setNomTable(nomTable);
                    item.construirePK(c);
                    item.insertToTableWithHisto(tuppleId, c);
                }
            } else {
                throw new Exception("Table participant introuvable");
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public static boolean enleverParticipantMultiple(String idformation, String[] val, String nomTable, Connection c) throws Exception {
        boolean ret = false;
        Statement cmd = null;
        try {
            if (nomTable.equalsIgnoreCase("form_participant")) {
                FormFormation[] listeFormFormation = (FormFormation[]) CGenUtil.rechercher(new FormFormation(), null, null, c, " and id='" + idformation + "'");
                if (listeFormFormation == null) {
                    throw new Exception("Formation introuvable");
                } else if (listeFormFormation[0].getEtat() >= ConstanteEtat.getEtatCloture()) {
                    throw new Exception("Formation deja vise");
                } else {
                    int effectif = listeFormFormation[0].getEffectif() - val.length;
                    listeFormFormation[0].setEffectif(effectif);
                    listeFormFormation[0].updateToTable(c);
                }
            } else if (nomTable.equalsIgnoreCase("form_participant_demande")) {
                FormDemande[] listeFormDemande = (FormDemande[]) CGenUtil.rechercher(new FormDemande(), null, null, c, " and id='" + idformation + "'");
                if (listeFormDemande == null) {
                    throw new Exception("Demande de formation introuvable");
                } else if (listeFormDemande[0].getEtat() == ConstanteEtat.getEtatValider()) {
                    throw new Exception("Demande de formation deja vise");
                } else {
                    int effectif = listeFormDemande[0].getEffectif() - val.length;
                    listeFormDemande[0].setEffectif(effectif);
                    listeFormDemande[0].updateToTable(c);
                }
            } else {
                throw new Exception("Table participant introuvable");
            }
            cmd = c.createStatement();
            String requete = "";
            for (int i = 0; i < val.length; i++) {
                requete = "delete from " + nomTable + " where id_formation = '" + idformation + "' and log_personnel = '" + val[i] + "'";
                cmd.executeUpdate(requete);
            }
            return ret;
        } catch (Exception e) {
            throw e;
        } finally {
            if (cmd != null) {
                cmd.close();
            }
        }
    }
}
