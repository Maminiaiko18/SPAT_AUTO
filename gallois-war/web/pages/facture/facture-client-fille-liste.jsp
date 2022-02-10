<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="facture.FactureClientDetails"%>
<%@page import="mg.spat.CaFcFilleComplet"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        CaFcFilleComplet cht = new CaFcFilleComplet();
        cht.setNomTable("FCFILLECOMPLET");
        String libEntete[] = { "idmere","daty","client", "nomnavire", "designation", "compte", "pu", "quantite", "duree", "tva", "montant", "montantTva", "montantttc"};
        String listeCrt[] = {"compte", "mois", "annee", "type"};
        String listeInt[] = {"mois"};

        PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/facture-client-fille-liste.jsp");

        pr.getFormu().getChamp("mois1").setLibelle("mois min");
        pr.getFormu().getChamp("mois2").setLibelle("mois max");
        pr.getFormu().getChamp("annee").setLibelle("Année");
        pr.getFormu().getChamp("type").setLibelle("Type");
        pr.getFormu().getChamp("compte").setLibelle("Compte");
        
        pr.getFormu().getChamp("annee").setDefaut(utilitaire.Utilitaire.getAnneeEnCours());
        
        affichage.Liste[] listes= new affichage.Liste[3];
        
        TypeObjet type = new TypeObjet();
        type.setNomTable("typefc");
        listes[0] = new Liste("type", type, "VAL", "id");
        
        listes[1] = new Liste("mois1");
        listes[1].makeListeMois();
        //listes[1].setDefaultSelected(utilitaire.Utilitaire.getMoisEnCours()+"");

        listes[2] = new Liste("mois2");
        listes[2].makeListeMois();        
        //listes[2].setDefaultSelected(utilitaire.Utilitaire.getMoisEnCours()+"");
        
        pr.getFormu().changerEnChamp(listes);
        
        pr.getFormu().getChamp("mois1").setDefaut(utilitaire.Utilitaire.getMoisEnCours()+"");
        pr.getFormu().getChamp("mois2").setDefaut(utilitaire.Utilitaire.getMoisEnCours()+"");
        pr.getFormu().getChamp("mois1").setLibelle("mois min");
        pr.getFormu().getChamp("mois2").setLibelle("mois max");
        pr.getFormu().getChamp("annee").setLibelle("Année");
        pr.getFormu().getChamp("type").setLibelle("Type");
        pr.getFormu().getChamp("compte").setLibelle("Compte");
        
        String[] colSomme = {"montant", "montanttva", "montantttc"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture client details</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/facture-client-fille-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"idmere"};
            String[] urlLien = {"idmere"};
            String[] urlLienAff = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            pr.getTableau().setUrlLien(urlLien);
            pr.getTableau().setUrlLienAffiche(urlLienAff);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Num Facture","date","client", "navire", "Désignation", "Compte", "Prix unitaire", "Quantité", "Durée", "TVA", "Montant", "Montant TVA", "Montant TTC"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
