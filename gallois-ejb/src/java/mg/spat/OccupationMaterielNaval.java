/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import factureclient.FactureClient;
import factureclient.FactureClientDetail;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;
import mg.spat.exploitant.Activite;
import mg.spat.exploitant.Rubrique;
import rubrique.RubriqueFactureFournisseur;
import rubrique.TarifRubriqueFactureClient;
import service.PrevisionService;
import user.UserEJB;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class OccupationMaterielNaval extends ClassEtat {

    private String id, idmateriel_naval, idpilote, idcommandant, idnatureoperation, idmanoeuvrebord,
            idnavire,/*idclient,*/ position, positionlib, observation, idarrivee, idarriveelib;
    private Date daty;
    private String heuredebut;
    private Date datefin;
    private String heurefin;
    private double duree;
    private String etatlib;
    private String idprevision, escale;
    private String idclient;
    private Activite activite;

    public Activite getActivite() {
        return activite;
    }
    
    public void setActivite(Activite activite) {
        this.activite = activite;
    }

    public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) {
        this.idclient = idclient;
    }

    public Prevision getPrevision(Connection c) throws Exception {
        Prevision prevision = new Prevision();

        if (this.getIdprevision() != null) {
            prevision = (Prevision) prevision.getById(this.getIdprevision(), prevision.getNomTable(), c);
            
            return prevision;
        }

        return null;
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        this.setActivite(genererActivite(c));
        return super.validerObject(u, c);
    }

    public Activite genererActivite(Connection c) throws Exception {
        int verif = 0;
        Activite activite = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            OccupationMaterielNaval occupation = (OccupationMaterielNaval) new OccupationMaterielNaval().getById(this.getId(), "occupationmaterielnavallib", c);
            String nomRubrique = this.genererNomRubrique(c);
            System.out.println("Nom rubrique====" + nomRubrique);
            Rubrique rubrique = this.findRubrique(c, nomRubrique);
            /*if(rubrique==null){
                throw new Exception("Rubrique introuvable pour cette prestation");
            }*/
            String idRubrique = null;
            if (rubrique != null) {
                idRubrique = rubrique.getId();
            }
            activite = new Activite(this.getDaty(), "Activite auto via prestation " + this.getId(), occupation.getIdclient(), idRubrique, occupation.getIdprevision(), this.getDuree(), Utilitaire.getMois(this.getDaty()), Utilitaire.getAnnee(this.getDaty()), ConstanteEtat.getEtatCreer());
            activite.construirePK(c);
            activite.insertToTable(c);
            if (verif == 1) {
                c.commit();
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return activite;
    }

    public Rubrique findRubrique(Connection c, String awhere) throws Exception {
        Rubrique rubrique = null;
        System.out.println("NOM RUB :: " + awhere);
        Rubrique[] liste = (Rubrique[]) CGenUtil.rechercher(new Rubrique(), null, null, c, "and upper(designation) like upper('%" + awhere + "%')");
        if (liste.length > 0) {
            rubrique = liste[0];
        }
        return rubrique;
    }

    public boolean estFerie(Date d, Connection c) throws Exception {
        if (d == null) {
            return false;
        }
        JourFerie[] jfs = (JourFerie[]) CGenUtil.rechercher(new JourFerie(), null, null, c, " and daty = '" + Utilitaire.formatterDaty(d) + "' ");
        if (jfs.length > 0) {
            return true;
        }
        return Utilitaire.dayOfDate(d) == 1 || Utilitaire.dayOfDate(d) == 7;
    }

    public boolean estJour(String heure_debut) throws Exception {
        if (heure_debut == null || heure_debut.isEmpty()) {
            return false;
        }
        int c1 = Utilitaire.comparerHeure(heure_debut, "05:00");
        int c2 = Utilitaire.comparerHeure(heure_debut, "18:59");
        return (c1 == -1 || c1 == 0) && (c2 == 1 || c2 == 0);
    }

    public String genererNomRubrique(Connection c) throws Exception {
        OccupationMaterielNavalLibComplet oc = new OccupationMaterielNavalLibComplet();
        oc.setNomTable("OCCUPATIONMATERIELNAVALLIBCPL");
        OccupationMaterielNavalLibComplet[] liste = (OccupationMaterielNavalLibComplet[]) CGenUtil.rechercher(oc, null, null, c, " and id='" + this.getId() + "'");
        if (liste.length <= 0) {
            throw new Exception("OCCUPATION MATERIEL NAVAL non trouve !");
        }
        oc = liste[0];
        String nom = oc.getIdnatureoperation();
        if (estFerie(oc.getDaty(), c)) {
            nom += " ferie";
        } else if (estJour(oc.getHeuredebut())) {
            nom += " jour";
        } else {
            nom += " nuit";
        }

        if (oc.getPavillon() != null && oc.getPavillon().equals(Constante.idPavillonMada)) {
            nom += " C";
        } else if ((oc.getCargaison() != null && oc.getCargaison().equals(Constante.idCargaisonPetrole)) && (oc.getIdmanoeuvrebord() != null && !oc.getIdmanoeuvrebord().equalsIgnoreCase("sortie"))) {
            nom += " PFI LC";
        } else {
            nom += " LC";
        }
        return nom;
    }

    public OccupationMaterielNaval() {
        super.setNomTable("occupationmaterielnaval");
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        String[] flottes = this.getIdmateriel_naval().split(";");

        for (String flotte : flottes) {
            this.setIdmateriel_naval(flotte);
            this.setId(null);
            super.createObject(u, c);
        }

        return this;
    }

    public TarifRubriqueFactureClient[] getTarifRubrique(Connection c) throws Exception {
        int verif = 0;
        TarifRubriqueFactureClient[] tarifs = new TarifRubriqueFactureClient[0];

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            tarifs = (TarifRubriqueFactureClient[]) CGenUtil.rechercher(new TarifRubriqueFactureClient(), null, null, c, " and idnature = '" + this.getIdnatureoperation() + "' and etat >= " + ConstanteEtat.getEtatValider() + " order by borne_inf, borne_sup");
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return tarifs;
    }

    public OccupationMaterielNavalLibComplet[] getOccupations(String[] ids, Connection c) throws Exception {
        int verif = 0;
        OccupationMaterielNavalLibComplet[] occupations = new OccupationMaterielNavalLibComplet[0];

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            String awhere = " and id in (" + Utilitaire.tabToString(ids, "'", ",") + ")";
            occupations = (OccupationMaterielNavalLibComplet[]) CGenUtil.rechercher(new OccupationMaterielNavalLibComplet(), null, null, c, awhere);
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return occupations;
    }

    public double calculMontant(OccupationMaterielNavalLibComplet occup, Connection c) throws Exception {
        TarifRubriqueFactureClient[] tarifs = occup.getTarifRubrique(c);

        double duree = occup.getDuree();
        double montant = 0;

        for (int i = 0; i < tarifs.length; i++) {
            if (tarifs[i].getBorne_inf() <= occup.getDuree()) {
                double unite = tarifs[i].getUnite(), pu = tarifs[i].getPrixunitaire();
                double ecart = (tarifs[i].getBorne_sup() - tarifs[i].getBorne_inf());

                if (unite > 0) {
                    double d = duree >= ecart ? ecart : duree;
                    montant += d / unite * pu;
                } else {
                    montant += pu;
                }

                duree -= ecart;
                occup.setObservation(tarifs[i].getCompte());
            }
        }

        return montant;
    }

    private void creerFactureFille(UserEJB u, String idmere, OccupationMaterielNavalLibComplet[] details, Connection c) throws Exception {
        for (OccupationMaterielNavalLibComplet occup : details) {
            if (occup.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Occupation " + occup.getId() + " non visée");
            }
            FactureClientDetail fille = new FactureClientDetail();
            fille.setIdfacture(idmere);
            fille.setMedicament(occup.getIdnatureoperation());
            fille.setIdacte(occup.getId());
            fille.setDesignation(occup.getValnatureoperation());
            fille.setQuantite(occup.getDuree());

            double montant = calculMontant(occup, c);

            fille.setComptecredit(occup.getObservation());
            fille.setMontant(montant / fille.getQuantite());
            fille.setMontantt(montant);

            u.createObject(fille, c);
        }
    }

    private void controlFacturation(String[] ids, Connection c) throws Exception {
        OccupationMaterielNaval occup = new OccupationMaterielNaval();
        occup.setNomTable("OCCUPATION_FACTURE_VALIDE");

        String awhere = " and id in (" + Utilitaire.tabToString(ids, "'", ",") + ")";

        OccupationMaterielNaval[] details = (OccupationMaterielNaval[]) CGenUtil.rechercher(occup, null, null, c, awhere);

        if (details != null && details.length > 0) {
            throw new Exception("Déjà facturé");
        }
    }

    public String facturerMultiple(UserEJB u, String[] ids, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            if (ids.length == 0) {
                throw new Exception("Vous devez cocher!");
            }

            controlFacturation(ids, c);
            OccupationMaterielNavalLibComplet[] details = getOccupations(ids, c);

            FactureClient mere = new FactureClient();
            mere.setDesignation("Facturation Occupation Materiel Naval");
            mere.setDaty(Utilitaire.dateDuJourSql());
            u.createObject(mere, c);

            if (details != null && details.length > 0) {
                creerFactureFille(u, mere.getId(), details, c);
            }

            if (verif == 1) {
                c.commit();
            }

            return mere.getId();
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

    public String getPositionlib() {
        return positionlib;
    }

    /*
    public String getIdclient() {
    return idclient;
    }
    public void setIdclient(String idclient) {
    this.idclient = idclient;
    }*/
    public void setPositionlib(String positionlib) {
        this.positionlib = positionlib;
    }

    public String getIdarriveelib() {
        return idarriveelib;
    }

    public void setIdarriveelib(String idarriveelib) {
        this.idarriveelib = idarriveelib;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmateriel_naval() {
        return idmateriel_naval;
    }

    public void setIdmateriel_naval(String idmateriel_naval) {
        this.idmateriel_naval = idmateriel_naval;
    }

    public String getIdpilote() {
        return idpilote;
    }

    public void setIdpilote(String idpilote) {
        this.idpilote = idpilote;
    }

    public String getIdcommandant() {
        return idcommandant;
    }

    public void setIdcommandant(String idcommandant) {
        this.idcommandant = idcommandant;
    }

    public String getIdnatureoperation() {
        return idnatureoperation;
    }

    public void setIdnatureoperation(String idnatureoperation) {
        this.idnatureoperation = idnatureoperation;
    }

    public String getIdmanoeuvrebord() {
        return idmanoeuvrebord;
    }

    public void setIdmanoeuvrebord(String idmanoeuvrebord) {
        this.idmanoeuvrebord = idmanoeuvrebord;
    }

    public String getHeuredebut() {
        return heuredebut;
    }

    public void setHeuredebut(String heuredebut) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (heuredebut != null && heuredebut.compareTo("") != 0) {
                if (heuredebut.split(":").length < 3) {
                    heuredebut += ":00";
                }
                Utilitaire.testHeureValide(heuredebut);
            }
        }
        this.heuredebut = heuredebut;
    }

    public String getHeurefin() {
        return heurefin;
    }

    public void setHeurefin(String hf) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            System.out.println("hf " + hf);
            if (hf != null && hf.compareTo("") != 0) {
                if (hf.split(":").length < 3) {
                    hf += ":00";
                }
                Utilitaire.testHeureValide(hf);

                if (getDaty() != null && getDatefin() != null && Utilitaire.compareDaty(getDaty(), getDatefin()) == 0) {
                    if (getHeuredebut() != null && Utilitaire.comparerHeure(this.getHeuredebut(), hf) == -1) {
                        throw new Exception("Heure de fin invalide par rapport à l heure de debut");
                    }
                }
            }
        }
        this.heurefin = hf;
    }

    public String getIdnavire() {
        return idnavire;
    }

    public void setIdnavire(String idnavire) {
        this.idnavire = idnavire;
    }

    /*public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) {
        this.idclient = idclient;
    }*/
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    private void setDureeFromDate() throws Exception {
        if (this.getDaty() != null && this.getDatefin() != null) {
            Timestamp hdebut = Utilitaire.convertStringToTimestampHour(this.getHeuredebut(), ":");
            hdebut.setTime(this.getDaty().getTime() + hdebut.getTime());
            Timestamp hfin = Utilitaire.convertStringToTimestampHour(this.getHeurefin(), ":");
            hfin.setTime(this.getDatefin().getTime() + hfin.getTime());

            long diffEnMillies = hfin.getTime() - hdebut.getTime();
            duree = TimeUnit.MINUTES.convert(diffEnMillies, TimeUnit.MILLISECONDS);
        }
    }
    
    public void verifPrevision(Connection c) throws Exception{
        Prevision p = getPrevision(c);
        if(p.getEtat() < ConstanteEtat.getEtatValider()){
            throw new Exception("Prevision non visee");
        }
    }
    
    @Override
    public void controlerUpdate(Connection c) throws Exception {
        setDureeFromDate();
        verifPrevision(c);
    }

    public void controler(Connection c) throws Exception {
        if(this.getPrevision(c).getEtat() < ConstanteEtat.getEtatValider()) throw new Exception("Pr\u00e9vision non vis\u00e9e");
        
        setDureeFromDate();
        //PrevisionService.testerOccupationMaterielNaval(this,c);
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("OMN", "getseqoccupationMaterielNaval");
        this.setId(makePK(c));

    }

    public String getIdarrivee() {
        return idarrivee;
    }

    public void setIdarrivee(String idarrivee) {
        this.idarrivee = idarrivee;
    }

    public Date getDatefin() {
        return datefin;
    }

    public void setDatefin(Date datefin) throws Exception {
        this.datefin = datefin;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getIdprevision() {
        return idprevision;
    }

    public void setIdprevision(String idprevision) {
        this.idprevision = idprevision;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
    }

}
