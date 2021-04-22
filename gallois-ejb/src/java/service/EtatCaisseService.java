/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import bean.TypeObjet;
import java.sql.Connection;
import mg.spat.BonProvisoire;
import mg.spat.EtatCaisse;
import mg.spat.JournalCaisse;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import java.sql.Date;
import mg.spat.Caisse;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class EtatCaisseService {

    private Caisse[] caisses;
    
    
    public static double getRecette(String idcaisse, Date date, Connection c) throws Exception {
        double rep = 0;
        boolean in = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                in = true;
            }
            String requete = "select sum(credit) as sommeCredit from journalcaisse where caisse='"+idcaisse+"' and dateEffet = '"+Utilitaire.datetostring(date)+"' and credit != 0 and etat >= "+ConstanteEtat.getEtatValider()+" group by caisse";
            JournalCaisse j = new JournalCaisse();
            j.setNomTable("journalcaisse_sommeCredit");
            JournalCaisse[] somme = (JournalCaisse[]) CGenUtil.rechercher(j, requete, c);
            if(somme.length > 0){
                rep =  somme[0].getSommeCredit();
            }
        }catch(Exception ex){
            throw ex;
        }finally{
            if(in && c!=null) c.close();
        }
        return rep;
    }
    
    public void genererEtatCaisseData(EtatCaisse ec) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            
            caisses = (Caisse[]) CGenUtil.rechercher(new Caisse(), null, null, c, "");
            ec.generer(c);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static void getEtatCaisse(EtatCaisse ec) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Caisse ca = new Caisse();
            //ca.setNomTable("CAISSE_LIB");
            TypeObjet banque = new TypeObjet();
            banque.setNomTable("banque");
            TypeObjet[] lbanque = (TypeObjet[]) CGenUtil.rechercher(banque, null, null, c, " and id = '" + ec.getCaisse() + "'");

            Caisse[] listeCaisse = (Caisse[]) CGenUtil.rechercher(ca, null, null, c, " and id = '" + ec.getCaisse() + "'");
            if (listeCaisse.length == 0) {
                throw new Exception("Caisse inexistante");
            }
            ec.setCaisse(listeCaisse[0].getId());

            ec.setListeCaisse((JournalCaisse[]) CGenUtil.rechercher(new JournalCaisse(), null, null, c, " and dateeffet=to_date('" + ec.getDaty() + "','YYYY-MM-dd') and caisse='" + ec.getCaisse() + "'"));

            ec.setBonProvisoire(getSommeBonProvisoire(ec.getCaisse(), c));

            ec.setSoldeAnterieur(new JournalService().getSoldeAnterieur(c, ec.getDaty(), ec.getCaisse()));
            if (ec.getListeCaisse().length > 0) {
                ec.setFolio(ec.getListeCaisse()[0].getFolio());
                double totDeb = 0, totCred = 0;
                JournalCaisse[] liste = ec.getListeCaisse();
                for (JournalCaisse unjournal : liste) {
                    totDeb += unjournal.getDebit();
                    totCred += unjournal.getCredit();
                }
                ec.setTotalDebitJournal(totDeb);
                ec.setTotalCreditJournal(totCred);
            }
            ec.setSoldeActuel(ec.getTotalDebitJournal() + ec.getSoldeAnterieur() - ec.getTotalCreditJournal() - ec.getBonProvisoire());
            ec.setTotalDebit(ec.getTotalDebitJournal() + ec.getSoldeAnterieur());
            ec.setTotalCredit(ec.getTotalCreditJournal() + ec.getSoldeActuel() + ec.getBonProvisoire());

            if (lbanque.length > 0) {
                ec.setListePlacement(SpatService.getPlacementDate(ec.getDaty(), lbanque[0].getId(), c));
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public static double getSommeBonProvisoire(String caisse, Connection c) throws Exception {
        double somme = 0;
        try {
            BonProvisoire[] bp = (BonProvisoire[]) CGenUtil.rechercher(new BonProvisoire(), null, null, c, " and caisse='" + caisse + "' and etat=" + ConstanteEtat.getEtatValider());
            if (bp.length > 0) {
                for (int i = 0; i < bp.length; i++) {
                    //somme+=bp[i].getDebit();
                    //somme+=bp[i].getDebit()-bp[i].getSommeRegulBonPrpvisoire(c)+bp[i].getSommeRetourBonPrpvisoire(c);
                    somme += bp[i].getReste(c);
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return somme;
    }

    public Caisse[] getCaisses() {
        return caisses;
    }

    public void setCaisses(Caisse[] caisses) {
        this.caisses = caisses;
    }

}
