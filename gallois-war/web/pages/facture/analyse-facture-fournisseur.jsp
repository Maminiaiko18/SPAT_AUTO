<%@page import="facturefournisseur.FactureFournisseur"%>
<%@ page import="affichage.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="user.*" %>


<%
    try {

        FactureFournisseur lv = new FactureFournisseur();
        lv.setNomTable("facturefournisseurlib");

        String listeCrt[] = {"id","numfact","idfournisseur","iddevise","remarque","designation","resp","idfacturefournisseur","budget"};
        String listeInt[] = {"daty","dateemission","datyecheance","montantttc","montantdevise"};

        String[] pourcentage = {};
        String somDefaut[] = {"montantttc","montantdevise"};
        String colDefaut[] = {"id","numfact","idfournisseur","iddevise","remarque","designation","resp","idfacturefournisseur","budget"};

        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 0);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("facture/analyse-facture-fournisseur.jsp");
        pr.creerObjetPagePourc();

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/analyse-facture-fournisseur.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>