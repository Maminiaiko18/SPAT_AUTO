package mg.cnaps.messagecommunication;

import java.sql.Timestamp;
import utilitaire.Utilitaire;

/**
 *
 * @author NERD
 */
public class MessageLibelle extends Message{
    private String sendername;
    private String receivername;
    private int comefrom;

    public MessageLibelle() {
        this.setNomTable("message_libelle");
    }

    public String getReceivername() {
        return Utilitaire.champNull(receivername);
    }

    public void setReceivername(String receivername) {
        this.receivername = receivername;
    }

    public int getComefrom() {
        return comefrom;
    }

    public void setComefrom(int comefrom) {
        this.comefrom = comefrom;
    }

    public String getSendername() {
        return Utilitaire.champNull(sendername);
    }

    public void setSendername(String sendername) {
        this.sendername = sendername;
    }

    
    public MessageLibelle(String id, String sender, String sendername, String receiver, String receivername, String msg, Timestamp datemessage,String statut) {
        super.setId(id);
        super.setSender(sender);
        super.setReceiver(receiver);
        super.setMsg(msg);
        super.setDateheure(datemessage);
        super.setStatut(statut);
        this.sendername = sendername;
        this.receivername = receivername;
    }
    public MessageLibelle(String id, String idconversation, String sender, String sendername, String receiver, String receivername, String msg, Timestamp datemessage,String statut, int comefrom) {
        super.setId(id);
        super.setIdconversation(idconversation);
        super.setSender(sender);
        super.setReceiver(receiver);
        super.setMsg(msg);
        super.setDateheure(datemessage);
        super.setStatut(statut);
        this.sendername = sendername;
        this.receivername = receivername;
        this.comefrom = comefrom;
    }
}
