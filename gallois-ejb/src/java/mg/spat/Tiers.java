/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class Tiers extends ClassEtat {

    private String id, nom, description, nif, stat, contact, responsable, adresse, type,compteAuxFournisseur,compteAuxClient,cin,cp;
   
    public Tiers() {
        this.setNomTable("tiers");
    }

    public Tiers(String id, String nom, String description, String nif, String stat, String contact, String responsable, String adresse, String type) throws Exception {
        this.setNomTable("tiers");
        this.setId(id);
        this.setNom(nom);
        this.setDescription(description);
        this.setNif(nif);
        this.setStat(stat);
        this.setContact(contact);
        this.setResponsable(responsable);
        this.setAdresse(adresse);
        this.setType(type);
    }

    @Override
    public String getValColLibelle() {
        return nom;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNif() {
        return nif;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) throws Exception{
         if(cin.length()>12)
         {
             throw new Exception("cin non valide");
         }
        this.cin = cin;
    }

    public String getCp() {
        return cp;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }
    

    public void setNif(String nif) throws Exception {
        double nifnumber = 0;
        if (this.getMode().compareTo("modif") == 0) {
            if (nif != null && !nif.equalsIgnoreCase("")) {
                try {
                    nifnumber = Double.valueOf(nif);
                    if (nifnumber < 0) {
                        throw new Exception("nif negatif");
                    }
                } catch (NumberFormatException ex) {
                    throw new Exception("nif invalide");
                }
                if (nif.length() != 10) {
                    throw new Exception("le nif doit contenir 10 caratères");
                }
                if (nif.contains("-") || nif.contains(",") || nif.contains(":") || nif.contains(".") || nif.contains("!") || nif.contains("+")) {
                    throw new Exception("nif invalide");
                }
            }
        }
        this.nif = nif;
    }

    public String getStat() {
        return stat;
    }

    public void setStat(String stat) throws Exception {
        double statnumber = 0;
        if (this.getMode().compareTo("modif") == 0) {
            if (stat != null && !stat.equalsIgnoreCase("")) {
                try {
                    statnumber = Double.valueOf(stat);
                    if (statnumber < 0) {
                        throw new Exception("stat negatif");
                    }
                } catch (NumberFormatException ex) {
                    throw new Exception("stat invalide");
                }
                if (stat.length() != 17) {
                    throw new Exception("le stat doit contenir 17 caratères");
                }
                if (stat.contains("-") || stat.contains(",") || stat.contains(":") || stat.contains(".") || stat.contains("!") || stat.contains("+")) {
                    throw new Exception("stat invalide");
                }
            }
        }
        this.stat = stat;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    public String getCompteAuxFournisseur() {
        return compteAuxFournisseur;
    }

    public void setCompteAuxFournisseur(String compteAuxFournisseur) {
        this.compteAuxFournisseur = compteAuxFournisseur;
    }

    public String getCompteAuxClient() {
        return compteAuxClient;
    }

    public void setCompteAuxClient(String compteAuxClient) {
        this.compteAuxClient = compteAuxClient;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("TIE", "getseq_tiers");
        this.setId(makePK(c));
    }

}
