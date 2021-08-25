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
    base.setNomTable("provisionfacturedefinitivetous");
    
    String listeCrt[] = {"iddefinitive"};
    String listeInt[] = {};
    String libEntete[] = {"id","daty","tierslib","escale","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste", "etatLib"};


    PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    String[] colSomme = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    pr.creerObjetPage(libEntete, colSomme);
        
    String[] libelleAffiche = {"id","daty","Client","Escale","designation","Catégorie", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste à payer", "Etat"};
    pr.getTableau().setLibelleAffiche(libelleAffiche);

            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);    
    
    if(pr.getTableau().getHtml() != null){

        out.println(pr.getTableau().getHtml());
    }else{ %>
        <center><h4>Aucunes factures </h4></center><%
    }
%>
