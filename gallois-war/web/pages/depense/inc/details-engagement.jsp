<%-- 
    Document   : listeff.jsp
    Created on : 22 févr. 2022, 15:20:49
    Author     : andri
--%>
<%@page import="mg.spat.EngagementFille"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="facture.FactureFournisseur"%>
<%
    EngagementFille j = new EngagementFille();
    j.setNomTable("engagement_fillelib");
    j.setIdmere(request.getParameter("id"));
    String libEntete[] = {"designation", "montant", "estPaye"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setAWhere("and idmere='"+request.getParameter("id")+"'");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.creerObjetPage(libEntete, null);

    pr.getTableau().setLibelleAffiche(new String[]{"Désignation", "Montant", "Est Payé"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtml();
    if (html != null) {%>

    <% out.println(html); %>
</form
<% } else {
%><center><h4>Pas de résultat</h4></center><%
    }
    %>
