<%@page import="mg.spat.DemandeAchatFille"%>
<%@page import="affichage.PageRecherche"%>
<%
    DemandeAchatFille j = new DemandeAchatFille();
    j.setNomTable("dem_achat_fillelib");
    j.setIdmere(request.getParameter("id"));
    String libEntete[] = {"id", "designation", "pu","qte","unitelib"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setAWhere("and idmere='"+request.getParameter("id")+"'");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setOrdre(" order by designation asc");

    pr.creerObjetPage(libEntete, null);

    pr.getTableau().setLibelleAffiche(new String[]{"ID", "D&eacute;signation", "PU","Qantit&eacute;","Unit&eacute;"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtml();
    if (html != null) {%>

    <% out.println(html); %>
</form
<% } else {
%><center><h4>Pas de résultat</h4></center><%
    }
    %>
