<%@page import="facture.PaiementFacture"%>
<%@page import="user.UserEJB"%> 
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try{
    UserEJB u = null;
    String idUser= "";
    u = (UserEJB) session.getValue("u");
    idUser = ""+u.getUser().getTuppleID();

    String autreparsley = "data-parsley-range='[8, 40]' required";
    PaiementFacture  a = new PaiementFacture();   
    PaiementFacture details = new PaiementFacture();
    
    PageInsertMultiple pi = new PageInsertMultiple(a, details, request, 10, u);
    pi.setLien((String) session.getValue("lien"));

    String idmvt = request.getParameter("idmvt");
    String tiers = request.getParameter("tiers");
    
    String[] col={"tiers"};
    String[] val={tiers};
    
    for( int i = 0 ; i < pi.getNombreLigne() ; i++ ){
        pi.getFormufle().getChamp("idMvt_"+i).setAutre( " readonly " );
        pi.getFormufle().getChamp("idMvt_"+i).setDefaut(idmvt);
        pi.getFormufle().getChamp("idFact_"+i).setPageAppelAvecFiltre("choix/listeFactureClientViseeChoix.jsp", "idFact_"+i+";idFactlibelle_"+i, col, val);
        pi.getFormufle().getChamp("idFact_"+i).setAutre("readonly");
    }
    pi.getFormufle().getChamp("idMvt_0").setLibelle("Mouvement");     
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");     
    pi.getFormufle().getChamp("idFact_0").setLibelle("Facture"); 
        
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 

    pi.preparerDataFormu();
       
%>
<div class="content-wrapper">
    <h1>Enregistrer Paiement Facture</h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insertPaiementFacture">
        <input name="bute" type="hidden" id="bute" value="treso/paiementfacture-saisie-multiple.jsp&idmvt=<%=idmvt%>&tiers=<%=tiers%>">
        <input name="classe" type="hidden" id="classe" value="facture.PaiementFacture">
        <input name="classefille" type="hidden" id="classefille" value="facture.PaiementFacture">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">

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

