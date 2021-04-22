/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package historique;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Date;
import java.util.HashMap;

/**
 *
 * @author Ntsou
 */
public class VueHistoriqueValeur extends Historique_valeur {

    private Date datehistorique;
    private String heure;
    private String objet;
    private String action;
    private int idutilisateur;
    private String refobjet;

    public VueHistoriqueValeur() {
	setNomTable("vue_historique_valeur");
    }

    public HashMap<String, String> listeVal() {
	HashMap<String, String> retour = null;
	try {
	    retour = new HashMap<>();
	    Field[] listField = this.getClass().getSuperclass().getDeclaredFields();
	    Method[] allMethod = this.getClass().getSuperclass().getDeclaredMethods();
	    for (int i = 1; i <= 40; i++) {
		for (Method m : allMethod) {
		    if (m.getName().compareToIgnoreCase("getVal" + i) == 0) {
//			System.out.println("fonction:" + m.getName());
			String o = (String) m.invoke(this, null);
//			System.out.println(">>>>>>>>>>>>>>>>>>>>>>> o:" + o.isEmpty());
			if (o != null) {
			    String[] split = o.split(":");
//			    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> etoooo " + split.length);
			    if (split.length == 2) {
				retour.put(split[0], split[1]);
			    } else {
				retour.put(split[0], "");
			    }
			}
			break;
		    }
		}
	    }

	} catch (Exception e) {
	    e.printStackTrace();
	}
	return retour;
    }

    /**
     * @return the datehistorique
     */
    public Date getDatehistorique() {
	return datehistorique;
    }

    /**
     * @param datehistorique the datehistorique to set
     */
    public void setDatehistorique(Date datehistorique) {
	this.datehistorique = datehistorique;
    }

    /**
     * @return the heure
     */
    public String getHeure() {
	return heure;
    }

    /**
     * @param heure the heure to set
     */
    public void setHeure(String heure) {
	this.heure = heure;
    }

    /**
     * @return the objet
     */
    public String getObjet() {
	return objet;
    }

    /**
     * @param objet the objet to set
     */
    public void setObjet(String objet) {
	this.objet = objet;
    }

    /**
     * @return the action
     */
    public String getAction() {
	return action;
    }

    /**
     * @param action the action to set
     */
    public void setAction(String action) {
	this.action = action;
    }

    /**
     * @return the idutilisateur
     */
    public int getIdutilisateur() {
	return idutilisateur;
    }

    /**
     * @param idutilisateur the idutilisateur to set
     */
    public void setIdutilisateur(int idutilisateur) {
	this.idutilisateur = idutilisateur;
    }

    /**
     * @return the refobjet
     */
    public String getRefobjet() {
	return refobjet;
    }

    /**
     * @param refobjet the refobjet to set
     */
    public void setRefobjet(String refobjet) {
	this.refobjet = refobjet;
    }
}
