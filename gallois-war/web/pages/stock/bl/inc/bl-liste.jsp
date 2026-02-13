
<%@ page import="affichage.*" %>
<%@ page import="mg.spat.stock.BonDeLivraison" %>

<%
    try {
        BonDeLivraison lv = new BonDeLivraison();
        lv.setNomTable("AS_BONDELIVRAISON_MTTCPL2");

        String libEntete[] = {"id", "daty", "numbc","montant","montanttva","montantttc","montantfactttc","montantpaye","rap","reste_a_facturer"};
        String listeCrt[] = {};
        String listeInt[] = {};
        PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        if (request.getParameter("idFacture") != null) {
            pr.setAWhere(" and idFacture ='" + request.getParameter("idFacture") + "' and id <> '"+ request.getParameter("id")+"' ");
        }

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=stock/bl/bondelivraison-fiche.jsp", pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
        String colonneLien[] = {"id","numbc"};
        String[] urlLienMultiple = {"id","id_bc"};
        String[] urlLienAffiche = {"id","id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        pr.getTableau().setUrlLienAffiche(urlLienAffiche);
        pr.getTableau().setUrlLien(urlLienMultiple);
%>

<div class="box-body">
    <div class="box-title with-border">
        <h2 class="box-title">Liste des bons de livraison li&eacute; a ce facture</h2>
    </div>
    <%
        String libEnteteAffiche[] = {"Id", "Date","Numero BC","Montant", "Montant TVA", "Montant TTC", "Montant factur&eacute;", "Montant pay&eacute;", "Reste &agrave; payer", "Reste &agrave; facturer"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        pr.getTableau().getData();
        if (pr.getTableau().getHtml() != null) {
            out.println(pr.getTableau().getHtml());
        } else {
    %><center><h4>Aucune donn&eacute;e trouv&eacute;e</h4></center><%
    }


%>
</div>
<%    } catch (Exception e) {
    e.printStackTrace();
}%>

