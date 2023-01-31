package mg.spat;

import java.sql.Connection;

import bean.CGenUtil;
import bean.ClassEtat;
import data.FactureData;
import facture.FactureClient;
import facture.PaiementFacture;
import utilitaire.UtilDB;

public class FcDefPr extends ClassEtat {
    String id, id1, id2;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId1() {
        return id1;
    }

    public void setId1(String id1) {
        this.id1 = id1;
    }

    public String getId2() {
        return id2;
    }

    public void setId2(String id2) {
        this.id2 = id2;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public FcDefPr() {
        this.setNomTable("FCDEFPR");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("FCDP", "GETSEQFCDEFPR");
        this.setId(makePK(c));
    }

    
    public FactureClient getFacture(Connection c, String id) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient cc = new FactureClient();
            cc.setNomTable("facture_client_union");
            String awhere = String.format(" and id = '%s' ", id);
            FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(cc, null, null, c, awhere);
            if (result != null && result.length > 0) {
                return result[0];
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public PaiementFacture getPaiementProv(Connection c)throws Exception{
        int verif = 0;
        PaiementFacture pf = new PaiementFacture();
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            pf.setIdFact(this.getId1());
            PaiementFacture[] tmp = (PaiementFacture[])CGenUtil.rechercher(pf, null, null, c, "");
            if(tmp.length!=0){
                pf = tmp[0];
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return pf;
    }
    
    public JournalCaisse createJC(Connection c, String idJournal, double montant)throws Exception{
        JournalCaisse jc = new JournalCaisse();
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            JournalCaisse caissePv = (JournalCaisse)jc.getById(idJournal, jc.getNomTable(), c);
            caissePv.setMontant(montant);
            jc = caissePv;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return jc;
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception
    {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            PaiementFacture pf = this.getPaiementProv(c);
            FactureClient def = (FactureClient)new FactureClient().getById(this.getId1(), "facture_client_union_ordre", c);
            FactureClient prov = (FactureClient)new FactureClient().getById(this.getId2(), "facture_client_union_ordre", c);
            
            double montant = def.getMontantreste();
            FactureData factData = new FactureData();
            factData.initData(prov.getId());
            double tp = factData.getMontantTP();
            JournalCaisse jc = this.createJC(c, pf.getIdMvt(), montant);
            jc.createObject(u, c);
            //min entre reste à payer FD sy ny solde dispo an'ny Prov no alaina
            System.out.println("TROP PERCU ====== " + tp + " && ID2 ========== " + montant);
            if(tp>0 && tp < montant){
                montant = tp; 
            }

            if(pf.getIdMvt()!=null){
                PaiementFacture ins = new PaiementFacture(jc.getTuppleID(), this.getId2(), montant);
                ins.createObject(u, c);
            }else{
                throw new Exception("Pas de paiement pour la facture de provision");
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return super.validerObject(u, c);
    }
}