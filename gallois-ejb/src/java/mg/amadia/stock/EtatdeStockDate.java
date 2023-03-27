package mg.amadia.stock;

import affichage.PageRecherche;
import affichage.PageRechercheGroupe;
import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class EtatdeStockDate extends ClassMAPTable {

    /*
    vue: somme ny debit sy credit ao amin'ny table mouvement de caisse
    rehefa any amin'ny affichage dia mbola miampy ny montant ny dernier report amin'ny caisse tsirairay (possible date samihafa)
     */
    private Date daty;
    private String ingredients, unite, point, idCategorieIngredient, idfournisseur, idingredient, fournisseur, idUnite;
    private double pu, pudonation, pugros, montant, montantbesoin, montantStock;
    private double report, entree, sortie, reste, besoin, aacheter, reportSuiv;
    private String idmagasin, magasin, typemagasin;
    double pump, dernierprix;
    private int rangsitcptcrt,placesitcptcrt;

    public double getAacheter() {
        return aacheter;
    }

    public void setAacheter(double aacheter) {
        this.aacheter = aacheter;
    }

    public int getRangsitcptcrt() {
        return rangsitcptcrt;
    }

    public void setRangsitcptcrt(int rangsitcptcrt) {
        this.rangsitcptcrt = rangsitcptcrt;
    }

    public int getPlacesitcptcrt() {
        return placesitcptcrt;
    }

    public void setPlacesitcptcrt(int placesitcptcrt) {
        this.placesitcptcrt = placesitcptcrt;
    }

    public double getPump() {
        return pump;
    }

    public void setPump(double pump) {
        this.pump = pump;
    }

    public double getDernierprix() {
        return dernierprix;
    }

    public void setDernierprix(double dernierprix) {
        this.dernierprix = dernierprix;
    }

    public String getIdmagasin() {
        return idmagasin;
    }

    public void setIdmagasin(String idmagasin) {
        this.idmagasin = idmagasin;
    }

    public double getReportSuiv() {
        return reportSuiv;
    }

    public void setReportSuiv(double reportSuiv) {
        this.reportSuiv = reportSuiv;
    }

    public double getMontantStock() {
        return montantStock;
    }

    public void setMontantStock(double montantStock) {
        this.montantStock = montantStock;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public String getValColLibelle() {
        return ingredients + ";" + reste + ";" + pu + ";" + pugros + ";" + pudonation + ";" + typemagasin + ";" + unite + ";" + idmagasin + ";" + magasin;
        //return ingredients + ";" + pu + ";" + idUnite + ";" + idmagasin;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public String getIdingredient() {
        return idingredient;
    }

    public void setIdingredient(String idingredient) {
        this.idingredient = idingredient;
    }

    public String getIdfournisseur() {
        return idfournisseur;
    }

    public void setIdfournisseur(String idfournisseur) {
        this.idfournisseur = idfournisseur;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getPugros() {
        return pugros;
    }

    public void setPugros(double pugros) {
        this.pugros = pugros;
    }

    public double getPudonation() {
        return pudonation;
    }

    public void setPudonation(double pudonation) {
        this.pudonation = pudonation;
    }

    public double getMontant() {
        return this.montant;
    }

    public double getMontantbesoin() {
        return 0;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdCategorieIngredient() {
        return idCategorieIngredient;
    }

    public void setIdCategorieIngredient(String idCategorieIngredient) {
        this.idCategorieIngredient = idCategorieIngredient;
    }

    public double getBesoin() {
        return besoin;
    }

    public void setBesoin(double besoin) {
        this.besoin = besoin;
    }

    public EtatdeStockDate() {
        this.setNomTable("as_etatstock1");
    }

    public EtatdeStockDate(double report, double entree, double sortie, double reste) {
        this.setNomTable("as_etatstock1");
        setReport(report);
        setEntree(entree);
        setSortie(sortie);
        setReste(reste);
    }

    public EtatdeStockDate(Date _date, String _ingredients, String _unite, double _report, double _entree, double _sortie) {
        this.setNomTable("as_etatstock1");
        this.setDaty(_date);
        this.setIngredients(_ingredients);
        this.setUnite(_unite);
        this.setEntree(_entree);
        this.setReport(_report);
        this.setSortie(_sortie);
        //this.calculerDisponible();
    }

    @Override
    public String getTuppleID() {
        return null;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public double getReport() {
        return report;
    }

    public void setReport(double report) {
        this.report = report;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public double getReste() {
        return this.getReport() - this.getSortie() + this.getEntree();
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public double calculerDisponible() {

        if (this.getReport() == this.getEntree()) {
            return (-this.getSortie() + this.getEntree());
        } else {
            double ret = this.getReport() - this.getSortie() + this.getEntree();
            return ret;
        }
    }

   

    /**
     * @return the point
     */
    public String getPoint() {
        return point;
    }

    /**
     * @param point the point to set
     */
    public void setPoint(String point) {
        this.point = point;
    }

    public static EtatdeStockDate[] caculEtatStock(String ingr,String categorie,String idIngredient, Connection c,String req, String colonne , String valorder) throws Exception {
         EtatdeStockDate[] ret = null; 
           boolean newCon = false;
           try{
             if(c==null) {
                c = new UtilDB().GetConn();
                newCon=true;
            }
             if(ingr!=null&&ingr.compareToIgnoreCase("")!=0) req+=" and upper(inv.idingredient) like upper('%"+ingr+"%')";
             if(categorie!=null&&categorie.compareToIgnoreCase("")!=0) req+=" and (upper(inv.idcategorieIngredient) like upper('%"+categorie+"%') or inv.idcatIng='"+categorie+"')";
             if(idIngredient!=null&&idIngredient.compareToIgnoreCase("")!=0) req+=" and inv.IDING like '%"+idIngredient+"%'";
             if(req.contains("besoinrecette")==true)req+=" order by facmax.nom asc";
             if(colonne!=null && valorder!=null && valorder.compareToIgnoreCase("-")!=0){
                   req="Select * from ("+req+") order by "+colonne+" "+valorder;
               }
             EtatdeStockDate stock = new EtatdeStockDate();
             stock.setNomTable("AS_ETATSTOCKVIDE");
            ret = (EtatdeStockDate[]) CGenUtil.rechercher(stock, req, c);
       }
      catch(Exception e)
        {
            e.printStackTrace();
            throw e;
        }
        finally
        {
            if(newCon && c!=null)
            {
                c.close();
            }
        }
        return ret;
       }

    public static mg.amadia.stock.EtatdeStockDate[] calculEtatCaisse(String datySup, String ingr, String idIngredient, Connection c, String colonne, String valorder, String datyInf) throws Exception {
        EtatdeStockDate[] etatCaisse = calculEtatCaisseAncien(datySup, ingr, idIngredient, c, colonne, valorder, datyInf);
        EtatdeStockDate[] listeSolde = getSolde(Utilitaire.ajoutJourDateString(Utilitaire.stringDate(datySup), -1), ingr, idIngredient, c, colonne, valorder, datyInf);
        //HashMap solde = new HashMap();
        //for(int j=0;j<listeSolde.length;j++){
          //  solde.put(listeSolde[j].getIngredients(),listeSolde[j].getReste());
        //}
        for(int i=0;i<etatCaisse.length;i++){
            String[]filtre={"ingredients"};
            String[]valFiltre={etatCaisse[i].getIngredients()};
            ClassMAPTable[]etatReste=AdminGen.find(listeSolde,filtre, valFiltre);
            double reste=0;
            if(etatReste!=null)reste=((EtatdeStockDate)etatReste[0]).getReste();
            etatCaisse[i].setReste(reste);
            //etatCaisse[i].setReste((double)solde.get(etatCaisse[i].getIngredients()));
        }
        return etatCaisse;
    }
    public static mg.amadia.stock.EtatdeStockDate[] calculEtatCaisseAncien(String datySup, String ingr, String idIngredient, Connection c, String colonne, String valorder, String datyInf) throws Exception {
        String req = "select inv.idcategorieIngredient, inv.daty,inv.unite, nvl(mvt.entree,0) as entree,nvl(mvt.sortie,0) as sortie, (inv.QUANTITER-nvl(mvt.sortie,0)+nvl(mvt.entree,0)) as reste,inv.idingredient as ingredients,inv.quantiter as report "
                + ",nvl((select inv3.quantiter from reportdetailscaisse inv3 where INV3.DATY='" + datySup + "' and INV3.ETAT>=11 and INV3.IDING=inv.iding ),0) as reportSuiv"
                + " from reportdetailscaisse inv,(select sum(mvt.entree) as entree,sum(mvt.sortie) as sortie,mvt.idingredients,mvt.unite, mvt.ingredients"
                + " from mvtcaissedetailslib mvt  where "
                + "mvt.daty>(select max(inv.daty) from reportdetailscaisse inv where inv.iding=mvt.idingredients and inv.daty<'" + datySup + "' ) and mvt.daty<='" + datySup + "'"
                + " and mvt.daty>='"+datyInf+"' group by mvt.idingredients,mvt.unite, mvt.ingredients) mvt "
                + "  where inv.daty=(select max(inv2.daty) "
                + " from  reportdetailscaisse inv2 where inv2.IDING=inv.idIng and inv2.daty<'" + datySup + "')"
                + " and inv.IDING=mvt.IDINGREDIENTS(+)";
            //  System.out.println("**********************REQQQQQQQQQQQQ**************"+req);
        return caculEtatStock(ingr, null, idIngredient, c, req, colonne, valorder);
    }

    public static mg.amadia.stock.EtatdeStockDate[] getSolde(String datySup, String ingr, String idIngredient, Connection c, String colonne, String valorder, String datyInf) throws Exception {
        String req = "select inv.idingredient as ingredients,(inv.QUANTITER-nvl(mvt.sortie,0)+nvl(mvt.entree,0)) as reste "
                + " from reportdetailscaisse inv,(select sum(mvt.entree) as entree,sum(mvt.sortie) as sortie,mvt.idingredients,mvt.unite, mvt.ingredients"
                + " from mvtcaissedetailslib mvt  where "
                + "mvt.daty>(select max(inv.daty) from reportdetailscaisse inv where inv.iding=mvt.idingredients and inv.daty<'" + datyInf + "' ) and mvt.daty<='" + datySup + "'"
                + " group by mvt.idingredients,mvt.unite, mvt.ingredients) mvt "
                + "  where inv.daty=(select max(inv2.daty) "
                + " from  reportdetailscaisse inv2 where inv2.IDING=inv.idIng and inv2.daty<'" + datyInf + "')"
                + " and inv.IDING=mvt.IDINGREDIENTS(+)";
            //  System.out.println("************************************"+req);
        return caculEtatStock(ingr, null, idIngredient, c, req, colonne, valorder);
    }

    private double pumagasin;

    public String getMagasin() {
        return magasin;
    }

    public void setMagasin(String magasin) {
        this.magasin = magasin;
    }

    public String getTypemagasin() {
        return typemagasin;
    }

    public void setTypemagasin(String typemagasin) {
        this.typemagasin = typemagasin;
    }

    public double getPumagasin() {
        return pumagasin;
    }

    public void setPumagasin(double pumagasin) {
        this.pumagasin = pumagasin;
    }
    private String iding;

    public String getIding() {
        return iding;
    }

    public void setIding(String iding) {
        this.iding = iding;
    }
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdUnite() {
        return idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

}
