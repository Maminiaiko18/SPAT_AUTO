<%-- 
    Document   : factureFournisseur
    Created on : 16 févr. 2022, 09:08:49
    Author     : nyamp
--%>

<%@page import="facture.FactureFournisseur"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureFournisseur act = new FactureFournisseur();
    act.setNomTable("liaisonOPFF");
    String listeCrt[] = {"id2"};
    String listeInt[] = {};
        String libEntete[] = {"id","daty","tierslib", "numeroop", "code", "projetlib", "code_etablissementlib", "naturelib","designation","exercice","date_echeance", "montantTTCvrai", "montantAvoir", "montantTTC", "montantpaye","montantreste","numOP"};

    PageRecherche pr = new PageRecherche(act, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    String[] colSomme = null;
    
    pr.creerObjetPage(libEntete, colSomme);
    
            String libEnteteAffiche[] = {"id","Date","Fournisseur", "N° Facture","Numero compta", "Projet", "Code direction", "Nature","Note explicative","exercice", "date echeance", "montant TTC", "montant Avoir", "Net à payer", "Montant payé","Reste à payer","Numero OP"};
    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
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
