<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.DetailChantierLib"%>
<%-- 
    Document   : details-chantier
    Created on : 25 nov. 2020, 17:33:40
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DetailChantierLib ec = new DetailChantierLib();

    String listeCrt[] = {"caracteristique", "libellechantier", "unite"};
    String listeInt[] = {};
    String libEntete[] = {"id", "caracteristique", "libellechantier", "qte", "pu", "unite"};

    PageRecherche pr = new PageRecherche(ec, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.getFormu().getChamp("caracteristique").setLibelle("Désignation");
    pr.getFormu().getChamp("libellechantier").setLibelle("Chantier");
    pr.getFormu().getChamp("unite").setLibelle("Unité");
    //pr.getFormu().getChamp("id").setLien((String)session.getValue("lien")+"?but=travaux/details-chantier-fiche.jsp", "id=");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String id = "";
    if (request.getParameter("id") != null) {
        id = request.getParameter("id");
        pr.setAWhere(" and mere = '" + id + "'");
    }
    pr.setApres("travaux/inc/details-chantier.jsp");
    String[] colSomme = null;

    pr.creerObjetPage(libEntete, colSomme);
%>  

<%
    String libEnteteAffiche[] = {"Id", "Désignation", "Chantier", "Quantité", "Prix unitaire", "Unité"};
    String lienTableau[] = {pr.getLien() + "?but=travaux/details-chantier-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    out.println(pr.getTableau().getHtml());
%>
<a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/details-chantier-modif-multiple.jsp&mere=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier détails</a>

<a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=bc/asBonDeCommande-saisie.jsp&id=" + id%>" style="margin-right: 10px">Bon de commande</a>
<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-saisie-multiple.jsp&idchantier=" + id%>" style="margin-right: 10px">Facturer</a>
