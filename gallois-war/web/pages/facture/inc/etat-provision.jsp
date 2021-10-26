<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="facture.EtatProvision"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="facture.FactureClient" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    EtatProvision base = new EtatProvision();
    base.setNomTable("etat_provisionlib");
    System.out.println("idfacture ====> "+request.getParameter("idfacture"));
    String listeCrt[] = {"idfacture"};
    String listeInt[] = {};
    String libEntete[] = {"id","idFacture", "numpiece", "numProvision", "operation", "tierslib","idnavirelib","idmodelib","idbanquelib"};

    PageRecherche pr = new PageRecherche(base, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.creerObjetPage(libEntete, null);
    
    String libelleAffiche[] = {"Id", "Facture", "Numéro pièce", "Numéro provision", "Opération",  "Client", "Navire", "Mode", "Banque"};
    pr.getTableau().setLibelleAffiche(libelleAffiche);
    
    if(pr.getTableau().getHtml() != null){ 
        out.println(pr.getTableau().getHtml());
    }else{ %>
        <center><h4>Aucunes données </h4></center><%
    }
%>
