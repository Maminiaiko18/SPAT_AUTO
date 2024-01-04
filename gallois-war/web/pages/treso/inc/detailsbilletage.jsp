<%@page import="mg.spat.DetailsBilletage"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    DetailsBilletage details = new DetailsBilletage();
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};
    String libEntete[] = {"billet", "nombre"};
    PageRecherche pr = new PageRecherche(details, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("#");
    pr.setAWhere("and idmere = '" + request.getParameter("id") + "'");
    String[] colSomme = null;
    pr.setNpp(100);
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
        }
        else
            {
               %><center><h4>Aucune donn&eacute;e trouv&eacute;e</h4></center><%
        }
    %>
</div>
<% }catch (Exception e) {
        e.printStackTrace();
    }%>