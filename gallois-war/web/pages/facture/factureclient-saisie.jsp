<%-- 
    Document   : facture-client-saisie-multiple
    Created on : 10 dï¿½c. 2020, 11:57:14
    Author     : Sanda
--%>
<%@page import="utilisateur.Utilisateur"%>
<%@page import="affichage.Liste"%>
<%@page import="user.*"%> 
<%@page import="facture.FactureClient"%>
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
    FactureClient  fc = new FactureClient();   
    FactureClientDetails fcfille = new FactureClientDetails();
    fcfille.setNomTable("facture_client_fille_plus");
    
    PageInsertMultiple pi = new PageInsertMultiple(fc, fcfille, request, 10, u);
    pi.setLien((String) session.getValue("lien"));
    
    
    String mere=request.getParameter("idmere");
    if(mere!=null && mere.compareToIgnoreCase("")!=0)pi.getFormu().getChamp("idmere").setDefaut(mere);
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("date_echeance").setLibelle("Date echeance");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("tiers").setPageAppel("choix/clientCategorieChoix.jsp");
    pi.getFormu().getChamp("type").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setAutre("readonly");
    
    
    affichage.Liste[] listed = new affichage.Liste[1];
        TypeObjet o = new TypeObjet();
        o.setNomTable("devise");
        listed[0] = new Liste("devise", o, "VAL", "id");
    pi.getFormufle().changerEnChamp(listed);
    
    int taille = pi.getNombreLigne();
    for( int i = 0 ; i < taille ; i++ ){       
        pi.getFormufle().getChamp("quantite_"+i).setAutre("onblur='calculerMontant("+i+")'");
        pi.getFormufle().getChamp("pu_"+i).setAutre("onblur='calculerMontant("+i+")'");
        pi.getFormufle().getChamp("montant_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("devise_"+i).setDefaut(Constante.deviseAr);
        pi.getFormufle().getChamp("idactivite_"+i).setAutre("readonly");
//        pi.getFormufle().getChamp("idactivite_"+i).setPageAppel("choix/listeActiviteChoix.jsp");
    }
    
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("taux"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"),false);
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("tva"), "20");
    pi.getFormufle().getChamp("devise_0").setLibelle("Devise");
    pi.getFormufle().getChamp("designation_0").setLibelle("Designation");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("pu_0").setLibelle("Pu");
    pi.getFormufle().getChamp("compte_0").setLibelle("Compte");
    pi.getFormufle().getChamp("idproduit_0").setLibelle("Produit");
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("tva_0").setLibelle("tva");
    pi.getFormufle().getChamp("datefact_0").setLibelle("Date fact");
    pi.getFormufle().getChamp("rubrique_0").setLibelle("Rubrique");
    
   
  
    pi.getFormufle().getChamp("idactivite_0").setLibelle("Activité");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idactivite"), "choix/listeActiviteChoix.jsp", "idactivite;idactivitelibelle;quantite;pu;tva;datefact;designation");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("rubrique"), "choix/listeRubriqueChoix.jsp", "rubrique;rubriquelibelle;designation;tva;pu");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("rubrique"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("dateFact"), "readonly");
    
    
    
    pi.preparerDataFormu();
       
%>
<div class="content-wrapper">
    <h1>Enregistrer facture client</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="facture/factureclient-fiche-vaovao.jsp">
        <input name="classe" type="hidden" id="classe" value="facture.FactureClient">
        <input name="classefille" type="hidden" id="classefille" value="facture.FactureClientDetails">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="idmere">
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
