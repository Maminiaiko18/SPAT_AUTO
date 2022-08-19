<%-- 
    Document   : factureFournisseur
    Created on : 16 févr. 2022, 09:08:49
    Author     : nyamp
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //int etatOP = Utilitaire.stringToInt(request.getParameter("etatOP"));
    //String ded_id = request.getParameter("ded_id");
    
    JournalCaisse act = new JournalCaisse();
    act.setNomTable("JournalCaisse");
    String listeCrt[] = {"idordre"};
    String listeInt[] = {};
        String libEntete[] = {"id","valcaisse","numpiece", "numcheque", "libelle", "debit"};
    
    String awhere = "";
        
    PageRecherche pr = new PageRecherche(act, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    String[] colSomme = null;
    
    pr.creerObjetPage(libEntete, colSomme);
    
            String libEnteteAffiche[] = {"id","Caisse","N° pièce", "N° chèque", "Libellé", "Montant"};
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
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
