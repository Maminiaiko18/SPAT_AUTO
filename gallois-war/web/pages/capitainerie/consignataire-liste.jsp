<%-- 
    Document   : consignataire-liste
    Created on : 14 janv. 2021, 11:13:23
    Author     : Lenovo
--%>

<%@page import="mg.spat.Client"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        Client cli = new Client();
        cli.setNomTable("CONSIGNATAIREMAT");

        String listeCrt[] = {"cdclt", "nomclt", "adrclt", "nif", "nmsttclt", "telclt"};
        String listeInt[] = {""};
        String libEntete[] = {"cdclt", "nomclt", "adrclt", "nif", "nmsttclt", "telclt"};
        PageRecherche pr = new PageRecherche(cli, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("capitainerie/consignataire-liste.jsp");
        pr.getFormu().getChamp("cdclt").setLibelle("Id");
        pr.getFormu().getChamp("nomclt").setLibelle("Nom");
        pr.getFormu().getChamp("adrclt").setLibelle("Adresse");
        pr.getFormu().getChamp("nmsttclt").setLibelle("Stat");
        pr.getFormu().getChamp("telclt").setLibelle("Contact");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste consignataire </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/consignataire-liste.jsp" method="post" name="listepostedestinataire" id="listepostedestinataire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/consignataire-fiche.jsp"};
            String colonneLien[] = {"cdclt"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Nom", "Adresse", "nif", "Stat", "Contact"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
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
