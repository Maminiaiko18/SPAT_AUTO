<%-- 
    Document   : listeff.jsp
    Created on : 22 f�vr. 2022, 15:20:49
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
    j.setNomTable("FACTURE_FOURNISSEUR_TRAVAUX");
    String libEntete[] = {"id","daty", "montant", "tva", "montanttva", "montantttc","numeroop","prevalidationlib"};
    String listeCrt[] = {};
    String listeInt[] = {};
    
    PageRecherche pr = new PageRecherche(j, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
       
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String id = request.getParameter("id");
    if (id != null) {
        pr.setAWhere(" and idcontrat  = '" + id + "'");
    }
        
    pr.creerObjetPage(libEntete, null);
    
    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    
    pr.getTableau().setLibelleAffiche(new String[] {"id","Date", "Montant HT", "TVA", "Montant TVA", "MontantTTC","Numero facture","Pr&eacute;validation"});
    pr.getTableau().setNameActe("valider");
    String html = pr.getTableau().getHtml();    
    if(html != null){ 
        out.println(html);
    }else{
        %><center><h4>Pas de r�sultat</h4></center><%
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
  