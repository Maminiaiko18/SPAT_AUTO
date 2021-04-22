<%-- 
    Document   : bilan-liste
    Created on : 5 déc. 2019, 11:31:01
    Author     : john
--%>

<%@page import="mg.spat.Bilan"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        Bilan billetage = new Bilan();
        //billetage.setNomTable("etatfacturepaye");
        String listeCrt[] = {"id","rubrique","typeBilan"};
        String listeInt[] = {};
        String libEntete[] = {"id","rubrique","typeBilan","montant","total"};
        PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

      /* pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");*/

        pr.setApres("bilan/bilan-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listebilan.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des bilans</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=bilan/bilan-liste.jsp" method="post" name="listebilan" id="listebilan">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            /* String lienTableau[] = {pr.getLien() + "?but=treso/billetage-fiche.jsp"};
            String colonneLien[] = {"idfacturemere"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien); */
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Rubrique","Type Bilan","Montant","Total"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>

