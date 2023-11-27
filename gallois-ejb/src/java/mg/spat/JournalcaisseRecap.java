package mg.spat;
import java.util.Objects;
import java.sql.*;
import bean.AdminGen;
import bean.CGenUtil;
import mg.amadia.stock.EtatdeStockDate;
import utilitaire.UtilDB;

/**
 *
 * @author Flavien
 */
public class JournalcaisseRecap extends JournalCaisse {
    private int nombre;
    private double credit;
    private double debit;
    private double soldeinitial;
    private double soldefinal;

    public JournalcaisseRecap() {
    }

    public JournalcaisseRecap getRecap(String date1,String date2,String caisse,Connection c) throws Exception {
        int verif = 0;
        JournalcaisseRecap retour;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            
            EtatdeStockDate[] etat = new JournalCaisse().etatdecaisse(date1,date2,caisse,c);
            String where = " and caisse='"+caisse+"' and etat=11 and dateeffet >= '"+date1+"' and dateeffet<='"+date2+"'";
            JournalCaisse[] mouvement = (JournalCaisse[]) CGenUtil.rechercher(new JournalCaisse(), null, null, c, where);
            double initial = 0;
            double finale = 0;
            if(etat[0]!=null) initial = etat[0].getReste();
            if(etat[1]!=null) finale = etat[1].getReste();

            double credit=AdminGen.calculSommeDouble(mouvement, "credit");
            double debit=AdminGen.calculSommeDouble(mouvement, "debit");
            int nb = mouvement.length;

            retour = new JournalcaisseRecap(nb,credit,debit,initial,finale);
            if (verif == 1) {
                c.commit();
            }
            return retour;
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public JournalcaisseRecap(int nombre, double credit, double debit, double soldeinitial, double soldefinal) {
        this.nombre = nombre;
        this.credit = credit;
        this.debit = debit;
        this.soldeinitial = soldeinitial;
        this.soldefinal = soldefinal;
    }

    public int getNombre() {
        return this.nombre;
    }

    public void setNombre(int nombre) {
        this.nombre = nombre;
    }

    public double getCredit() {
        return this.credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public double getDebit() {
        return this.debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getSoldeinitial() {
        return this.soldeinitial;
    }

    public void setSoldeinitial(double soldeinitial) {
        this.soldeinitial = soldeinitial;
    }

    public double getSoldefinal() {
        return this.soldefinal;
    }

    public void setSoldefinal(double soldefinal) {
        this.soldefinal = soldefinal;
    }

    public JournalcaisseRecap nombre(int nombre) {
        setNombre(nombre);
        return this;
    }

    public JournalcaisseRecap credit(double credit) {
        setCredit(credit);
        return this;
    }

    public JournalcaisseRecap debit(double debit) {
        setDebit(debit);
        return this;
    }

    public JournalcaisseRecap soldeinitial(double soldeinitial) {
        setSoldeinitial(soldeinitial);
        return this;
    }

    public JournalcaisseRecap soldefinal(double soldefinal) {
        setSoldefinal(soldefinal);
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof JournalcaisseRecap)) {
            return false;
        }
        JournalcaisseRecap journalcaisseRecap = (JournalcaisseRecap) o;
        return nombre == journalcaisseRecap.nombre && credit == journalcaisseRecap.credit && debit == journalcaisseRecap.debit && soldeinitial == journalcaisseRecap.soldeinitial && soldefinal == journalcaisseRecap.soldefinal;
    }

    @Override
    public int hashCode() {
        return Objects.hash(nombre, credit, debit, soldeinitial, soldefinal);
    }

    @Override
    public String toString() {
        return "{" +
            " nombre='" + getNombre() + "'" +
            ", credit='" + getCredit() + "'" +
            ", debit='" + getDebit() + "'" +
            ", soldeinitial='" + getSoldeinitial() + "'" +
            ", soldefinal='" + getSoldefinal() + "'" +
            "}";
    }
}