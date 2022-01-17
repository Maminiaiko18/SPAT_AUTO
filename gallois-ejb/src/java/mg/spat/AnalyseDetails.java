package mg.spat;

import bean.ClassMAPTable;

public class AnalyseDetails extends ClassMAPTable{
	private String libelleCompte;
	private int mois,annee;
	private double montantHT,montantTVA,montantTTC;
	public AnalyseDetails(){
		setNomTable("FACTURECLIENTFILLE_LIBCOMPTECA");
	}
	public String getLibelleCompte() {
		return libelleCompte;
	}
	public void setLibelleCompte(String libelleCompte) {
		this.libelleCompte = libelleCompte;
	}
	public int getMois() {
		return mois;
	}
	public void setMois(int mois) {
		this.mois = mois;
	}
	public int getAnnee() {
		return annee;
	}
	public void setAnnee(int annee) {
		this.annee = annee;
	}
	public double getMontantHT() {
		return montantHT;
	}
	public void setMontantHT(double montantHT) {
		this.montantHT = montantHT;
	}
	public double getMontantTVA() {
		return montantTVA;
	}
	public void setMontantTVA(double montantTVA) {
		this.montantTVA = montantTVA;
	}
	public double getMontantTTC() {
		return montantTTC;
	}
	public void setMontantTTC(double montantTTC) {
		this.montantTTC = montantTTC;
	}
	@Override
	public String getTuppleID() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getAttributIDName() {
		// TODO Auto-generated method stub
		return null;
	}
}
