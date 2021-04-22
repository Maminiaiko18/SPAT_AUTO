<%-- 
    Document   : details-facture-client-liste
    Created on : 2 févr. 2021, 14:34:54
    Author     : ACER
--%>


<%@page import="factureclient.FactureClientDetail"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    FactureClientDetail factDet = new FactureClientDetail();
    factDet.setNomTable("facture_client_detail_lib");

    String listeCrt[] = {"id", "idFacture", "designation", "medicament", "quantite", "montant"};
    String listeInt[] = {"montant"};
    //String libEntete[] = {"ID",  "remarque", "daty", "valcodeacte","montant","remise","montantremise","montantdocteur"};
    String libEntete[] = {"id", "idFacture", "designation", "medicament", "quantite", "montant"};
    PageRecherche pr = new PageRecherche(factDet, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    //pr.getFormu().getChamp("valantenne").setDefaut("ANTANANARIVO");
    //pr.getFormu().getChamp("valantenne").setLibelle("Antenne");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facture/details-facture-client-liste.jsp");
    pr.getFormu().getChamp("idFacture").setLibelle("Facture");
    pr.getFormu().getChamp("designation").setLibelle("Désignation");
    pr.getFormu().getChamp("medicament").setLibelle("Médicament");
    pr.getFormu().getChamp("quantite").setLibelle("Quantité");
    pr.getFormu().getChamp("montant1").setLibelle("Montant minimum");
    pr.getFormu().getChamp("montant2").setLibelle("Montant maximum");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des détails facture</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/details-facture-client-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
            </div>
        </form>
        <%

            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" method="post" name="fusionner" id="fusionner">
            <%
                //String libEnteteAffiche[] = {"ID",  "Patient", "Date", "Acte","Montant","Remise","Montant remisé","Montant docteur"};
                String libEnteteAffiche[] = {"ID", "ID Facture", "Désignation", "Médicament", "Quantité", "Prix unitaire", "Montant Total"};

                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                //out.println(pr.getTableau().getHtml());
                pr.getTableau().setAfficheBouttondevalider(false);
                
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
            <input type="submit" name="fusionnerdetails" value="Fusionner">
            <input name="acte" type="hidden" id="nature" value="fusionnerdetails">
            <input type="hidden" name="nomtable" value="FACTURE_CLIENT_DETAIL" >
            <input type="hidden" name="classe" value="factureclient.FactureClientDetail">
            <input type="hidden" name="bute" value="facture/facture-client-fiche.jsp">
        </form>
        <%
            out.println(pr.getBasPage());
        %>
    </section>
</div>