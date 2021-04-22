/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author Tafitasoa
 */
public class EnvoiMailService {
    
    public static void envoiMail(String destinataire, String envoyeur, String objetMail, String textMail, String utilisateur, String mdp) throws Exception{
        try{
//            String smtpHost = "192.168.1.104";
//            String from = "cnaps-dn@cnaps.mg";
//            String to = "t.andriamanana@gmail.com";
//            String username = "cnapsdns@cnaps.mg";
//            String password = "cnapsdns";
            String smtpHost = "192.168.1.104";
            String from = envoyeur;
            String to = destinataire;
            String username = utilisateur;
            String password = mdp;

            Properties props = new Properties();
            props.put("mail.smtp.host", smtpHost);
            props.put("mail.smtp.auth", "true");
            //props.put("mail.smtp.port", "995");
            //props.put("mail.smtp.port", "25");
            //props.put("mail.smtp.ssl.enable", "true");
            //props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getDefaultInstance(props);
            session.setDebug(true);

            MimeMessage message = new MimeMessage(session);   
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(objetMail);
            message.setText(textMail);

            Transport tr = session.getTransport("smtp");
            tr.connect(smtpHost, 25, username, password);
            message.saveChanges();

            // tr.send(message);
            /** Genere l'erreur. Avec l authentification, oblige d utiliser sendMessage meme pour une seule adresse... */

            tr.sendMessage(message,message.getAllRecipients());
            tr.close();
        }catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public static void envoiMailAvecPieceJointe(String destinataire, String envoyeur, String objetMail, String textMail, String[] pieces, String cheminServeur, String utilisateur, String mdp) throws Exception {
        try{
            String smtpHost = "192.168.1.104";
            String from = envoyeur;
            String to = destinataire;
            final String username = utilisateur;
            final String password = mdp;

            Properties props = new Properties();
            props.put("mail.smtp.host", smtpHost);
            props.put("mail.smtp.auth", "true");
            
            Session session=Session.getInstance(props, new Authenticator(){
                @Override
                protected PasswordAuthentication getPasswordAuthentication()
                {
                    return new PasswordAuthentication(username, password);
                }
            });
            session.setDebug(true);

            MimeMessage message = new MimeMessage(session);   
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            
            //Corps (texte)
            Multipart multipart=new MimeMultipart();
            BodyPart partieMessage=new MimeBodyPart();
            partieMessage.setText(textMail); //Pour envoyer texte brute
            //partieMessage.setContent(message, "text/html"); //Pour envoyer HTML
            multipart.addBodyPart(partieMessage);
            
            //Pièces jointes
            if(pieces != null && pieces.length > 0){
                for(int i = 0; i < pieces.length; i++){
                    partieMessage=new MimeBodyPart();
                    DataSource source = new FileDataSource(cheminServeur+"/"+pieces[i]);
                    partieMessage.setDataHandler(new DataHandler(source));
                    partieMessage.setFileName(pieces[i].replaceAll(".*/", ""));
                    multipart.addBodyPart(partieMessage);
                }
            }
            
            message.setSubject(objetMail);
            message.setContent(multipart);
            Transport.send(message);
            message.saveChanges();
        }catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
}
