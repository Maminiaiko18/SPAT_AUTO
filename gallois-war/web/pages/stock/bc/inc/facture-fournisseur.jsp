<%-- 
    Document   : bondelivraison-liste
    Created on : 25 nov. 2020, 17:50:42
    Author     : ASUS
--%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<% 
    
    FactureFournisseur lv = new FactureFournisseur();
    //lv.setNomTable("ST_BONDLIVRAISON_VALIDER"); 
    lv.setNomTable("FACTUREFOURNVALIDE_TOUS");
    String libEntete[] = {"id","daty","tierslib", "numeroop", "code", "projetlib", "code_etablissementlib", "naturelib","designation","categorielib","tva","date_echeance", "montantTTCvrai", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    String listeCrt[] = {"idbc"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("stock/bc/inc/facturefournisseur.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
        <% 
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
            String colonneLien[] = {"id"};
            String[] urlLienMultiple = {"id"};
            String[] urlLienAffiche = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);           
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id","daty","Client", "N° Facture","Numero compta", "Projet", "Code direction", "Nature","Note explicative","Catégorie", "tva", "date echeance", "montant TTC", "Net à payer", "montant Avoir","Montant payé","Reste à payer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>  
