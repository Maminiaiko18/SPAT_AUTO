

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="mg.spat.BonProvisoireComplet"%>
<%@page import="mg.spat.BonProvisoireRetourRegule"%>
<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
    FactureFournisseur facture = new FactureFournisseur();
    facture.setNomTable("BPvalide");
    String listeCrt[] = {"idom"};
    String listeInt[] = {};
    String libEntete[] ={"id","daty","code", "num","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};

    PageRecherche pr = new PageRecherche(facture, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    String[] colSomme = null;
    
    pr.creerObjetPage(libEntete, colSomme);
    
    String libEnteteAffiche[] = {"id","daty","Code", "Numero BP","Note explicative","Catégorie", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste às payer"};
    String lienTableau[] = {pr.getLien() + "?but=exploitants/activites-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    
    if (pr.getTableau().getHtml() != null) {
        out.println(pr.getTableau().getHtml());
%>   
<% } else {
%><center><h4>Aucun details </h4></center><%
    }
    %>

    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>

