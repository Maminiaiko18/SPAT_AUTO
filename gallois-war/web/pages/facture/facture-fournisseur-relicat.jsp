<%@page import="facture.RelicatFF"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
        RelicatFF ff = new RelicatFF();
        
        String listeCrt[] = {"id"};
        String listeInt[] = {"id"};
        String libEntete[] = {"id", "idpr", "tierslib", "contact","numeroop","numeroopr","montantpr", "montant", "diff", "datypr"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        
        
        pr.setApres("facture/client-tp-liste.jsp");
        
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des clients TP</h1>
    </section>
    <section class="content">
        <form action='<%=pr.getLien() + "?but=facture/client-tp-liste.jsp" %>' method="post" name="liste" id="liste">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
               <%
            String lienTableau[] = {pr.getLien() + "?but=facture/client-tp-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String libelleAffiche[] = {"id", "idpr", "tierslib", "contact","numeroop","numeroopr","montantpr", "montant", "diff", "datypr"};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

