<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JournalCaisse j = new JournalCaisse();
        j.setNomTable("JOURNALCAISSELIBCOMPLET");
    String libEntete[] = {"id", "dateSaisie", "dateEffet", "valcaisse", "libelle", "debit", "credit", "tiersLib", "etat"};
    String listeCrt[] = {"idplacement"};
    String listeInt[] = {};
    
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setAWhere(" AND IDPLACEMENT='"+request.getParameter("idAvoir")+"'");
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    
    pr.getTableau().setLibelleAffiche(new String[]{"id", "Date Saisie", "Date Effet", "Caisse", "Libelle", "Sortie", "Entrée", "Tiers", "Etat"});
    String html = pr.getTableau().getHtml();
    html = html == null ? "Pas de r�sultat" : html;
%>
<%=html%>