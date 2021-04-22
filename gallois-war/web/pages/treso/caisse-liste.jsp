<%-- 
    Document   : caisse-liste
    Created on : 2 déc. 2019, 10:00:59
    Author     : john
--%>

<%@page import="mg.spat.Caisse"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        Caisse billetage = new Caisse();
        //billetage.setNomTable("billetagelib");
        String listeCrt[] = {"id","val","desce","numero"};
        String listeInt[] = {};
        String libEntete[] = {"id","val","desce","numero"};
        PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

      pr.getFormu().getChamp("val").setLibelle("Valeur");
        pr.getFormu().getChamp("desce").setLibelle("Description");

        pr.setApres("treso/caisse-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listecaisse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des caisses</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/caisse-liste.jsp" method="post" name="listecaisse" id="listecaisse">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/caisse-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","valeur","description","numero"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
