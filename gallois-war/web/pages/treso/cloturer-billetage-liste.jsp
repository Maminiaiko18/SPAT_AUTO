<%-- 
    Document   : cloturer-billetage-liste
    Created on : 7 nov. 2019, 09:34:49
    Author     : john
--%>

<%@page import="mg.spat.CloturerBilletage"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    CloturerBilletage cloture = new CloturerBilletage();
    cloture.setNomTable("cloturerbilletagelib");
    String listeCrt[] = {"id", "caisse","remarque","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","daty","caisse", "solde","remarque"};
    PageRecherche pr = new PageRecherche(cloture, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.setApres("treso/cloturer-billetage-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des clotures</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/cloturer-billetage-liste.jsp" method="post" name="listecloturerbilletage" id="listecloturerbilletage">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/cloturer-billetage-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Date", "Caisse", "Solde","Remarque"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    throw e;
}%>
