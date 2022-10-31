<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.Client"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        Client base = new Client();
        base.setNomTable("client");

        String listeCrt[] = {"cdclt", "nomclt", "adrclt", "nmsttclt", "telclt", "faxclt", "nmcin","nif","rc"};
        String listeInt[] = {};
        String libEntete[] = {"cdclt", "nomclt", "adrclt", "nmsttclt", "telclt", "faxclt", "nmcin", "nif", "rc"};

        PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("cdclt").setLibelle("Id");
        pr.getFormu().getChamp("nomclt").setLibelle("Nom");
        pr.getFormu().getChamp("adrclt").setLibelle("Adresse");
        pr.getFormu().getChamp("nmsttclt").setLibelle("STAT");
        pr.getFormu().getChamp("telclt").setLibelle("Telphone");
        pr.getFormu().getChamp("faxclt").setLibelle("FAX");
        pr.getFormu().getChamp("nmcin").setLibelle("CIN");
        pr.getFormu().getChamp("nif").setLibelle("NIF");
        pr.getFormu().getChamp("rc").setLibelle("RC");
        
        pr.setApres("facture/client-liste.jsp");
        
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.liste.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des clients</h1>
    </section>
    <section class="content">
        <form action='<%=pr.getLien() + "?but=facture/client-liste.jsp" %>' method="post" name="liste" id="liste">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
               <%
            String lienTableau[] = {pr.getLien() + "?but=facture/client-fiche.jsp"};
            String colonneLien[] = {"cdclt"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String libelleAffiche[] = {"Id", "Nom", "Adresse", "STAT", "Telephone",  "Faxe", "CIN", "NIF", "RC"};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

