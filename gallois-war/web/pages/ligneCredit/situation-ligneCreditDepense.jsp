<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="lignecredit.LigneCredit"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        LigneCredit fa = new LigneCredit();
        fa.setNomTable("situationLCDepense");

        String listeCrt[] = {"id","designation","compte"};
        String listeInt[] = {""};
        String libEntete[] = {"id","designation","compte","annee","montant","facture","paye"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("ligneCredit/situation-ligneCreditRecette.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Credits Depenses </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditRecette.jsp" method="post" name="absence" id="absence">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>

        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/fiche-ligneCreditDepense.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id","designation","compte","annee","montant","facture","paye"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>