

<%@page import="lignecredit.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8;" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    AvenantBudget t = new AvenantBudget();
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","source","montant"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" and idLigneCredit='"+request.getParameter("id")+"'");
    }
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] = {"id","Source","Montant"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        String lienTableau[] = {pr.getLien() + "?but=ligneCredit/reamenagement-fiche.jsp"};
        String colonneLien[] = {"source"};
        String[] urlLienMultiple = {"source"};
        String[] urlLienAffiche = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);           
        pr.getTableau().setUrlLienAffiche(urlLienAffiche);
        pr.getTableau().setUrlLien(urlLienMultiple);
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
         }else
         {
               %><div style="text-align: center;"><h4>Aucune donnée trouvée</h4></div><%
         }

        
    %>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>

