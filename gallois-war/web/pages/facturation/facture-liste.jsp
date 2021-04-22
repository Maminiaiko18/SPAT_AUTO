<%-- 
    Document   : facture-liste
    Created on : 8 nov. 2019, 15:48:14
    Author     : john
--%>

<%@page import="mg.spat.EtatFacturePaye"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        EtatFacturePaye billetage = new EtatFacturePaye();
        billetage.setNomTable("etatfacturepaye");
        String listeCrt[] = {"idfacturemere", "idclient","idscatservice","daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"idfacturemere", "idclient", "idfactureen","idscatservice","avoir", "paye", "idtva","daty","montantapayer", "idcourschange"};
        PageRecherche pr = new PageRecherche(billetage, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

      /* pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");*/

        pr.setApres("facturation/facture-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des factures</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/facturation-liste.jsp" method="post" name="listebilletage" id="listebilletage">
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
            String libEnteteAffiche[] = {"idfacturemere", "idclient", "idfactureen","idscatservice","avoir", "paye", "idtva","daty","montantapayer", "idcourschange"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
