

<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        EtatFactureMontantDaty ff = new EtatFactureMontantDaty();

        String listeCrt[] = {"remarque"};   
        String listeInt[] = {};
        String libEntete[] = {"id", "daty", "nomfournisseur","numfact","designation","dateemission","datyecheance","montantttc","montantpaye","reste"};

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
%>
<%
    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche.jsp", pr.getLien() + "?but=travaux/details-chantier-fiche.jsp"};

    String colonneLien[] = {"id", "remarque"};
//    String[] urlLienMultiple = {"id", "idchantier"};
    String[] urlLienAffiche = {"id", "id"};
//    pr.getTableau().setUrlLienAffiche(urlLienAffiche);
//    pr.getTableau().setUrlLien(urlLienMultiple);
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    String libEnteteAffiche[] = {"id", "daty", "nomfournisseur","numfact","designation","dateemission","datyecheance","montantttc","montantpaye","reste"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    out.println(pr.getTableau().getHtml());
%>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

