<%-- 
    Document   : armateur-saisie
    Created on : 22 déc. 2021, 10:26:48
    Author     : rijan
--%>

<%@page import="mg.spat.Armateur"%>
<%@page import="user.*"%> 
<%@ page import="bean.TypeObjet" %>
<%@page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Armateur  a = new Armateur();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));    

    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("contact").setLibelle("Contact");
    pi.getFormu().getChamp("adresse").setLibelle("Adresse");
    pi.getFormu().getChamp("nif").setLibelle("Nif");
    pi.getFormu().getChamp("stat").setLibelle("Stat");
    pi.getFormu().getChamp("mail").setLibelle("Email");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Enregistrer armateur</h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="starticle" id="starticle">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/armateur/armateur-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Armateur">
    </form>
</div>
