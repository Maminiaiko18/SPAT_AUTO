<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%
    BonDeCommande j = new BonDeCommande();
        j.setNomTable("AS_BONDECOMMANDE");
    String libEntete[] = {"id", "DATY","DELAILIVRAISON","DELAIPAIEMENT", "DESIGNATION", "DEVISEMERE", "ETAT", "FOURNISSEUR","IDENGAGEMENT","IDUSER","MODEPAIEMENT","NUMBC","PROJET","REMARQUE","TVA","TYPEPAIEMENT"};
    String listeCrt[] = {"idengagement"};
    String listeInt[] = {};
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
       
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    
    pr.getTableau().setLibelleAffiche(new String[]{"id", "DATY","DELAILIVRAISON","DELAIPAIEMENT", "DESIGNATION", "DEVISEMERE", "ETAT", "FOURNISSEUR","IDENGAGEMENT","IDUSER","MODEPAIEMENT","NUMBC","PROJET","REMARQUE","TVA","TYPEPAIEMENT"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtmlWithCheckbox();    
    if(html != null){ %>
     <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" method="post" name="id" id="id">
         <input type="hidden" name="bute" value="depense/engagement-fiche.jsp&id=<%=request.getParameter("idda")%>"/>
            <input type="hidden" name="classe" value="mg.spat.stock.BonDeCommande"/>
            <input type="hidden" name="acte" value="valider"/>
            <% out.println(html); %>
     </form>
    <% }else{
        %><center><h4>Pas de résultat</h4></center><%
    }
%>