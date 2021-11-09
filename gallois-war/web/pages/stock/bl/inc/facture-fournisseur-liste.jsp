<%-- 
    Document   : facturefournisseur-liste
    Created on : 25 nov. 2020, 18:59:40
    Author     : ASUS
--%>
<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        FactureFournisseur ff = new FactureFournisseur();
        ff.setNomTable("FACTUREFOURNVALIDE_TOUS");
        String listeCrt[] = {"idbl"};
        String listeInt[] = {};
        String libEntete[] = {"id","daty","tierslib", "code", "escale","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTCvrai", "montantTTC", "montantAvoir","montantpaye","montantreste"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        String id = "";
//        if (request.getParameter("id") != null) {
//            id = request.getParameter("id");
////            pr.setAWhere(" and remarque = '" + id + "'");
//        }

        pr.setApres("stock/bl/facture-fournisseur-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        double montantttc = 0;
        for(int i = 0; i<pr.getTableau().getData().length; i++){
            montantttc = montantttc + ((FactureFournisseur)pr.getTableau().getData()[i]).getMontantttc();
        }
%>
<%
    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp", pr.getLien() + "?but=capitainerie/quais/quais-prevision-fiche.jsp"};

    String colonneLien[] = {"id", "escale"};
    String[] urlLienMultiple = {"id", "idprevision"};
//    String[] urlLienMultiple = {"id", "idchantier"};
    String[] urlLienAffiche = {"id", "id"};
    pr.getTableau().setUrlLienAffiche(urlLienAffiche);
    pr.getTableau().setUrlLien(urlLienMultiple);
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    String libEnteteAffiche[] = {"id","daty","Client","Code", "Escale","Note explicative","Catégorie", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "Net à payer", "montant Avoir","Montant payé","Reste à payer"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    if(pr.getTableau().getData().length>0){
        out.println(pr.getTableau().getHtml());
        //out.println(pr.getTableauRecap().getHtml());%>
        <span style="float:left">Total montant TTC: <%=utilitaire.Utilitaire.formaterAr(montantttc)%></span> 
        <%
    }else{ %>
        <h5 style="text-align: center">Aucun résultat</h5>
    <%}
    
%>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
<div class="row"><a class="btn btn-success pull-right"  href="<%= (String) session.getValue("lien") + "?but=facture/facture-fournisseur-saisie-multiple.jsp&idBL=" + request.getParameter("id")%>" style="margin-right: 10px">Facturer</a></div>
<!--<a class="btn btn-success pull-right"  href="<% //(String) session.getValue("lien") + "?but=facture/facture-fournisseur-saisie-multiple.jsp&idchantier=" + request.getParameter("id")%>" style="margin-right: 10px">Ajouter facture fournisseur</a>-->
<script>
    $('.row .row .box .box-body').css('overflow','scroll')
</script>
    