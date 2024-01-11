<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.Contrat"%>
<%
    try{
        Contrat contrat = new Contrat();
        contrat.setNomTable("CONTRATLIBCPLT");
        String listeCrt[] = {"id", "codeprojetlib", "codeetablissementlib", "nom", "debut_contrat", "fin_avenant"};
        String listeInt[] = {"debut_contrat", "fin_avenant"};
        String libEntete[] = {"id", "nom", "objet", "date_signature", "debut_contrat", "fin_avenant", "duree", "valunite", "lclib", "annee", "codeprojetlib", "codeetablissementlib", "montant", "montantpaye","numero"};
        PageRecherche pr = new PageRecherche(contrat, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by debut_contrat desc");
        pr.setApres("travaux/contra-liste-nouveau.jsp");
        pr.getFormu().getChamp("debut_contrat1").setLibelle("D&eacute;but contrat min");
        pr.getFormu().getChamp("debut_contrat2").setLibelle("D&eacute;but contrat max");
        pr.getFormu().getChamp("fin_avenant1").setLibelle("Fin contrat min");
        pr.getFormu().getChamp("fin_avenant2").setLibelle("Fin contrat max");
        pr.getFormu().getChamp("codeprojetlib").setLibelle("Projet");
        pr.getFormu().getChamp("codeetablissementlib").setLibelle("Code etablissement");
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/contrat-liste-nouveau.jsp" method="post" name="travaux" id="travaux">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux/contrat-fiche-nouveau.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Tiers", "objet", "date signature", "d&eacute;but contrat", "fin contrat", "dur&eacute;e", "unit&eacute;", "budget", "ann&eacute;e", "projet", "code etablissement", "montant", "montant pay&eacute;","Numero"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%}
    catch(Exception e){
        e.printStackTrace();
    }
%>