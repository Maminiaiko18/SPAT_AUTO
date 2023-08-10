<%-- 
    Document   : listeff.jsp
    Created on : 22 févr. 2022, 15:20:49
    Author     : andri
--%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="affichage.PageRecherche"%>
<%
    OrdonnerPayement j = new OrdonnerPayement();
        j.setNomTable("ORDONNERPAYEMENT_LIB");
     String libEntete[] =  {"id","ded_Id", "tiers","numeroop","daty" ,"remarque","montant"};
    String listeCrt[] = {"ded_id"};
    String listeInt[] = {};
    
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
          pr.setAWhere("and DED_ID like '%"+request.getParameter("id")+"%'");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=ded/ordonnerpayement-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"id","idFacture", "tiers","Num Op","daty" ,"Remarque","Montant"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    if(pr.getTableau().getData() != null && pr.getTableau().getData().length > 0){ %>
    <% 
        out.println(pr.getTableau().getHtmlWithCheckbox());
    %> 
    <% }else{
        %><center><h4>Pas de résultat</h4></center><%
    }
%>
  