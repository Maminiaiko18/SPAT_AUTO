<%@page import="facturefournisseur.Detailsffbonlivraison"%>
<%@page import="facturefournisseur.DetailsFactureFournisseur"%>
<%@page import="avoir.AvoirFFFille"%>
<%@page import="avoir.AvoirFF"%>
<%@page import="utilisateur.Utilisateur"%>
<%@page import="affichage.Liste"%>
<%@page import="data.AvoirFFFilleData"%>
<%@page import="user.*"%> 
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try {
        UserEJB u = null;
        String idUser = "";
        u = (UserEJB) session.getValue("u");
        idUser = "" + u.getUser().getTuppleID();

        String autreparsley = "data-parsley-range='[8, 40]' required";
        AvoirFF avoir = new AvoirFF();
        avoir.setNomTable("AvoirFF");
        AvoirFFFille avoirfille = new AvoirFFFille();
        avoirfille.setNomTable("avoirFFfille_plus");
        AvoirFFFilleData d = new AvoirFFFilleData();
        d.setIdfacture(request.getParameter("idfacture"));
        d.findFFDetails();
        facture.FactureFournisseurDetails[] data = d.getFfdetails();
        int nbLigneFille = 10;
        //if(data.length > 0)
        //    nbLigneFille = data.length;
        PageInsertMultiple pi = new PageInsertMultiple(avoir, avoirfille, request, nbLigneFille, u);
        pi.setLien((String) session.getValue("lien"));

        String mere = request.getParameter("idmere");
        if (mere != null && mere.compareToIgnoreCase("") != 0) {
            pi.getFormu().getChamp("idmere").setDefaut(mere);
        }

        pi.getFormu().getChamp("idfacture").setDefaut(request.getParameter("idfacture"));
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idfacture").setLibelle("Facture");
        pi.getFormu().getChamp("idfacture").setPageAppel("choix/listeFactureFournisseurChoix.jsp");
        pi.getFormu().getChamp("idfacture").setAutre("readonly");

        
        
        if (data.length > 0) {
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("montantdf"), "readonly");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("designation"), "readonly");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("devise"), "readonly");
            
            for (int i = 0; i < data.length; i++) {;
                pi.getFormufle().getChamp("iddetailfacture_" + i).setDefaut(data[i].getId());
                pi.getFormufle().getChamp("montantdf_" + i).setDefaut("" + data[i].getMontantTTC());
                pi.getFormufle().getChamp("devise_"+i).setDefaut(data[i].getDevise());
                pi.getFormufle().getChamp("designation_" + i).setDefaut(data[i].getDesignation());
                pi.getFormufle().getChamp("remise_" + i).setDefaut("100");
            }
        }

        affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailfacture"), "readonly");

        affichage.Champ.setAutre(pi.getFormufle().getChampFille("idMere"), "readonly");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");

        pi.getFormufle().getChamp("montantdf_0").setLibelle("Montant detail facture");
        pi.getFormufle().getChamp("devise_0").setLibelle("Devise");
        pi.getFormufle().getChamp("designation_0").setLibelle("Designation");

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);

        pi.getFormu().getChamp("designation").setLibelle("Note explicative");
        pi.getFormu().getChamp("motif").setLibelle("Motif");
        pi.getFormu().getChamp("categorie").setLibelle("Catégorie");
        pi.getFormu().getChamp("code").setVisible(false);

        affichage.Liste[] liste = new affichage.Liste[3];
        TypeObjet categorie = new TypeObjet();
        categorie.setNomTable("categorieAvoirFC");

        TypeObjet motif = new TypeObjet();
        motif.setNomTable("motifAvoirFC");
        if (request.getParameter("type") != null) {
            motif.setDesce(request.getParameter("type"));
        }

        liste[0] = new Liste("categorie", categorie, "val", "id");
        liste[1] = new Liste("motif", motif, "val", "id");

        /*TypeObjet typeAv = new TypeObjet();
    typeAv.setNomTable("typeAvoirFF");
    liste[2] = new Liste("type", typeAv, "val", "id");*/
        String[] affiches = {"Interne", "Externe"};
        String[] valeurs = {"1", "2"};
        liste[2] = new Liste("type");
        liste[2].ajouterValeur(valeurs, affiches);

        if (request.getParameter("type") != null) {
            liste[2].setDefaut(request.getParameter("type"));
        }

        liste[2].setColValeur("id");
        liste[2].setColAffiche("val");
        liste[2].setDeroulanteDependante(liste[1], "desce", "onblur");
        liste[2].setDeroulanteDependante(liste[0], "type", "onclick");

        pi.getFormu().changerEnChamp(liste);

//    affichage.Champ[] listeFille = new affichage.Champ[1];
//    TypeObjet devise = new TypeObjet();
//    devise.setNomTable("devise");
//    listeFille[0] = new Liste("devise",devise, "val", "id");
//    pi.getFormufle().changerEnChamp(listeFille);
//    
        //affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("iddetailfacture"), "choix/listeFactureFournisseurDetailsChoix.jsp", "iddetailfacture;iddetailfacturelibelle");
        for (int i = 0; i < pi.getNombreLigne(); i++) {;
            pi.getFormufle().getChamp("iddetailfacture_" + i).setPageAppel("choix/listeFactureFournisseurDetails.jsp", "iddetailfacture_"+i+";iddetailfacturelibelle_"+i+";designation_"+i+";devise_"+i);            
        }
        
        pi.getFormufle().getChamp("iddetailfacture_0").setLibelle("Id Détail Facture");
        pi.getFormufle().getChamp("idmere_0").setLibelle("Mere");
        pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
        pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
        pi.getFormufle().getChamp("remise_0").setLibelle("Remise %");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailfacture"), "readonly");

        String[] ordre = {"id", "daty", "idfacture", "etat", "designation", "code", "type", "categorie", "motif"};
        pi.getFormu().setOrdre(ordre);
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Enregistrer avoir facture fournisseur</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="avoir/avoirFF-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="avoir.AvoirFF">
        <input name="classefille" type="hidden" id="classefille" value="avoir.AvoirFFFille">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=nbLigneFille%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="idmere">
    </form>

</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
</script>
<% }%>
