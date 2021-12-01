/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import fin.Coursdevise;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;
import mg.spat.exploitant.Activite;
import service.SpatService;
import user.UserEJBBean;
import utilitaire.Constante;
import utilitaire.UtilDB;
import mg.spat.exploitant.Rubrique;
import user.UserEJB;
import utilitaire.Utilitaire;

/**
 *
 * @author Notiavina
 */
public class Mouvement extends ClassEtat {

    private String id, escale, navire, consignataire, provenance, destination, remarque;
    private Date daty, datearrivee;
    private double duree;
    private String heure, typeMvt;
    private Date date_depart;
    private String cargaison;
    private String heure_depart, noVoyage;
    private String escalelib;
    private String couleur = "#ffb401";

    public Prevision getPrevision(Connection c) throws Exception {
        Prevision[] prev = (Prevision[]) CGenUtil.rechercher(new Prevision(), null, null, c, " and id='"+this.getEscale()+"'");
        if(prev.length <= 0){
            throw new Exception("Prevision non trouvee !");
        }
        return prev[0];
    }
    
    public String getNoVoyage() {
        return noVoyage;
    }

    public void setNoVoyage(String noVoyage) {
        this.noVoyage = noVoyage;
    }
    
    public double getValeurTaux(Connection c, String nomTable, Date date) throws Exception {
        String awhere = " and daty <= '" + Utilitaire.datetostring(date) + "' and iddevise = '" + Constante.deviseEuro + "' "
                + " order by daty desc";
        Coursdevise cours = new Coursdevise();
        cours.setNomTable(nomTable);
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(cours, null, null, c, awhere);

        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }

    @Override
    public void viser(UserEJBBean u, Connection c) throws Exception {
        this.updateMouvementPrecedent(u, c);
        if (this.getTypeMvt().equals(Constante.idtypeMvtDepart)) {
            Postedestinataire destination = new Postedestinataire();
            destination = (Postedestinataire) destination.getById(this.getDestination(), destination.getNomTable(), c);
            
            if(destination != null && destination.getInterne().compareTo("0") == 0) {
                Prevision prevision = this.getPrevision(c);
                
                prevision.setDate_depart(this.getDate_depart());
                prevision.setHeure_depart(this.getHeure_depart());
                
                prevision.updateToTableWithHisto(""+u.getUser().getRefuser(), c);
            }
            Navire navireObj = getNavireObjet(c);
            if(!navireObj.getType().equals(Constante.getNavireBornageEtPeche())){
                Activite stationnement = creerActiviteStationnement(String.valueOf(u.getUser().getRefuser()), c);
                u.createObject(stationnement, c);
                u.validerObject(stationnement, c);
            }
            
        }
        if (this.estTouchee(c) && this.getEscale() == null) {
            this.creerPrevision(u, c);
        }
        this.setMode("modif");
        this.setEtat(utilitaire.ConstanteEtat.getEtatValider());
        u.updateObject(this, c);
//        super.viser(u, c);

    }

    public Rubrique findRubrique(Connection c) throws Exception {

        Rubrique rubrique = null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            MouvementLibComplet mouvement = new MouvementLibComplet();
            mouvement.setNomTable("mouvementlibcomplet");
            mouvement.setId(this.getId());
            MouvementLibComplet[] listeMouvement = (MouvementLibComplet[]) CGenUtil.rechercher(mouvement, null, null, c, "");
            if (listeMouvement.length > 0) {
                mouvement = listeMouvement[0];
            }
            Rubrique[] liste = (Rubrique[]) CGenUtil.rechercher(new Rubrique(), null, null, c, "and categorie='" + utilitaire.Constante.idcategorieCapitainerie + "' and objet='" + mouvement.getQuaiprovenance() + "'");
            if (liste.length > 0) {
                rubrique = liste[0];
            } else {
                throw new Exception("Rubrique introuvable");
            }
            if (c != null && verif == 1) {
                c.commit();
            }
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
        return rubrique;
    }

    public void creerPrevision(UserEJBBean u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            /*eto no apetraka ny code*/
//            creer prevision a partir des information du mouvement
            Prevision prevision = new Prevision();
            prevision.setProvenance(this.getProvenance());
            prevision.setConsignataire(this.getConsignataire());
            prevision.setCargaison(this.getCargaison());
            prevision.setDate_depart(this.getDate_depart());
            prevision.setHeure_depart(this.getHeure_depart());
            prevision.setHeure_arrivee(this.getHeure());
            prevision.setDate_arrivee(this.getDatearrivee());
            prevision.setDestination(this.getDestination());
            prevision.setEtat(utilitaire.ConstanteEtat.getEtatValider());
            prevision.setNavire(this.getNavire());
//            inserer prevision dans la base
            prevision.createObject(u.getUser().getRefuser() + "", c);

            this.setEscale(prevision.getId());

            if (c != null && verif == 1) {
                c.commit();
            }
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

    boolean ifDateArriverMin(Mouvement[] liste) {
        boolean min = false;

        if (this.getDatearrivee() != null) {
            min = true;
            for (int i = 0; i < liste.length; i++) {
                System.out.println(liste[i].getDatearrivee() + "------------------" + (this.getDatearrivee()));
                if (liste[i] != null && liste[i].getDatearrivee() != null && this.getDatearrivee() != null && liste[i].getDatearrivee().before(this.getDatearrivee())) {
                    min = false;
                    break;
                }
            }
        }
        return min;
    }

    public boolean estTouchee(Connection c) throws SQLException, Exception {
        boolean verifier = false;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            /*eto no apetraka ny code*/
            if (this.getTypeMvt().compareTo(Constante.tpmvtarrive) == 0) {
                if (this.getEscale() == null) {
                    verifier = true;
                } else {
                    Mouvement[] liste = this.getMouvementMemeEscale(c);
                    System.out.println(liste);
                    if (liste == null || liste.length == 0) {
                        verifier = true;
                    } else {
                        if (ifDateArriverMin(liste)) {
                            verifier = true;
                        }
                    }
                }
            }
            if (c != null && verif == 1) {
                c.commit();
            }
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
        return verifier;
    }

    public String getEscalelib() {
        return escalelib;
    }

    public void setEscalelib(String escalelib) {
        this.escalelib = escalelib;
    }

    public String getCargaison() {
        return cargaison;
    }

    public void setCargaison(String cargaison) {
        this.cargaison = cargaison;
    }

    public Date getDate_depart() {
        return date_depart;
    }

    public void setDate_depart(Date date_depart) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (date_depart != null && this.getDatearrivee() != null) {
                if (Utilitaire.compareDaty(date_depart, this.getDatearrivee()) == -1 && this.getTypeMvt().compareTo(Constante.idtypeMvtDepart) != 0) {
                    throw new Exception("Date depart invalide par rapport à la date d arrivee");
                }
            }
        }
        this.date_depart = date_depart;
    }

    public String getHeure_depart() {
        return heure_depart;
    }

    public void setHeure_depart(String heure_depart) throws Exception {
        try {
            if (getMode().compareToIgnoreCase("modif") == 0) {
                if (heure_depart != null && heure_depart.trim().compareTo("") != 0 && this.getDatearrivee() != null) {
                    Utilitaire.testHeureValide(heure_depart);
                    if (this.getTypeMvt().compareTo(Constante.idtypeMvtDepart) != 0 && Utilitaire.compareDaty(this.getDate_depart(), this.getDatearrivee()) == 0 && Utilitaire.comparerHeure(this.getHeure(), heure_depart) == -1) {
                        throw new Exception("Heure de départ invalide par rapport à l heure d arrivee");
                    }
                }
            }
            this.heure_depart = heure_depart;
        } catch (Exception e) {
            throw e;
        }

    }
    
     public Navire getNavireObjet(Connection c) throws Exception{
        Navire navire = new Navire();
        Navire[] ls = (Navire[]) CGenUtil.rechercher(navire, null, null, c, " and id='"+this.getNavire()+"'");
        return ls.length > 0 ? ls[0] : null;
    }

    public Mouvement() {
        super.setNomTable("mouvement");
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String esc) throws Exception {
//        if(this.getMode().compareTo("modif")==0){
//            if (esc == null || esc.compareToIgnoreCase("") == 0) {
//                throw new Exception("Escale obligatoire");
//            }
//        }
        this.escale = esc;
    }

    public String getNavire() {
        return navire;
    }

    public void setNavire(String navire) {
        this.navire = navire;
    }

    public String getConsignataire() {
        return consignataire;
    }

    public void setConsignataire(String consignataire) {
        this.consignataire = consignataire;
    }

    public String getProvenance() {
        return provenance;
    }

    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) throws Exception {
        if (this.getMode().equalsIgnoreCase("modif")) {
            if (this.getProvenance().equalsIgnoreCase(destination)) {
                throw new Exception("La destination et la provenance ne peuvent être la même!");
            }
        }

        this.destination = destination;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        /*if(this.getMode().equals("modif") && daty!=null){
            //daty = Utilitaire.string_date("YYYY-MM-dd",Utilitaire.dateDuJour());
            daty = Utilitaire.string_date("dd/MM/YYYY",Utilitaire.dateDuJour());
        }*/
        this.daty = daty;
    }

    public Date getDatearrivee() {
        return datearrivee;
    }

    public void setDatearrivee(Date dateArrivee) {
        this.datearrivee = dateArrivee;
    }

    public static Timestamp getTimestamp(Date d, String h) throws Exception {
        SimpleDateFormat dateJava = new SimpleDateFormat("yyyy-MM-dd");
        String date = dateJava.format(d) + " " + Utilitaire.formatHeureMinSec(h);

        return Timestamp.valueOf(date);
    }

    public static double diffEnHeure(Date dsup, String hsup, Date dinf, String hinf) throws Exception {
        Timestamp datesup = getTimestamp(dsup, hsup),
                dateinf = getTimestamp(dinf, hinf);

        long diffInMillies = Math.abs(datesup.getTime() - dateinf.getTime());
        double diff = TimeUnit.HOURS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        
        return diff;
    }

    public double getDuree() throws Exception {
        double d = this.duree;
        
        if (this.getTypeMvt() != null && this.getTypeMvt().compareTo(Constante.idtypeMvtDepart) != 0) {
            if (this.getDatearrivee() != null && this.getHeure() != null && !this.getHeure().trim().equalsIgnoreCase("") && this.getDate_depart() != null && this.getHeure_depart() != null && !this.getHeure_depart().trim().equalsIgnoreCase("")) {
//            return Utilitaire.diffJourDatyGallois(this.getDate_depart(),this.getDatearrivee());
//                System.out.println("date dep " + this.getDate_depart() + " " + this.getHeure_depart());
//                System.out.println("date arr " + this.getDatearrivee() + " " + this.getHeure());
                d = diffEnHeure(this.getDatearrivee(), this.getHeure(), this.getDate_depart(), this.getHeure_depart());
            }
        }
        
        return Math.floor(d);
    }

    public void setDuree(double duree) throws Exception {

        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (duree < 0) {
                throw new Exception("duree invalide");
            }
        }
        this.duree = duree;
    }

    public String getHeure() {
        return heure;
    }

    public void setHeure(String heure) throws Exception {
        try {
            if (heure != null && heure.trim().compareTo("") != 0) {
                Utilitaire.testHeureValide(heure);
            }
            this.heure = heure;
        } catch (Exception e) {
            throw e;
        }

    }

    public String getTypeMvt() {
        return typeMvt;
    }

    public void setTypeMvt(String typeMvt) {
        this.typeMvt = typeMvt;
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("MVT", "getseqmouvement");
        this.setId(makePK(c));
    }

    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }

    public void controler(Connection c) throws Exception {
        try {
            SpatService.nouveauMouvement(this, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public Mouvement getMouvementById(Connection c) throws Exception {
        boolean estOuvert = false;
        Mouvement mouvement = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            Mouvement[] liste = (Mouvement[]) CGenUtil.rechercher(new Mouvement(), null, null, c, " and id='" + this.getId() + "'");
            if (liste.length > 0) {
                mouvement = liste[0];
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
        return mouvement;
    }

    public MouvementLibComplet getMouvementLibCompletById(Connection c) throws Exception {
        boolean estOuvert = false;
        MouvementLibComplet mouvement = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            MouvementLibComplet[] liste = (MouvementLibComplet[]) CGenUtil.rechercher(new MouvementLibComplet(), null, null, c, " and id='" + this.getId() + "'");
            if (liste.length > 0) {
                mouvement = liste[0];
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
        return mouvement;
    }

    public Mouvement[] getMouvementMemeEscale() throws Exception {
        Connection c = null;

        try {
            return this.getMouvementMemeEscale(c);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Mouvement[] getMouvementMemeEscalePrec(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Mouvement mvt = new Mouvement();
            String order = "";

            if (this.getTypeMvt().compareTo(Constante.getTpmvtdepart()) == 0) {
                mvt.setNomTable("MOUVEMENT_ARRIVEE_PREV");
                order = " order by datearrivee desc, heure desc ";
            } else {
                mvt.setNomTable("MOUVEMENT_DEPART_PREV");
                order = " order by date_depart desc, heure_depart desc ";
            }
            return (Mouvement[]) CGenUtil.rechercher(mvt, null, null, c, " and escale ='" + this.getEscale() + "' and id != '" + this.getId() + "'" + order);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();;
            }
        }
    }

    public Activite creerActivite(UserEJB u, Connection c) throws Exception {
        int verif = 0;
        Activite act = null;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            Mouvement[] mvt = getMouvementMemeEscalePrec(c);

            if (mvt == null || mvt.length == 0) {
                throw new Exception("Pas de mouvement même escale");
            }

            Rubrique rub = findRubrique(c);

            double qte = mvt[0].getDuree();
            int mois = Utilitaire.getMois(mvt[0].getDatearrivee()),
                    annee = Utilitaire.getAnnee(mvt[0].getDatearrivee());

            act = new Activite(Utilitaire.dateDuJourSql(), rub.getDesignation(), this.getConsignataire(), rub.getId(), this.getNavire(), qte, mois, annee);

            u.createObject(act, c);

            if (verif == 1) {
                c.commit();
            }
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

        return act;
    }

    public Mouvement[] getMouvementMemeEscale(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            return (Mouvement[]) CGenUtil.rechercher(new Mouvement(), null, null, c, " and escale ='" + this.getEscale() + "' and id != '" + this.getId() + "' order by datearrivee asc");
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();;
            }
        }
    }

    public void updateMouvementPrecedent(UserEJBBean user, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            String ref = String.valueOf(user.getUser().getRefuser());
            System.out.println("Refuser dans visa = " + ref);
            if (this.getTypeMvt().compareToIgnoreCase(Constante.getTpmvtdepart()) == 0) {
                Mouvement[] precedent = this.getMouvementMemeEscalePrec(c);
                if (precedent.length != 0) {
                    precedent[0].setNomTable("mouvement");
                    precedent[0].setDate_depart(this.getDate_depart());
                    precedent[0].setHeure_depart(this.getHeure_depart());
                    precedent[0].updateToTableWithHisto(ref, c);
                }
            }
            if (c != null && verif == 1) {
                c.commit();
            }
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

    public void checkNouveauMouvement(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            if (c != null && verif == 1) {
                c.commit();
            }
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
    
     public Activite creerActiviteStationnement(String u, Connection c) throws Exception{
        Mouvement[] mvts = getMouvementMemeEscalePrec(c);
        Mouvement mvtPrec = null;
        if(mvts != null && mvts.length > 0) mvtPrec = mvts[0];
        Prevision prev = this.getPrevision(c);
        
        Activite a = new Activite();
        a.setRubrique(Constante.idStationnement);
        a.setDesignation("Stationnement");
        a.setClient(prev.getConsignataire());
        a.setMois(Utilitaire.getMois(mvtPrec.getDatearrivee()));
        a.setAnnee(Utilitaire.getAnnee(mvtPrec.getDatearrivee()));
        a.setDaty(Utilitaire.dateDuJourSql());
        a.setBateau(prev.getId());
        a.setDatedebut(mvtPrec.getDatearrivee());
        a.setHeuredebut(mvtPrec.getHeure());
        a.setDatefin(this.getDate_depart());
        a.setHeurefin(this.getHeure_depart());
        a.setTaux(getValeurTaux(c, "coursdeviseNonMICTSL",this.getDate_depart()));
        a.setTypeSource(this.getProvenance());
        
        return a;
    }

    private Navire getNavireObjet(Connection c) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
