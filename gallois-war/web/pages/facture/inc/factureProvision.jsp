<%-- 
    Document   : factureFournisseur
    Created on : 16 févr. 2022, 09:08:49
    Author     : nyamp
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    String bonProvisoire = request.getParameter("bonprovisoire");
    
    FactureFournisseur act = new FactureFournisseur();
    act.setNomTable("BPvalide");
	String listeCrt[] = {"bonprovisoire"};
    String listeInt[] = {"daty","date_echeance"};
    String libEntete[] = {"id","daty","tierslib", "code", "escale","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    
    String awhere = "";
    
        
    PageRecherche pr = new PageRecherche(act, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    String[] colSomme = null;
    
    pr.setAWhere(pr.getAWhere() + " " + awhere);
    
    pr.creerObjetPage(libEntete, colSomme);
    
            String libEnteteAffiche[] = {"id","daty","Client","Code", "Escale","Note explicative","Catégorie", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste à payer"};
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp", pr.getLien() + "?but=capitainerie/quais/quais-prevision-fiche.jsp"};
            String colonneLien[] = {"id", "escale"};
            String[] urlLienMultiple = {"id", "idprevision"};
            String[] urlLienAffiche = {"id", "id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);            			
    
    if (pr.getTableau().getHtml() != null) {
        out.println(pr.getTableau().getHtml());
%>   
<% } else {
%><center><h4>Aucun details </h4></center><%
    }
    %>
