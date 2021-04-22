/*
 * To change user license header, choose License Headers in Project Properties.
 * To change user template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import historique.MapUtilisateur;
import java.sql.Connection;
import mg.cnaps.configuration.Configuration;
import mg.cnaps.formation.FormAbsence;
import mg.cnaps.formation.FormFormation;
import mg.cnaps.formation.FormParticipantDemande;
import mg.spat.JournalCaisse;
import mg.spat.Patrimoine;
import mg.spat.HistoriqueSyndicat;
import mg.spat.Mouvement;
import mg.spat.Prevision;
import mg.spat.RegulBonProvisoire;
import mg.spat.placement.Placement;
import mg.spat.relationhumaine.Conge;
import mg.spat.relationhumaine.Diplome;
import mg.spat.relationhumaine.InfoPersonnelGlobal;
import mg.spat.relationhumaine.Permission;
import mg.spat.relationhumaine.Renseigement_interne;
import service.SpatService;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

public class CreateObject {

    public static Object createObject(ClassMAPTable o, Connection c, MapUtilisateur u, UserEJBBean user, Configuration[] listeConfig, TypeObjet[] listeSource) throws Exception {
        try {
             String refusers = u.getTuppleID();
            if (refusers != null && refusers.contains("/")) {
                String[] g = Utilitaire.split(refusers, "/");
                refusers = g[0];
            }
            //if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassEtat") == 0)
            if (o instanceof bean.ClassEtat) {
                o.setValChamp("etat", Integer.valueOf(1));
                o.setValChamp("iduser", refusers);
            }
            //if (o.getClass().getSuperclass().getSimpleName().compareToIgnoreCase("ClassUser") == 0)
            if (o instanceof bean.ClassUser) {
                o.setValChamp("iduser", refusers);
            }
            if(o instanceof mg.spat.placement.Placement ) {
                o.controler(c);
                Placement p = (Placement) o;
                p.construirePK(c);
                p.controlerEntite(c);
                p.insertToTableWithHisto(u.getTuppleID(), c);
                user.insertDetailsPlacementFille(p, c);
                if(c != null) c.commit();
                return o;
            }
            if(o instanceof mg.spat.Patrimoine ){
                Patrimoine j = (Patrimoine)o;
                SpatService.insertPatrimoineHistorique(j, u.getTuppleID(), c);
                if(c != null) c.commit();
                return o;
            }
            if(o instanceof mg.spat.HistoriqueSyndicat){
                HistoriqueSyndicat j = (HistoriqueSyndicat)o;
                SpatService.insertHistoriqueSyndicat(j, u.getTuppleID(), c);
                if(c != null) c.commit();
                return o;
            }
            if(o instanceof mg.spat.relationhumaine.Conge){
                Conge j = (Conge)o;
                SpatService.insertConge(j, u.getTuppleID(), c);
                if(c != null) c.commit();
                return o;
            }
            if(o instanceof mg.spat.relationhumaine.Permission){
                Permission j = (Permission)o;
                SpatService.insertPermission(j, u.getTuppleID(), c);
                if(c != null) c.commit();
                return o;
            } 
            if(o instanceof mg.spat.relationhumaine.Diplome) {
                Diplome d = (Diplome)o;
                SpatService.insertDiplome(d, refusers, c);
                if(c != null) c.commit();
                return o;
            } 
            if( o instanceof mg.spat.relationhumaine.Renseigement_interne){
                 Renseigement_interne rens = (Renseigement_interne)o;
                 rens.inserer(u.getTuppleID(),c);
                return o;
            }
            if( o instanceof InfoPersonnelGlobal) {
                InfoPersonnelGlobal ipg = (InfoPersonnelGlobal)o;
                SpatService.insererInfoPersonnelGlobal(ipg, refusers, c);
                return o;
            }
            
            /*if( o instanceof Prevision) {
                Prevision prevision = (Prevision)o;
                SpatService.insertPrevision(prevision, refusers, c);
                return o;
            }*/
            
            if( o instanceof Mouvement) {
                Mouvement mouvement = (Mouvement)o;
                SpatService.insertMouvement(mouvement, refusers, c);
                return o;
            }
            
            if (o.getClassName().compareToIgnoreCase("mg.cnaps.formation.FormAbsence") == 0) {
                //--Insert absence

                //--update nombre absence participant : + 1
                FormAbsence a = (FormAbsence) o;
                FormFormation formation = new FormFormation();
                FormFormation[] formations = (FormFormation[]) CGenUtil.rechercher(new FormFormation(), null, null, c, "AND ID = '" + a.getId_formation() + "'");

                String[] idAbs = a.getLog_personnel().split(";") ;
                if (formations.length == 0) {
                    throw new Exception("Formation invalide");
                }
                if (formations[0].getEtat() > ConstanteEtat.getEtatValider()) {
                    throw new Exception("Ajout absence impossible car la formation est déjà réalisé");
                }
                FormParticipantDemande part = new FormParticipantDemande();
                part.setNomTable("FORM_PARTICIPANT");
                part.setId_formation(a.getId_formation());
                System.out.println("Log------------->" + a.getId_formation() + " ------------> "  + a.getLog_personnel() );
//                part.setLog_personnel(a.getLog_personnel());

                FormParticipantDemande[] pa = (FormParticipantDemande[]) CGenUtil.rechercher(part, null, null, " and log_personnel in ( "+utilitaire.Utilitaire.tabToString(idAbs, "'", ",") +")");
                if (pa.length <= 0) {
                    throw new Exception("Ce personnel ne participe pas à cette formation");
                }
                
                for( int i =0; i< pa.length;i++ ){
                    FormAbsence form = new FormAbsence(a.getId_formation(), pa[i].getLog_personnel() , a.getMotif(), a.getRemarque(), a.getDate_absence());
                    form.construirePK(c);
                    form.insertToTableWithHisto(u.getTuppleID(), c);
      
                    pa[0].setNomTable("FORM_PARTICIPANT");
                    pa[0].setAbsence(pa[0].getAbsence() + 1);
                    pa[0].updateToTableWithHisto(u.getTuppleID(), c);
                }
                return null;
            }

            
            /*o.controler(c);
            o.construirePK(c);
            o.insertToTableWithHisto(u.getTuppleID(), c);*/
            return o.createObject(u.getTuppleID(), c);
            
            //if(c != null) c.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        //return o;
    }
    
    public static Object createObject(ClassMAPTable o, Connection c, MapUtilisateur u, UserEJBBean user, Configuration[] listeConfig, TypeObjet[] listeSource, String action) throws Exception {
        try {
            String objetNotif = "";
            String messageNotif = "";
            String idobjetNotif = "";
            String lienNotif = "";
            String refusers = u.getTuppleID();
            if (refusers != null && refusers.contains("/")) {
                String[] g = Utilitaire.split(refusers, "/");
                refusers = g[0];
            }
            if (o instanceof bean.ClassEtat) {
                o.setValChamp("etat", Integer.valueOf(1));
                o.setValChamp("iduser", refusers);
            }
            if(o instanceof bean.AnalyseLien){
               ((bean.AnalyseLien) o).controler(user);
            }
            if (o instanceof bean.ClassUser) {
                o.setValChamp("iduser", refusers);
            }
            
            if (o.getClassName().compareToIgnoreCase("mg.spat.RegulBonProvisoire") == 0) {
                if(action.compareToIgnoreCase("retour") == 0){
                    RegulBonProvisoire retour = (RegulBonProvisoire)o;
                    retour.saveRetour(c, user);
                }else{
                    RegulBonProvisoire regule = (RegulBonProvisoire)o;
                    regule.saveRegul(c, user);
                }
                return o;
            }
            o.controler(c);
            o.construirePK(c);
            o.insertToTableWithHisto(u.getTuppleID(), c);
            
            if(c != null) c.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return o;
    }
    
}
