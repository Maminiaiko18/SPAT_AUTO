/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.security.SecureRandom;
import java.sql.Connection;
import javax.mail.MessagingException;
import utilitaire.MailUtility;

/**
 *
 * @author Flavien
 */
public class UtilisateurService {

    private final String SUCCESS = "SUCCESS";
    private final String FAIL = "FAIL";
    private MailUtility mailUtility;
    Connection c = null;
    protected static SecureRandom random = new SecureRandom();

    public String sendMail(String destinataire, String subject, String message) throws MessagingException {
        String res = null;
        //String text = "Pour reinitialiset votre mail clique : " + lien + "/ketrika/joueurinitmotdepasse.jsp?token=" + token;
        mailUtility = new MailUtility(subject, message, "tsioryandrianintsoa2@gmail.com");
        try {
            mailUtility.connect();
            mailUtility.send();
            res = SUCCESS;
        } catch (MessagingException e) {
            e.printStackTrace();
            res = FAIL;
        }
        return res;
    }

    public String sendMailbug(String destinataire, String subject, String text) throws MessagingException {
        String res = null;
        mailUtility = new MailUtility(subject, text, destinataire);
        try {
            mailUtility.connect();
            mailUtility.send();
            res = SUCCESS;
        } catch (MessagingException e) {
            e.printStackTrace();
            res = FAIL;
        }
        return res;
    }

    public String sendMailContact(String destinataire, String subject, String text) throws MessagingException {
        String res = null;
        mailUtility = new MailUtility(subject, text, destinataire);
        try {
            mailUtility.connect();
            mailUtility.send();
            res = SUCCESS;
        } catch (MessagingException e) {
            e.printStackTrace();
            res = FAIL;
        }
        return res;
    }

    public String sendMailFournisseur(String destinataire,String subject,String text) throws MessagingException{
        String res = null;
        mailUtility = new MailUtility(subject,text,destinataire);
        try {
            mailUtility.connect();
            mailUtility.send();
            res = SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            res = FAIL;
        }
        return res;
    }

    public String getMailBodyFournisseur(String societe,String nom,String prenom,String mail,String tel1,String tel2,String adresse,String produits) throws Exception{
        try{
            String result = "";

            result += "Societe : "+societe+"\n";
            result += "Nom : "+nom+"\n";
            result += "Prenom : "+prenom+"\n";
            result += "Mail : "+mail+"\n";
            result += "Telephones : "+tel1+ ((tel2!=null && tel2!="") ? " - "+tel2 : "") +"\n";
            result += "Adresse : "+adresse+"\n";
            result += "Produits : "+produits+"\n";

            return result;
        }catch(Exception e){
            throw e;
        }
    }

    
    public synchronized String generateToken(String username) {
        long longToken = Math.abs(random.nextLong());
        String random = Long.toString(longToken, 16);
        return (username + ":" + random);
    }
    
}
