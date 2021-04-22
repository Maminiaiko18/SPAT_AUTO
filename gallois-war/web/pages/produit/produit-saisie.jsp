<%-- 
    Document   : produit-saisie
    Created on : 7 déc. 2020, 11:04:30
    Author     : ASUS
--%>
<%-- 
    Document   : as-produits-saisie
    Created on : 1 déc. 2016, 10:39:11
    Author     : Joe
--%>
<%@page import="mg.allosakafo.produits.Produits"%>
<%@page import="user.*"%> 
<%@ page import="bean.TypeObjet" %>
<%@page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Produits  a = new Produits();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));    

    pi.getFormu().getChamp("cdg").setVisible(false);
    pi.getFormu().getChamp("ccg").setVisible(false);
    pi.getFormu().getChamp("cda").setVisible(false);
    pi.getFormu().getChamp("cca").setVisible(false);
    pi.getFormu().getChamp("photo").setVisible(false);
    pi.getFormu().getChamp("calorie").setVisible(false);
    pi.getFormu().getChamp("idingredient").setVisible(false);
    pi.getFormu().getChamp("prixL").setVisible(false);
    pi.getFormu().getChamp("poidsprecuit").setVisible(false);
    pi.getFormu().getChamp("Designation").setVisible(false);
    pi.getFormu().getChamp("Poids").setVisible(false);
    pi.getFormu().getChamp("Categorieingredient").setVisible(false);
    pi.getFormu().getChamp("pa").setLibelle("Prix");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Enregistrer produit</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="produit/produit-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.allosakafo.produits.Produits">
    </form>
</div>