<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%
    BonDeCommande j = new BonDeCommande();
    j.setNomTable("AS_BONDECOMMANDE_LIB_fiche");
    String libEntete[] = {"id", "DATY", "DESIGNATION", "FOURNISSEUR","NUMBC","REMARQUE"};
    String listeCrt[] = {"idda"};
    String listeInt[] = {};
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setAWhere("and idda like '%"+request.getParameter("id")+"%'");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    
    pr.getTableau().setLibelleAffiche(new String[]{"id", "DATY", "DESIGNATION", "FOURNISSEUR","NUMBC","REMARQUE"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtmlWithCheckbox();    
    if(html != null){ %>
        <% out.println(html); %>
    <% }else{
        %><center><h4>Pas de résultat</h4></center><%
    }
%>