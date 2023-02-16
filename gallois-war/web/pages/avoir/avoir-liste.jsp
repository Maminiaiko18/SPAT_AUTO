<%-- 
    Document   : avoir-liste
    Created on : 2 févr. 2021, 15:21:47
    Author     : ACER
--%>

<%@page import="avoir.AvoirLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    AvoirLibComplet cht = new AvoirLibComplet();
    cht.setNomTable("AVOIRFC_MONTANT_REGROUP");
    String libEntete[] = {"id", "designation", "typeavoir_desce","remarque", "daty", "montant","tva"};
    String listeCrt[] = {"id","designation","typeavoir_desce","remarque"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facture/avoir-liste.jsp");
    pr.getFormu().getChamp("designation").setLibelle("Désignation");
    pr.getFormu().getChamp("typeavoir_desce").setLibelle("Type");
    

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste avoir</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=avoir/avoir-liste.jsp" method="post" name="incident" id="incident">
            <%
                String libelleAffiche[] = {};
                pr.getTableau().setLibelleAffiche(libelleAffiche);
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String lienTableau[] = {pr.getLien() + "?but=avoir/avoir-fiche.jsp"};

            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id", "Désignation","Type","remarque", "Date", "Montant","tva"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
