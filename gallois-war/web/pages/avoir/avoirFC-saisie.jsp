<%-- 
    Document   : facture-client-saisie-multiple
    Created on : 10 dï¿½c. 2020, 11:57:14
    Author     : Sanda
--%>
<%@page import="utilisateur.Utilisateur"%>
<%@page import="avoir.AvoirFC"%>
<%@page import="affichage.Liste"%>
<%@page import="avoir.AvoirFCFille"%>
<%@page import="data.AvoirFCFilleData"%>
<%@page import="user.*"%> 
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
    AvoirFC  avoir = new AvoirFC();   
    AvoirFCFille avoirfille = new AvoirFCFille();
    AvoirFCFilleData d = new AvoirFCFilleData();
    d.setIdfacture(request.getParameter("idfacture"));
    d.setFCDetails();
    FactureClientDetails[] data = d.getFcdetails();
    
    PageInsertMultiple pi = new PageInsertMultiple(avoir, avoirfille, request, data.length, u);
    pi.setLien((String) session.getValue("lien"));
    
    String mere=request.getParameter("idmere");
    if(mere!=null && mere.compareToIgnoreCase("")!=0)pi.getFormu().getChamp("idmere").setDefaut(mere);
    
    pi.getFormu().getChamp("idfacture").setDefaut(request.getParameter("idfacture"));
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idfacture").setLibelle("Facture");
    pi.getFormu().getChamp("idfacture").setPageAppel("choix/listeFactureCientChoix.jsp");
     
    
    for( int i = 0 ; i < pi.getNombreLigne() ; i++ ){;
        pi.getFormufle().getChamp("iddetailfacture_"+i).setDefaut(data[i].getId());
    }
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailfacture"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idMere"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("iddetailfacture"), "choix/listeFactureCientDetailsChoix.jsp", "iddetailfacture;iddetailfacturelibelle");
    pi.getFormufle().getChamp("iddetailfacture_0").setLibelle("Id Détail Facture");
    pi.getFormufle().getChamp("Id_0").setLibelle("Id");
    pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
    
    pi.preparerDataFormu();
       
%>
<div class="content-wrapper">
    <h1>Enregistrer avoir facture client</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="avoir/avoirFC-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="avoir.AvoirFC">
        <input name="classefille" type="hidden" id="classefille" value="avoir.AvoirFCFille">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
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
