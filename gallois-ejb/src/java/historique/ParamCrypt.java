package historique;

import bean.ClassMAPTable;

public class ParamCrypt extends ClassMAPTable {

	public String id;
	public int niveau;
	public int croissante;
	public String idUtilisateur;

        public ParamCrypt()
        {
          this.setNomTable("ParamCrypt");
        }
	public ParamCrypt(String id, int niveau, int croissante, String idUtilisateur) {
		this.id = id;
		this.niveau = niveau;
		this.croissante = croissante;
		this.idUtilisateur = idUtilisateur;
		this.setNomTable("ParamCrypt");
	}

	public ParamCrypt(int niveau, int croissante, String idUtilisateur) {
		this.niveau = niveau;
		this.croissante = croissante;
		this.idUtilisateur = idUtilisateur;

		this.setNomTable("ParamCrypt");
		this.setIndicePk("CRY");
		this.setNomProcedureSequence("getseqParamCrypt");
		this.setId(makePK());
	}

	public String getAttributIDName() {
		return "id";
	}

	public String getTuppleID() {
		return String.valueOf(id);
	}

	public int getCroissante() {
		return croissante;
	}

	public void setCroissante(int croissante) {
		this.croissante = croissante;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIdUtilisateur() {
		return idUtilisateur;
	}

	public void setIdUtilisateur(String idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}

	public int getNiveau() {
		return niveau;
	}

	public void setNiveau(int niveau) {
		this.niveau = niveau;
	}



}
