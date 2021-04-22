/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

import bean.ClassMAPTable;
import bean.CGenUtil;

import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;
import utilitaire.ConstanteEtat;

/**
 *
 * @author BICI
 */
public class BonDeCommandeEtat extends ClassMAPTable {

    private String id, remarque, designation, modepaiement, fournisseur;
    private Date daty;
    private int tva;
	private int etat;

    public BonDeCommandeEtat() {
        this.setNomTable("AS_BONDECOMMANDE_LIBELLE");
    }

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public int getTva() {
        return tva;
    }

    public void setTva(int tva) {
        this.tva = tva;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public double getMontantTTC() throws Exception{
		BonDeCommandeFille p = new BonDeCommandeFille();
		p.setNomTable("as_bondecommande_fille_libelle"); // vue
        BonDeCommandeFille[] liste = (BonDeCommandeFille[]) CGenUtil.rechercher(p, null, null, " and idbc = '" + this.getId() + "'");
		double total = 0.0;
		for (int i=0; i<liste.length; i++){
			total += liste[i].getQuantite() * liste[i].getPu();
		}
		double tva = (total * this.getTva()) / 100;
		total += tva;
		return total;
	}
	public void setEtat(int etat){
		this.etat = etat;
	}
	
	public String getEtat(){
		return ConstanteEtat.etatToChaine(String.valueOf(etat));
	}	
}
