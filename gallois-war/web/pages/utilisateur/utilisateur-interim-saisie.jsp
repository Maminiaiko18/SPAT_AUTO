<%-- 
    Document   : utilisateur-interim-saisie
    Created on : 7 nov. 2016, 13:55:21
    Author     : Joe
--%>

<%@page import="utilisateur.UtilisateurInterim"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UtilisateurInterim  a = new UtilisateurInterim();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));

    pi.setLien((String) session.getValue("lien"));
    
//    LogPersonnel chauf = new LogPersonnel();
//    chauf.setNomTable("log_personnel");
//    liste[1]= new Liste("chauffeur",chauf, "nom","id");
    
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_debut").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_fin").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("iduser_interim").setPageAppel("choix/utilisateurChoixLibelle.jsp");
    pi.getFormu().getChamp("iduser_a_remplacer").setPageAppel("choix/utilisateurChoixLibelle.jsp");
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("date_debut").setLibelle("D&eacute;but");
    pi.getFormu().getChamp("iduser_interim").setLibelle("Interim");
    pi.getFormu().getChamp("iduser_a_remplacer").setLibelle("Utilisateur à remplacer");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Utilisateur Interim</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="interim" id="interim" data-parsley-validate>
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="utilisateur/utilisateur-interim-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="utilisateur.UtilisateurInterim">
    </form>
</div>