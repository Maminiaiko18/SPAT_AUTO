/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.messagecommunication;

import historique.MapUtilisateur;

/**
 *
 * @author Doudou Tiarilala
 */
public class MessageNonLu extends MapUtilisateur{
    private int nonlu;
    private String receiver,sender;
    public int getNonlu() {
        return nonlu;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public void setNonlu(int nonlu) {
        this.nonlu = nonlu;
    }
    
    public MessageNonLu() {
        this.setNomTable("message_nonlu");
    }
    
}
