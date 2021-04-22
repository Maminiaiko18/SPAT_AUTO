<%@page import="mg.spat.BonProvisoire"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    BonProvisoire cht = new BonProvisoire();
    cht.setNomTable("liste_bon_provisoire");
    String libEntete[] = {"id", "datesaisie", "dateeffet", "folio", "caisse", "numpiece", "libelle", "debit", "credit", "remarque", "etat"};
    String listeCrt[] = {"datesaisie"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setAWhere(" and idfacture = '"+request.getParameter("idfacture") +"' ");
    
    String[] colSomme = {""};
    pr.creerObjetPage(libEntete, colSomme);
    
    pr.getTableau().setLibelleAffiche(new String[]{"id", "date saisie", "date effet", "folio", "caisse", "num pièce", "libelle", "débit", "crédit", "remarque", "etat"});
    String lienTableau[] = {pr.getLien() + "?but=treso/bon-provisoire-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableau().getHtml());
    if(pr.getTableau().getHtml() == null){%>
    <center><h4>Aucun Bon Provisoire</h4></center>
<%}%>