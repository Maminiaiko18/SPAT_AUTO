<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%
    BonDeCommande j = new BonDeCommande();
        j.setNomTable("AS_BONDECOMMANDE_LIBELLE_lib");
     String libEntete[] = {"id", "daty","code_etab","projet", "fournisseur", "designation", "modepaiement", "remarque","numbc","montant","montantRemise","montanttva","montantTTC","montant_A_payer","restepayergeneral","montantfacture","montant_paye_reel","resteapayerreel","etatlib"};
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
    
    pr.getTableau().setLibelleAffiche(new String[]{"Id", "Date","Code","Projet", "Fournisseur", "Designation", "Mode de paiement", "Remarque","numero BC","Montant HT","Montant Remise","Montant TVA","Montant TTC","Montant BL TTC","Reste à livrer","Montant factur&eacute;","Montant payé réèl","Reste à payer réel", "Etat"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtmlWithCheckbox();    
    if(html != null){ %>
     <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" method="post" name="id" id="id">
         <input type="hidden" name="bute" value="depense/engagement-fiche.jsp&id=<%=request.getParameter("idengagement")%>"/>
            <input type="hidden" name="classe" value="mg.spat.stock.BonDeCommande"/>
            <input type="hidden" name="acte" value="valider"/>
            <% out.println(html); %>
     </form>
    <% }else{
        %><center><h4>Pas de résultat</h4></center><%
    }
%>