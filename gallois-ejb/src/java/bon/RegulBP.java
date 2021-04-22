/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bon;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.BonProvisoire;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Daniel
 */
public class RegulBP extends ClassEtat {

    String id, idbon;
    double montant;
    Date daty;
    int idUser;

    private String idUserlib;
    
    public RegulBP() {
        setNomTable("regulbp");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("RBP", "get_seq_regulbp");
        setId(makePK(c));
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        setIdUser(Utilitaire.stringToInt(u));
        super.createObject(u, c);
        
        return this;
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        BonProvisoire bp = getBonProvisoire(c);
        bp.updateEtat(ConstanteEtat.getEtatRegulariser(), bp.getId(), c);
        
        if(this.getMontant()>0){
            JournalCaisse sortie = new JournalCaisse(null, Constante.caisseCentrale, null, "Regularisation Bon Provisoire " + bp.getId(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), this.getMontant(), 0);
            sortie.setIddevise(Constante.deviseAr);
            sortie.setIdmode(Constante.modepaiementDefaut);
            sortie.setIdplacement(bp.getId());

            sortie.createObject(u, c);
            sortie.validerObject(u, c);

            JournalCaisse entree = new JournalCaisse(null, bp.getCaisse(), null, "Regularisation Bon Provisoire " + bp.getId(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0, this.getMontant());
            entree.setIddevise(Constante.deviseAr);
            entree.setIdmode(Constante.modepaiementDefaut);
            entree.createObject(u, c);
            entree.validerObject(u, c);
        }
        return super.validerObject(u, c);
    }

    public double getMontantReste(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            BonProvisoire bp = getBonProvisoire(c);

            if (bp != null) {
                return bp.getReste(c);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return 0;
    }

    public BonProvisoire getBonProvisoire(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            BonProvisoire bp = new BonProvisoire();
            BonProvisoire[] tmp = (BonProvisoire[]) CGenUtil.rechercher(bp, null, null, c, " and id = '" + this.getIdbon() + "'");

            if (tmp != null && tmp.length > 0) {
                return tmp[0];
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return null;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdbon() {
        return idbon;
    }

    public void setIdbon(String idbon) {
        this.idbon = idbon;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }
    public String getIdUserlib() {
        return idUserlib;
    }

    public void setIdUserlib(String idUserlib) {
        this.idUserlib = idUserlib;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public void controler(Connection c) throws Exception {
        BonProvisoire bp= getBonProvisoire(c);
        if(bp==null) throw new Exception("Bon provisoire inexistant");
        //if(bp.getEtat()==ConstanteEtat.getEtatRegulariser()) throw new Exception("Ce bon est déjà regularisé");
    }

}
