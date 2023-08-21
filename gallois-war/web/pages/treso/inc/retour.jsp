<%-- 
    Document   : onglet-exemple
    Created on : 9 mars 2023, 11:28:01
    Author     : BICI
--%>
<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="test.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    JournalCaisse t = new JournalCaisse();
    String id = request.getParameter("id");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id", "dateeffet" , "libelle", "credit"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("treso/inc/retour.jsp");
     pr.setAWhere(" and retour='" + id + "'");
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String urlLienAffiche[] = {"id"};
        pr.getTableau().setUrlLien(colonneLien);
        pr.getTableau().setUrlLienAffiche(urlLienAffiche);
        String libEnteteAffiche[] =  {"id", "dateeffet" , "libelle", "credit"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());%>
      <%  }
        else
            {
               %><center><h4>Aucune donnée trouvé</h4></center><%
        }%>
        
</div>