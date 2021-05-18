<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="facture.FactureProformaDetails"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureProformaDetails cht = new FactureProformaDetails();
    //cht.setNomTable("facture_client_fille_lib_reste");
    String libEntete[] = {"id", "designation", "quantite","devise","compte","pu", "taux"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "designation", "quantité", "devise","compte","pu", "taux"};
//    String lienTableau[] = {pr.getLien() + "?but=avoir/avoir-fiche.jsp"};
//    String colonneLien[] = {"id"};
//    pr.getTableau().setLien(lienTableau);
//    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    FactureClientDetails[] liste=(FactureClientDetails[])pr.getTableau().getData();
    if(pr.getTableau().getHtml() != null){
        out.println(pr.getTableau().getHtml());
        
%>
        
        
    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
