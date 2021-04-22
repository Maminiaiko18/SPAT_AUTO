/*
 * To change user license header, choose License Headers in Project Properties.
 * To change user template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.UnionIntraTable;
import historique.MapUtilisateur;
import historique.ParamCrypt;
import java.sql.Connection;
import java.sql.Date;
import mg.cnaps.notification.NotificationService;
import mg.spat.placement.Placement;
import mg.spat.relationhumaine.Conge;
import mg.spat.relationhumaine.Permission;
import service.SpatService;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

public class UpdateObject {

    public static Object updateObject(ClassMAPTable o, Connection c, MapUtilisateur u, UserEJBBean user) throws Exception {
        try {
            String objetNotif = "";
            String messageNotif = "";
            String idobjetNotif = "";
            String lienNotif = "";
            if (o instanceof bean.ClassEtat) {
                o.setValChamp("iduser", u.getTuppleID());
            }
            if(o instanceof mg.spat.placement.Placement ) {
                o.controler(c);
                Placement p = (Placement) o;
                if(p.getBanque().compareToIgnoreCase("BANQ000000")!=0 && p.getEntite().compareToIgnoreCase("ENTT00001")!=0)
                    throw new Exception("Cette entite n'est pas lier a une banque.");
                else if(p.getBanque().compareToIgnoreCase("BANQ000000")==0 && p.getEntite().compareToIgnoreCase("ENTT00001")==0)
                    throw new Exception("Veuiller choisir une banque.");
            }
            if (o instanceof bean.ClassUser) {
                o.setValChamp("iduser", u.getTuppleID());
            }
            if(o instanceof mg.spat.relationhumaine.InfoPersonnel){
                return SpatService.updateInfoPersonnel(o,u,c);
            }
            if(o instanceof mg.spat.relationhumaine.InfoCongePermission){
                 return SpatService.updateInfoCongePermission(o,u,c);
            }
            if(o instanceof mg.spat.relationhumaine.InfoSalaire){
                 return SpatService.updateInfoSalaire(o,u,c);
            }
            if(o instanceof mg.spat.Patrimoine){
                 return SpatService.updatePatrimoine(o,u,c);
            }
            if(o instanceof mg.spat.relationhumaine.Conge){
                Conge conge = (Conge) o;
                int nbJour = Utilitaire.diffJourDaty(conge.getDate_fin_conge(), conge.getDate_debut_conge());
                conge.setNombre(nbJour);
                o = conge;
            }
            if(o instanceof mg.spat.relationhumaine.Permission){
                Permission permission = (Permission) o;
                int nbJour = Utilitaire.diffJourDaty(permission.getDate_fin_permission(), permission.getDate_debut_permission());
                permission.setNombre(nbJour);
                o = permission;
            }
            if(o instanceof historique.MapUtilisateur){
                MapUtilisateur util=(MapUtilisateur)o;
                ParamCrypt crt = new ParamCrypt();
                crt.setIdUtilisateur(String.valueOf(util.getRefuser()));
                ParamCrypt[] pc = (ParamCrypt[]) CGenUtil.rechercher(crt, null, null, c, "");
                if (pc.length == 0) {
                    throw new Exception("Pas de cryptage associe");
                }
                String passCrypt = Utilitaire.cryptWord(util.getPwduser(), pc[0].getNiveau(), pc[0].getCroissante());
                util.setPwduser(passCrypt);
                System.out.println("PWD******* "+util.getPwduser());
                System.out.println("REFUSER******* "+util.getRefuser());
                //return null;
                o = util;
            }
            o.controlerUpdate(c);
            o.updateToTableWithHisto(u.getTuppleID(), c);
            if(objetNotif.compareTo("")!=0) NotificationService.createNotification(u.getTuppleID(),objetNotif,messageNotif,null,null,null,idobjetNotif,lienNotif,0,0,c);
            return o;
        } catch (Exception e) {
            throw e;
        }
    }
}
