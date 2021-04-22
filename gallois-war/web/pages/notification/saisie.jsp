<%-- 
    Document   : saisie
    Created on : 25 nov. 2016, 12:06:28
    Author     : Jetta
--%>

<%@page import="mg.cnaps.notification.NotificationMessage"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    NotificationMessage art = new NotificationMessage();
    UserEJB u = (user.UserEJB) session.getValue("u");
    PageInsert pi = new PageInsert(art, request, (user.UserEJB) session.getValue("u"));

    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("iduser_recevant").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("lien").setVisible(false);
    pi.getFormu().getChamp("idobjet").setLibelle("Identifiant de l'objet");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("service").setPageAppel("choixMultiple/service.jsp");
    pi.getFormu().getChamp("direction").setPageAppel("choixMultiple/direction.jsp");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("direction").setLibelle("Direction");
    pi.getFormu().getChamp("service").setLibelle("Service");
    pi.getFormu().getChamp("destinataire").setPageAppel("choixMultiple/logPersonnelChoixMultiple.jsp");
    pi.getFormu().getChamp("destinataire").setLibelle("Destinataire");
    pi.getFormu().getChamp("message").setType("textarea");
    pi.getFormu().getChamp("iduser").setVisible(false);
    pi.getFormu().getChamp("priorite").setVisible(false);
    pi.getFormu().getChamp("classee").setVisible(false);
    pi.getFormu().getChamp("prestation").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Notification </h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="diplome" id="diplome"  data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="notification/notification-liste.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.notification.NotificationMessage">
    </form>
</div>


