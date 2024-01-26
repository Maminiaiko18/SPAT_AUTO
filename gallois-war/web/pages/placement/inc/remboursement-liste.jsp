<%-- 
    Document   : onglet-exemple
    Created on : 9 mars 2023, 11:28:01
    Author     : BICI
--%>

<%@page import="mg.spat.RemboursementPlacement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    RemboursementPlacement t = new RemboursementPlacement();
    t.setNomTable("REMBOURSEMENTPLACEMENTLIB");
    String listeCrt[] = {"idPlacement"};
    String listeInt[] = {};
    String libEntete[] = {"id","caisselib", "entite", "banque","montantplace","interet","ircm","interetbrut"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("placement/inc/remboursement-liste.jsp");
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=placement/remboursement-placement-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        String urlLienAffiche[] = {"id"};
        pr.getTableau().setUrlLien(colonneLien);
        pr.getTableau().setUrlLienAffiche(urlLienAffiche);
        String libEnteteAffiche[] =  {"id","caisse", "entite", "banque","montant plac&eacute;","interet","ircm","interet brut"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        //JournalCaisse[] liste=(JournalCaisse[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
        }
        else
            {
               %><center><h4>Aucune donnee trouve</h4></center><%
        }
    %>
</div>