<%-- 
    Document   : billetage-liste
    Created on : 6 nov. 2019, 14:24:39
    Author     : john
--%>

<%@page import="mg.spat.Billetage"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        Billetage billetage = new Billetage();
        billetage.setNomTable("billetagelib");
        String listeCrt[] = {"id", "caisse", "daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "caisse", "daty", "montant"};
        PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");

        pr.setApres("treso/billetage-liste.jsp");
        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des billetages</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/billetage-liste.jsp" method="post" name="listebilletage" id="listebilletage">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/billetage-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "caisse", "date", "montant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
