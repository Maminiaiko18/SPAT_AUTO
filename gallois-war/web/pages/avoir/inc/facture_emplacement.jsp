<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%
    FactureClient j = new FactureClient();
        j.setNomTable("facture_client_union");
     String libEntete[] = {"id","daty","tierslib", "code", "escale","designation","armateurlib","exercice","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTCvrai", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    String listeCrt[] = {"idavoir"};
    String listeInt[] = {};
    
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
       
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    
    pr.getTableau().setLibelleAffiche(new String[]{"id","daty","Client","Code", "Escale","Note explicative","armateur","exercice","Catégorie", "tva", "date echeance","montant HT", "montant TVA", "Montant TTC", "Net à payer", "montant Avoir","Montant payé","Reste à payer"});
    String html = pr.getTableau().getHtml();
    html = html == null ? "Pas de résultat" : html;
%>
<%=html%>