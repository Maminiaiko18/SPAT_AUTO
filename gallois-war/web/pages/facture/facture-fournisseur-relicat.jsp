<%@page import="facture.RelicatFF"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
        RelicatFF ff = new RelicatFF();
        
        String listeCrt[] = {"datypr"};
        String listeInt[] = {"datypr"};
        String libEntete[] = {"id", "idpr", "tierslib", "contact","numeroop","numeroopr","montantpr", "montant", "diff", "datypr"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        
        pr.setApres("facture/facture-fournisseur-relicat.jsp");
        
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Relicat FF</h1>
    </section>
    <section class="content">
        <form action='<%=pr.getLien() + "?but=facture/facture-fournisseur-relicat.jsp" %>' method="post" name="liste" id="liste">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
               <%
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-relicat.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String libelleAffiche[] = {"ID", "id Pr&eacute;vision", "tiers", "Contact","Num&eacute;ro Op","Num&eacute;ro OP pr&eacute;vision","Montant pr&eacute;vision", "Montant", "Diff&eacute;rence", "Date pr&eacute;vision"};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

