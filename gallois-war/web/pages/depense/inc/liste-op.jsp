<%-- 
    Document   : listeff.jsp
    Created on : 22 févr. 2022, 15:20:49
    Author     : andri
--%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="affichage.PageRecherche"%>
<%
    OrdonnerPayement j = new OrdonnerPayement();
        j.setNomTable("OP_engagement");
     String libEntete[] =  {"id","numeroop","daty", "tiers", "ded_Id","remarque","montant", "modepaiementlib", "etatlib"};
    String listeCrt[] = {"idengagement"};
    String listeInt[] = {};
    
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
       
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=ded/ordonnerpayement-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"id","Numéro OP","Date", "Tiers", "Facture","Motif de paiement","Montant","Mode de paiement", "Etat"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    if(pr.getTableau().getData() != null && pr.getTableau().getData().length > 0){ %>
    <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post">
            <input type="hidden" name="bute" value="depense/engagement-fiche.jsp&id=<%=request.getParameter("id")%>"/>
            <input type="hidden" name="classe" value="ded.OrdonnerPayement"/>
            <input type="hidden" name="acte" value="viser"/>
            <input type="hidden" name="table" id="table" value="OrdonnerPayement"/>
            <% 
                pr.getTableau().setNameActe("valider");
                pr.getTableau().setNameBoutton("Valider");
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>  
    </form>
    <% }else{
        %><center><h4>Pas de résultat</h4></center><%
    }
%>
  