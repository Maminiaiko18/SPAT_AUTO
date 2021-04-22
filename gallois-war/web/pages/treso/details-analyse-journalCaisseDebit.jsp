<%-- 
    Document   : details-analyse-journalCaisseDebit
    Created on : 6 déc. 2019, 09:39:34
    Author     : john
--%>

<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>

<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        JournalCaisse mvt = new JournalCaisse();
        mvt.setNomTable("journalcaisselib");
        String listeCrt[] = {"id","folio","caisse","numPiece","libelle","remarque","dateSaisie"};
        String libEntete[] = {"id","folio","caisse","numPiece","libelle","remarque","dateSaisie","debit","credit"};
        String listeInt[] = {"dateSaisie"};

        PageRecherche pr = new PageRecherche(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        /*pr.getFormu().getChamp("nmfact").setLibelle("Numero facture");
        pr.getFormu().getChamp("categorie_facture").setLibelle("Categorie facture");
        pr.getFormu().getChamp("categorie_client").setLibelle("Categorie client");
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");

        pr.getFormu().getChamp("numcompte").setLibelle("Numero de compte");*/
        pr.setApres("treso/details-analyse-journalCaisseDebit.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Détails analyse journal caisse debit </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/details-analyse-journalCaisseDebit.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/details-analyse-journalCaisseDebit.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
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

