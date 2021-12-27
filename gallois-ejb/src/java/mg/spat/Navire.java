/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import service.NavireService;
import utilitaire.UtilDB;

/**
 *
 * @author Notiavina
 */
public class Navire extends ClassEtat{
    private String id, reference, nom, pavillon, remarque,type,armateur;
    private double jnt, jbt, plt, lht, lm, te, volume;

    public Navire(String nom, String pavillon) throws Exception {
        super.setNomTable("Navire");
        this.setNom(nom);
        this.setPavillon(pavillon);
    }

    public String getValColLibelle() {
        return nom;
    }
    
    public boolean estEtranger(Connection c){
        boolean retour = true;
        if(this.pavillon.equals("PAYS000054")||this.pavillon.equals("PAYS000010")||this.pavillon.equals("PAYS000057")){
            retour = false;
        }
        return retour;
    }
    
    @Override
    public Navire createObject(String u,Connection c)throws Exception {
        boolean estOuvert=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                estOuvert=true;
            } 
            Navire[] lnav=(Navire[])CGenUtil.rechercher(new Navire(), null, null, c, " and upper(nom) like upper('%"+this.getNom()+"%') and pavillon='"+this.getPavillon()+"'");
            if(lnav.length>0)
                throw new Exception("Il y a un doublon de navire!");
            super.createObject(u, c);
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null && estOuvert) c.close();
        }
        return this;
    }
    public void controlerUpdate(Connection c) throws Exception {
        /*boolean estOuvert=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            Navire[] lnav=(Navire[])CGenUtil.rechercher(new Navire(), null, null, c, " and upper(nom) like upper('%"+this.getNom()+"%') and pavillon='"+this.getPavillon()+"'");
            if(lnav.length>0)
                throw new Exception("Il y a un doublon de navire!");
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null && estOuvert) c.close();
        }*/
    }
    
    public Navire(){
        super.setNomTable("Navire");
    }

    public String getArmateur() {
        return armateur;
    }

    public void setArmateur(String armateur) {
        this.armateur = armateur;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(nom==null || nom.compareTo("")==0) throw new Exception("Nom obligatoire");
        }
        this.nom = nom;
    }

    public String getPavillon() {
        return pavillon;
    }

    public void setPavillon(String pavillon) throws Exception {
        
        this.pavillon = pavillon;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getJnt() {
        return jnt;
    }

    public void setJnt(double jnt) {
        this.jnt = jnt;
    }

    public double getJbt() {
        return jbt;
    }

    public void setJbt(double jbt) {
        this.jbt = jbt;
    }

    public double getPlt() {
        return plt;
    }

    public void setPlt(double plt) {
        this.plt = plt;
    }

    public double getLht() {
        return lht;
    }

    public void setLht(double lht) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(lht<0) throw new Exception("Valeur lht negative");
        }
        this.lht = lht;
    }

    public double getLm() {
        return lm;
    }

    public void setLm(double lm) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(lm<0) throw new Exception("Valeur lm negative");
        }
        this.lm = lm;
    }

    public double getTe() {
        return te;
    }

    public void setTe(double te) throws Exception{
        if(this.getMode().compareTo("modif")==0){
            if(te<0) throw new Exception("Valeur te negative");
        }
        this.te = te;
    }

    public double getVolume() {
        return volume;
    }

    public void setVolume(double volume) {
        if(this.getMode().compareTo("modif")==0){
            this.volume = this.getLht()*this.getLm()*this.getTe();
        }else{
            this.volume=volume;
        }
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("NAV", "getseqnavire");
        this.setId(makePK(c));
    }
    
    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }
}
