<%@page import="bordereau.BordereauFF"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try{
    BordereauFF b = new BordereauFF();
    b.setNomTable("FSBBED");
    String libEntete[] = {"id", "designation", "daty", "numero", "tierslib", "projetlib", "directionlib", "typebordereaulib"};
    String listeCrt[] = {"idengagement"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(b, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setAWhere("and idengagement='"+request.getParameter("id")+"'");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.creerObjetPage(libEntete, null);
    String lienTableau[] = {pr.getLien() + "?but=ded/bordereauxFF-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    pr.getTableau().setLibelleAffiche(new String[]{"ID", "D&eacute;signation", "Date", "Num&eacute;ro", "Tiers", "Projet", "Direction", "Type"});
    String html = pr.getTableau().getHtml();
    if (html != null) {%>

    <% out.println(html); %>
</form
<% } else {
%><center><h4>Pas de r&eacute;sultat</h4></center><%
    }
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
    alert('<%=e.getMessage()%>');
    history.back();
</script>
<% }%>