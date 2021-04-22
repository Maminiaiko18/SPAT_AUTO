<%-- 
    Document   : chantier-travaux
    Created on : 14 déc. 2020, 10:04:47
    Author     : ASUS
--%>
<%@page import="mg.spat.compta.ContratChantier"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="mg.spat.Travaux"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.Chantier"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ContratChantier cht = new ContratChantier();
    cht.setNomTable("CONTRAT_CHANTIER_LIB_COMPLET");
    String libEntete[] = {"id", "nom_chantier", "designation", "nom_prestataire","montant","etat"};
    String listeCrt[] = {"montant"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String id = request.getParameter("id");
    String nom = request.getParameter("nom");
    pr.setAWhere(" and idchantier ='"+id+"'");
    
    pr.setApres("travaux/inc/contrat-travaux.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "Chantier", "Designation", "Prestataire","Motant","Etat"};
    String lienTableau[] = {pr.getLien() + "?but=travaux/contrat-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    if(pr.getTableau().getHtml() != null){
        out.println(pr.getTableau().getHtml());
    }else{
        %><center><h4>Aucun Contrat</h4></center><%
    }
%>
<a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/contrat-saisie.jsp&idchantier=" + id+"&nom="+nom%>" style="margin-right: 10px">Saisir contrat</a>
