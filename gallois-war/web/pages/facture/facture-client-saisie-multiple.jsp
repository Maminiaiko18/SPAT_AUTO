<%-- 
    Document   : facture-client-saisie-multiple
    Created on : 2 févr. 2021, 10:48:25
    Author     : Sanda
--%>
<%@page import="user.UserEJB"%> 
<%@ page import="bean.TypeObjet" %>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="factureclient.FactureClient"%>
<%@page import="factureclient.FactureClientDetail"%>
<%
    try{
    UserEJB u = null;
    String idUser= "";
    u = (UserEJB) session.getValue("u");
    idUser = ""+u.getUser().getTuppleID();

    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureClient  a = new FactureClient();   
    FactureClientDetail details = new FactureClientDetail();
    
    PageInsertMultiple pi = new PageInsertMultiple(a, details, request, 10, u);
    pi.setLien((String) session.getValue("lien"));
    
    String mere=request.getParameter("idFacture");
    if(mere!=null && mere.compareToIgnoreCase("")!=0) pi.getFormu().getChamp("idFacture").setDefaut(mere);
     
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("tiers").setPageAppel("choix/clientCategorieChoix.jsp");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("remarque").setAutre("readonly");     

    pi.getFormu().getChamp("Idjournal").setVisible(false);
    pi.getFormu().getChamp("antenne").setVisible(false);
    pi.getFormu().getChamp("compte").setVisible(false);  
    pi.getFormu().getChamp("montant").setVisible(false);
    pi.getFormu().getChamp("tva").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("montanttva").setVisible(false);
    pi.getFormu().getChamp("devise").setVisible(false);
    pi.getFormu().getChamp("coursdevise").setVisible(false);
    pi.getFormu().getChamp("entite").setVisible(false);

    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet type = new TypeObjet();
    type.setNomTable("type_facture_client");
    liste[0] = new Liste("typee", type, "val", "id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("remarque").setLibelle("R&eacute;f&eacute;rence facture");
    pi.getFormu().getChamp("compte").setLibelle("Medecin");
    pi.getFormu().getChamp("typee").setLibelle("Type FC");
    pi.getFormu().getChamp("tiers").setLibelle("Client");
    
    for( int i = 0 ; i < pi.getNombreLigne() ; i++ ){
        pi.getFormufle().getChamp("quantite_"+i).setAutre( " onchange='calculeRem(this)' " );
        pi.getFormufle().getChamp("montant_"+i).setAutre( " onchange='calculeRem(this)' " );
        pi.getFormufle().getChamp("montantT_"+i).setAutre( " readonly " );
    }
    pi.getFormufle().getChamp("designation_0").setLibelle("Designation");     
//    pi.getFormufle().getChamp("medicament_0").setLibelle("Medicament");     
    pi.getFormufle().getChamp("montant_0").setLibelle("Prix Unitaire");     
    pi.getFormufle().getChamp("montantremise_0").setLibelle("Montant Remise");     
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantité");     
    pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
    pi.getFormufle().getChamp("montantT_0").setLibelle("Montant");
        
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idacte"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idFacture"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("compteDebit"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("analDebit"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("medicament"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("montantremise"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("compteCredit"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("analCredit"),false);
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("quantite"), " onchange='calculMontant(this)' " );
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montant"), " onchange='calculMontant(this)' ");

    pi.preparerDataFormu();
       
%>
<div class="content-wrapper">
    <h1>Enregistrer facture</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="facture/facture-client-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="factureclient.FactureClient">
        <input name="classefille" type="hidden" id="classefille" value="factureclient.FactureClientDetail">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="idfacture">

    </form>
<script>          
    function calculMontant(elem){ 
        let i = elem.id.split("_")[1];
        document.getElementById("montantt_"+i).value = document.getElementById("quantite_"+i).value * document.getElementById("montant_"+i).value ;
    }                     
</script>

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

