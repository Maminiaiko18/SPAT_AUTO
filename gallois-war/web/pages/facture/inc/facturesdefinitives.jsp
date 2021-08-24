<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="facture.FactureClient" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureClient base = new FactureClient();
    base.setNomTable("factureClientValide");
    
    String listeCrt[] = {"idProvision"};
    String listeInt[] = {};
    String libEntete[] = {"id","daty","tierslib","escale","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};


    PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    String[] colSomme = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    pr.creerObjetPage(libEntete, colSomme);
        
    String[] libelleAffiche = {"Id", "Date", "Tiers", "Escale", "Designation", "Categorie", "TVA", "Date Echéance", "Montant", "Montant TVA", "Montant TTC", "Montant Avoir", "Montant Payé", "Montant Reste"};
    pr.getTableau().setLibelleAffiche(libelleAffiche);
    
    
    
    if(pr.getTableau().getHtml() != null){
        
        out.println(pr.getTableauRecap().getHtml());
        out.println(pr.getTableau().getHtml());
    }else{ %>
        <center><h4>Aucun details </h4></center><%
    }
%>
