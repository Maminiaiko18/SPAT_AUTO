<%-- 
    Document   : liste_activites
    Created on : 20 juil. 2021, 11:32:14
    Author     : nyamp
--%>

<%@page import="mg.spat.exploitant.Activite"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Activite act = new Activite();
    act.setNomTable("ACTIVITELIBCOMPLET");
    String listeCrt[] = {"refobjet"};
    String listeInt[] = {};
    String libEntete[] = {"id", "daty", "designation","etatlib"};

    PageRecherche pr = new PageRecherche(act, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    String[] colSomme = null;
    
    pr.creerObjetPage(libEntete, colSomme);
    
    String libEnteteAffiche[] = {"id","daty","designation","etat"};
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
