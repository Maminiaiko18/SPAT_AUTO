<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.treso.*" %>
<%@ page import="mg.cnaps.accueil.*" %>

<div class="content-wrapper">
    <%!
        String idMere = null;
        String[] colSomme = null;
    %>
    <%  
        idMere = request.getParameter("idMere");
        if (idMere == null) {
            idMere = "TOV000012";
        }
        OpOvComplet opov = new OpOvComplet();
        opov.setNomTable("OPOV_COMPLET");
        String listeCrt[] = {"id", "ov", "date_op"};
        String listeInt[] = {"date_op"};
        String libEntete[] = {"id", "ov", "montant"};
        PageRechercheMultiple pr = new PageRechercheMultiple(opov, request, listeCrt, listeInt, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("apresTarifMultiple.jsp");

    %>

    <section class="content-header">
        <h1>Liste selectionn&eacute;es</h1>
    </section>

    <form action="<%=pr.getLien()%>?but=<%=pr.getApres()%>&idMere=<%=idMere%>" method="post">
        <%  if (idMere != null) {
            // System.out.println("miditra ato ve");
                pr.setAWhere(" and ov='" + idMere + "'");
                pr.creerObjetPage(libEntete, colSomme);
                String lienTableau[] = {pr.getLien() + "?but=st/inventaire-fiche.jsp", pr.getLien() + "?but=st/inventaire-fiche.jsp"};
                String colonneLien[] = {"ov", "id"};
                pr.getTableau().setLien(lienTableau);
                String libelles[] = {"Id fille", "Id mere", "Montant"};
                pr.getTableau().setColonneLien(colonneLien);
                pr.getTableau().setLibelleAffiche(libelles);
                out.println(pr.getTableau().getHtmlWithCheckboxSelected());
            }
        %>
        <input type="hidden" name="classe" value="mg.cnaps.treso.TresoOpov"/>
        <input type="hidden" name="bute" value="testMultiple.jsp"/>
        <input type="hidden" name="idMere" value="<%=idMere%>"/>
    </form>

    <%
        OPComplet op = new OPComplet();
        String listeCrt1[] = {"id", "beneficiaire", "montant", "date_op"};
        String listeInt1[] = {"date_op"};
        String libEntete1[] = {"id", "beneficiaire", "montant", "date_op"};
        PageRecherche prc = new PageRecherche(op, request, listeCrt1, listeInt1, 3, libEntete1, 4);
        prc.setUtilisateur((user.UserEJB) session.getValue("u"));
        prc.setLien((String) session.getValue("lien"));
        prc.setApres("apresTarifMultiple.jsp");
        String[] colSomme1 = null;
        prc.creerObjetPage(libEntete1, colSomme1);
    %>
    <section class="content-header">
        <h1>Liste</h1>
    </section>
    <section class="content">
        <form action="<%=prc.getLien()%>?but=testMultiple.jsp&idMere=<%=idMere%>" method="post">
            <% out.println(prc.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            String lienTableau1[] = {pr.getLien() + "?but=tresorerie/op/op-fiche.jsp"};
            String colonneLien1[] = {"id"};
            prc.getTableau().setLien(lienTableau1);
            prc.getTableau().setColonneLien(colonneLien1);
            out.println(prc.getTableauRecap().getHtml());%>
        <form method="post" action="<%=prc.getLien()%>?but=<%=prc.getApres()%>">
            <input type="hidden" name="classe" value="mg.cnaps.treso.TresoOpov"/>
            <input type="hidden" name="bute" value="testMultiple.jsp"/>
            <input type="hidden" name="acte" value="attacher"/>
            <input type="hidden" name="idMere" value="<%=idMere%>"/>
            <%
            String libEnteteAffiche[] = {"Identifiant", "Bénéficiaire", "Montant", "Date"};
            prc.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(prc.getTableau().getHtmlWithCheckbox());
            out.println(prc.getBasPage());
            %>
        </form>
    </section>
</div>