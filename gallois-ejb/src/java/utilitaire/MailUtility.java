/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import java.util.Properties;
import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Message;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Flavien
 */
public class MailUtility {

    private ConfUserMail confUser;
    private String subject;
    private String text;
    private String destinataire;
    private String cc;
    private String login;
    private String mdp;
    private String smtpHost;
    private String protocol;
    private int smptPort;

    Session session = null;
    Transport transport = null;

    public MailUtility() {

    }

    public MailUtility(String subject, String text, String destinataire, String cc) {
        setSubject(subject);
        setText(text);
        setDestinataire(destinataire);
        setCc(cc);
        this.login = confUser.login;
        this.mdp = confUser.password;
        this.smtpHost = confUser.smtpHost;
        this.smptPort = confUser.smptPort;
        this.protocol = confUser.protocol;
    }

    public MailUtility(String subject, String text, String destinataire) {
        setSubject(subject);
        setText(text);
        setDestinataire(destinataire);
        this.login = confUser.login;
        this.mdp = confUser.password;
        this.smtpHost = confUser.smtpHost;
        this.smptPort = confUser.smptPort;
        this.protocol = confUser.protocol;
    }
    
    public MailUtility(String subject, String text) {
        setSubject(subject);
        setText(text);
        this.login = confUser.login;
        this.mdp = confUser.password;
        this.smtpHost = confUser.smtpHost;
        this.smptPort = confUser.smptPort;
        this.protocol = confUser.protocol;
    }

    public void connect() throws NoSuchProviderException, MessagingException {
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.starttls.enable", "true");
            properties.setProperty("mail.transport.protocol", this.getProtocol());
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.port", "587");
            this.session = Session.getDefaultInstance(properties, null);
            this.transport = this.session.getTransport();
            //this.transport.connect(this.getSmtpHost(), this.getSmptPort(), this.getLogin(), this.mdp);
            //this.transport.close();
            System.out.println("Connected");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void send() throws MessagingException {
            MimeMessage message = new MimeMessage(this.session);
            message.setSubject(this.getSubject());
            message.setContent(this.getText(), "text/html; charset=utf-8");
            message.setFrom(new InternetAddress(this.getLogin()));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(this.getDestinataire()));

            this.transport = session.getTransport("smtp");
            this.transport.connect(this.getSmtpHost(), this.getSmptPort(), this.getLogin(), this.mdp);
            this.transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
            this.transport.close();
    }
    
    public int sendHTML() throws MessagingException {
        int success = 0;
        try {
            MimeMessage message = new MimeMessage(this.session);
            message.setSubject(this.getSubject());
            message.setContent(this.getText(), "text/html; charset=utf-8");
            message.setFrom(new InternetAddress(this.getLogin()));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(this.getDestinataire()));

//            InternetAddress[] myBccList = InternetAddress.parse("koto.rakotondralambo@gmail.com");
            message.addRecipient(Message.RecipientType.BCC, new InternetAddress("ketrika.koto@gmail.com"));
//            message.addRecipient(Message.RecipientType.CC, new InternetAddress("kotopeti@gmail.com"));
//            message.addRecipients(Message.RecipientType.BCC, new InternetAddress("your@email.com"));

            this.transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
            this.transport.close();
            success = 1;
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return success;
    }

    /**
     * @return the subject
     */
    public String getSubject() {
        return subject;
    }

    /**
     * @param subject the subject to set
     */
    public void setSubject(String subject) {
        this.subject = subject;
    }

    /**
     * @return the text
     */
    public String getText() {
        return text;
    }

    /**
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }

    /**
     * @return the destinataire
     */
    public String getDestinataire() {
        return destinataire;
    }

    /**
     * @param destinataire the destinataire to set
     */
    public void setDestinataire(String destinataire) {
        this.destinataire = destinataire;
    }

    /**
     * @return the cc
     */
    public String getCc() {
        return cc;
    }

    /**
     * @param cc the cc to set
     */
    public void setCc(String cc) {
        this.cc = cc;
    }

    /**
     * @return the smtpHost
     */
    public String getSmtpHost() {
        return smtpHost;
    }

    /**
     * @return the protocol
     */
    public String getProtocol() {
        return protocol;
    }

    /**
     * @return the smptPort
     */
    public int getSmptPort() {
        return smptPort;
    }

    /**
     * @return the login
     */
        public String getLogin() {
        return login;
    }

}
