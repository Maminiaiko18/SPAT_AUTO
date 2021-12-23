/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class Armateur extends ClassMAPTable{
    private String id,nom,contact,adresse,nif,stat,mail;

    public Armateur() {
        super.setNomTable("armateur");
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

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getNif() {
        return nif;
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


    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
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
        this.preparePk("ARM", "get_seqarmateur");
        this.setId(makePK(c));
    }
    
}
