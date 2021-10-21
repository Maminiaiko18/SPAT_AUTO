<%-- 
    Document   : facture-client-saisie-multiple
    Created on : 10 d�c. 2020, 11:57:14
    Author     : Sanda
--%>
<%@page import="facture.FactureFournisseurDetails"%>
<%@page import="utilisateur.Utilisateur"%>
<%@page import="affichage.Liste"%>
<%@page import="user.*"%> 
<%@page import="mg.spat.stock.BonDeLivraisonClient"%>
<%@page import="mg.spat.stock.BonDeLivraisonClientFille"%>
<%@page import="data.BonDeLivraisonData"%>
<%@page import="facture.FactureClientDetails"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try{
    UserEJB u = null;
    String idUser= "";
    u = (UserEJB) session.getValue("u");
    idUser = ""+u.getUser().getTuppleID();
    
    String autreparsley = "data-parsley-range='[8, 40]' required";
    mg.spat.stock.BonDeLivraison  bc = new mg.spat.stock.BonDeLivraison();   

    mg.spat.stock.BonDeLivraisonFille bcfille = new mg.spat.stock.BonDeLivraisonFille(); 
    bcfille.setNomTable("AS_BONDELIVRAISON_CL_PDT_FF");
    BonDeLivraisonData d = new BonDeLivraisonData();
    d.setIdfacture(request.getParameter("idfacture"));
    FactureFournisseurDetails[] data = d.findFFDetails();
    int isany=10;
    if(data.length!=0){
        isany = data.length;
    }
    PageInsertMultiple pi = new PageInsertMultiple(bc, bcfille, request, isany, u);
    pi.setLien((String) session.getValue("lien"));
    
    
    String mere=request.getParameter("idmere");
    if(mere!=null && mere.compareToIgnoreCase("")!=0)pi.getFormu().getChamp("idmere").setDefaut(mere);
    
    pi.getFormu().getChamp("idbc").setLibelle("Id facture");
    pi.getFormu().getChamp("idbc").setDefaut(request.getParameter("idfacture"));
    pi.getFormu().getChamp("idbc").setPageAppel("choix/listeFactureFournisseurChoix.jsp");
    pi.getFormu().getChamp("point").setVisible(false);
    pi.getFormu().getChamp("idbc").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("id_bc").setVisible(false);
  
    int taille = pi.getNombreLigne();
    for( int i = 0 ; i < taille ; i++ ){       
        pi.getFormufle().getChamp("pdt_"+i).setDefaut(data[i].getDesignation());
        pi.getFormufle().getChamp("quantite_"+i).setDefaut(""+data[i].getRestealivrer());
        pi.getFormufle().getChamp("iddetailsfacturefournisseur_"+i).setDefaut(""+data[i].getId());
        pi.getFormufle().getChamp("produit_"+i).setDefaut(""+data[i].getIdproduit());
    }
    
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("produit"),false); 
    
    pi.getFormufle().getChamp("iddetailsfacturefournisseur_0").setLibelle("Id Details facture");
    pi.getFormufle().getChamp("pdt_0").setLibelle("Produit");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("pdt"), "readonly");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("numbl"),false); 
    
    
    
    pi.preparerDataFormu();
       
%>
<div class="content-wrapper">
    <h1>Enregistrer Bon de livraison fournisseur</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="facture/bondelivraison-client-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.stock.BonDeLivraison">
        <input name="classefille" type="hidden" id="classefille" value="mg.spat.stock.BonDeLivraisonFille">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="numbl">
    </form>
 
</div>
<script  language="JavaScript">
    function calculerMontant(indice) {
        var quantite, pu, montant;
        quantite = parseFloat($('#quantite_' + indice).val());
//        quantite = quantite / 1000;
        pu = parseFloat($('#pu_' + indice).val());
        if (!isNaN(quantite) && !isNaN(pu)) {
            montant = quantite * pu;
            $('#montant_' + indice).val(montant.toFixed(2));
        } else {
            $('#montant_' + indice).val('');
        }
    }
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>
