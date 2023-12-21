<%-- 
    Document   : onglet-exemple
    Created on : 9 mars 2023, 11:28:01
    Author     : BICI
--%>
<%@page import="mg.spat.Avenant"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Avenant avenant = new Avenant();
    avenant.setNomTable("AVENANTLIBCPLT");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id", "tierslib", "objet", "date_signature", "debut_avenant", "fin_avenant", "duree", "unitelib", "montant", "etatlib"};
    PageRecherche pr = new PageRecherche(avenant, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("#");
    pr.setAWhere(" and idcontrat = '" + request.getParameter("id") + "' and rang != 0");
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=travaux/avenant-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] =  {"ID", "Tiers", "Objet", "Date signature", "D&eacute;but avenant", "Fin avenant", "Dur&eacute;e", "Unit&eacute;", "Montant", "Etat"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
        }
        else
            {
               %><center><h4>Aucun r&eacute;sultat</h4></center><%
        }
    %>
            

   

</div>