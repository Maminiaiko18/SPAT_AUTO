package modules;

import bean.CGenUtil;
import historique.MapUtilisateur;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import mg.cnaps.messagecommunication.Conversation;
import mg.cnaps.messagecommunication.Message;
import mg.cnaps.messagecommunication.MessageLibelle;

/**
 *
 * @author NERD
 */
public class GestionMessage {

    public MessageLibelle[] getMessages(String currentuser, String categorie, int limit, int offset, Connection tsotra, Connection con) throws Exception {
        ResultSet dr = null;
        Statement cmd = null;
        try {
            String categoriemsg = " WHERE statut like '%" + categorie + "%' AND (SENDER = '"+currentuser+"' OR RECEIVER = '"+currentuser+"')";
            String comandeInterne = "SELECT *\n"
                    + "FROM (SELECT ID,\n"
                    + "IDCONVERSATION,\n"
                    + "SENDER,\n"
                    + "RECEIVER,\n"
                    + "MSG,\n"
                    + "DATEHEURE,\n"
                    + "STATUT,\n"
                    + "RANK() OVER( PARTITION BY IDCONVERSATION ORDER BY DATEHEURE DESC) rnk\n"
                    + "FROM MESSAGE "+categoriemsg+")\n"
                    + "WHERE rnk = 1 ORDER BY DATEHEURE DESC";

//            System.out.println(comandeInterne);
            cmd = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            dr = cmd.executeQuery(comandeInterne);
            ArrayList<Message> ret = new ArrayList<Message>();
            boolean test = false;
            while (dr.next()) {
                test = true;
                Message tmp = new Message();
                tmp.setId(dr.getString("ID"));
                tmp.setIdconversation(dr.getString("IDCONVERSATION"));
                tmp.setSender(dr.getString("SENDER"));
                tmp.setReceiver(dr.getString("RECEIVER"));
                tmp.setMsg(dr.getString("MSG"));
                tmp.setDateheure(dr.getTimestamp("DATEHEURE"));
                tmp.setStatut(dr.getString("STATUT"));
                ret.add(tmp);
            }
            if(test == false)
                return null;
            String uList = "";
            for (Message msg : ret) {
                uList += "'" + msg.getSender() + "', '" + msg.getReceiver() + "',";
            }
            uList = uList.substring(0, uList.length() - 1);
            MapUtilisateur[] pL = (MapUtilisateur[]) CGenUtil.rechercher(new MapUtilisateur(), null, null, tsotra, " AND REFUSER in (" + uList + ")");

            ArrayList<MessageLibelle> messageLibelle = new ArrayList<MessageLibelle>();
            HashMap<String, MapUtilisateur> jHash = new HashMap<String, MapUtilisateur>();
            for (MapUtilisateur userelement : pL) {
                jHash.put(userelement.getTuppleID(), userelement);
            }

            for (Message messageelement : ret) {
                MapUtilisateur sender = (MapUtilisateur) jHash.get(messageelement.getSender());
                MapUtilisateur receiver = (MapUtilisateur) jHash.get(messageelement.getReceiver());
                messageLibelle.add(new MessageLibelle(messageelement.getId(), messageelement.getIdconversation(),sender.getTuppleID(), sender.getNomuser(), receiver.getTuppleID(), receiver.getNomuser(), messageelement.getMsg(), messageelement.getDateheure(), messageelement.getStatut(), (sender.getTuppleID().equals(currentuser)) ? 1 : 0));
            }
            MessageLibelle[] retour = messageLibelle.toArray(new MessageLibelle[messageLibelle.size()]);
            return retour;
        } catch (Exception x) {
            x.printStackTrace();
            throw new Exception("Erreur durant la recherche " + x.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (cmd != null) {
                cmd.close();
            }
        }
    }

    public MessageLibelle[] getMessageById(String currentutilisateur, String idconversation, Connection con) throws Exception {
        ResultSet dr = null;
        Statement cmd = null;
        try {
            
            Message[] messages = (Message[])CGenUtil.rechercher(new Message(), null, null, con, " AND IDCONVERSATION = '"+idconversation+"' ORDER BY DATEHEURE ASC");
            String jList = "'" + messages[0].getSender() + "','" + messages[0].getReceiver() + "'";

            MapUtilisateur[] user1 = (MapUtilisateur[]) CGenUtil.rechercher(new MapUtilisateur(), null, null, " AND REFUSER = '" + messages[0].getSender() + "'");
            MapUtilisateur[] user2 = (MapUtilisateur[]) CGenUtil.rechercher(new MapUtilisateur(), null, null, " AND REFUSER = '" + messages[0].getReceiver() + "'");
            ArrayList<MessageLibelle> messageLibelle = new ArrayList<MessageLibelle>();

            for (Message messageelement : messages) {
                String senderid = messageelement.getSender();
                String sendername = (user1[0].getTuppleID().equals(messageelement.getSender()))? user1[0].getNomuser() : user2[0].getNomuser();
                String receiverid = messageelement.getReceiver();
                String receivername = (user1[0].getTuppleID().equals(messageelement.getReceiver()))? user1[0].getNomuser() : user2[0].getNomuser();
                int comefrom = (messageelement.getSender().equals(currentutilisateur))?1:0;
                
                messageLibelle.add(new MessageLibelle(messageelement.getId(), messageelement.getIdconversation(),senderid, sendername, receiverid, receivername, messageelement.getMsg(), messageelement.getDateheure(), messageelement.getStatut(), comefrom));
                
            }
//            Collections.reverse(messageLibelle);
            MessageLibelle[] retour = messageLibelle.toArray(new MessageLibelle[messageLibelle.size()]);
            return retour;
        } catch (Exception x) {
            x.printStackTrace();
            throw new Exception("Erreur durant la recherche " + x.getMessage());
        } finally {
            if (dr != null) {
                dr.close();
            }
            if (cmd != null) {
                cmd.close();
            }
        }
    }
}
