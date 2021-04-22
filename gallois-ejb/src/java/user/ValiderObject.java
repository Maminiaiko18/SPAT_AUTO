/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import bean.TypeObjet;
import bean.UnionIntraTable;
import bean.UploadPj;
import historique.MapUtilisateur;
import java.sql.Connection;
import java.sql.Date;
import mg.cnaps.configuration.Configuration;
import mg.cnaps.notification.NotificationService;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

public class ValiderObject {

    public static Object validerObject(Connection c, ClassMAPTable o, UserEJBBean user, MapUtilisateur u, Configuration[] listeConfig) throws Exception {
        try {
            o.setMode("modif");
            /*if(o instanceof ClassEtat) {
                ClassEtat [] ce = (ClassEtat[]) CGenUtil.rechercher(o, null, null, " and " + o.getAttributIDName() + "='"+o.getTuppleID()+"'");
                if(ce.length > 0 && ce[0].getEtat() == ConstanteEtat.getEtatValider())
                    throw new Exception("Objet dejà validé.");
            }*/
            ClassEtat []lo=null;
            if (o instanceof ClassEtat)
            {
                ClassEtat filtre=(ClassEtat)o.getClass().newInstance();
                filtre.setNomTable(o.getNomTable());
                
                lo=(ClassEtat [])CGenUtil.rechercher(filtre,null,null,c," and "+o.getAttributIDName()+"='"+o.getTuppleID()+"'");
                if(lo.length==0)throw new Exception("objet non existante dans "+filtre.getNomTable());
                if (lo[0].getEtat()>=ConstanteEtat.getEtatValider())throw new Exception("objet deja vise");
                o=lo[0];
              
            }
            if(o instanceof ClassEtat)
            {
                ((ClassEtat) o).viser(user, c);
            }
            else
            {
                o.setMode("modif");
                o.controler(c);
                user.updateEtat(o, ConstanteEtat.getEtatValider(), o.getValInsert(o.getAttributIDName()), c);
            }
            
            return o;
            //user.updateEtat(o, ConstanteEtat.getEtatValider(), o.getValInsert("id"), c);
            //if(objetNotif.compareTo("")!=0) NotificationService.createNotification(u.getTuppleID(),objetNotif,messageNotif,null,null,null,idobjetNotif,lienNotif,0,0,c);
            //user.updateEtat(o, ConstanteEtat.getEtatValider(), o.getValInsert("id"), c);
        } catch (Exception e) {
            throw e;
        }
    }
}
