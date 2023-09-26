<%-- 
    Document   : listeff.jsp
    Created on : 22 févr. 2022, 15:20:49
    Author     : andri
--%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="facture.FactureFournisseur"%>
<%
    try{
    FactureFournisseur j = new FactureFournisseur();
        j.setNomTable("FFchantier");
     String libEntete[] = {"id","daty","tierslib", "numeroop", "code", "projetlib", "code_etablissementlib", "naturelib","designation","exercice","date_echeance", "montantTTCvrai", "montantAvoir", "montantTTC", "montantpaye","montantreste","numOP", "etatlib"};
    String listeCrt[] = {"chantier"};
    String listeInt[] = {};
    
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
       
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    
    pr.getTableau().setLibelleAffiche(new String[]{"id","Date","Fournisseur", "N° Facture","Numero compta", "Projet", "Code direction", "Nature","Note explicative","exercice", "date echeance", "montant TTC", "montant Avoir", "Net à payer", "Montant payé","Reste à payer","Numero OP", "Etat"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtml();    
    if(html != null){ 
        out.println(html);
    }else{
        %><center><h4>Pas de résultat</h4></center><%
    }
%>
  
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>      
  