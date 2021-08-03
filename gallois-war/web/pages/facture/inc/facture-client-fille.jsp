<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="facture.FactureClient"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureClientDetails cht = new FactureClientDetails();
    cht.setNomTable("facture_client_fille_lib_reste");
    String libEntete[] = {"id", "designation", "quantite","qtelivree","restealivrer", "devise","compte","pu", "taux","montanttaux","tva","montantTva","montantHTEuro","montantTVAEuro","activitelib","heureDebut","heureFin","reduction","majoration"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "designation", "quantité","quantité livrée","reste à livrer", "devise","compte","pu", "taux","montant","tva","montant Tva","HT Euro","TVA Euro","Activite","Heure début","Heure fin","RED.%", "MAJ.%"};
//    String lienTableau[] = {pr.getLien() + "?but=avoir/avoir-fiche.jsp"};
//    String colonneLien[] = {"id"};
//    pr.getTableau().setLien(lienTableau);
//    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    
    FactureClientDetails[] liste=(FactureClientDetails[])pr.getTableau().getData();
    
    /*
    FactureClient fm=(FactureClient) liste[0].findMere(null,null);
    FactureClientDetails[] lcdf=(FactureClientDetails[])fm.getFille(null, null,"");
    FactureClient dfm=(FactureClient)fm.dupliquer(pr.getUtilisateur().getUser().getTuppleID(), null);
*/
    
    
    
    
    if(pr.getTableau().getHtml() != null)
    {
        out.println(pr.getTableau().getHtml());
         double total=0;
        total=AdminGen.calculSommeDouble(liste,"montanttaux");
        FactureClient facture = new FactureClient();
        facture.setId(liste[0].getIdmere());
        facture.initDetails(null);
        double hTEuro = facture.getMontantHTEuro();
        double tvaEuro = facture.getMontantTVAEuro();
        double hTDollar = facture.getMontantHTVADollar();
        double tvaDollar = facture.getMontantTVADollar();
        double ttcDollar = facture.getMontantTTCDollar();
        double deviseEur = facture.getDeviseEuro();
        double deviseDollar = facture.getDeviseDollar();
%>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-4">
        <table class="table table-striped table-bordered table-condensed table-responsive tree">
        <tr>
            <th>Devise Euro</th>
            <td align="right"><%=Utilitaire.formaterAr(deviseEur)%></td>
        </tr>
        <tr>
            <th>Devise Dollar</th>
            <td align="right"><%=Utilitaire.formaterAr(deviseDollar)%></td>
        </tr>
    </table>
    </div>
<div class="col-md-4">
<table class="table table-striped table-bordered table-condensed table-responsive tree">
    <tr>
        <th>HT Euro</th>
        <td align="right"><%=Utilitaire.formaterAr(hTEuro)%></td>
    </tr>
    <tr>
        <th>TVA Euro</th>
        <td align="right"><%=Utilitaire.formaterAr(tvaEuro)%></td>
    </tr>
    <tr>
        <th>HT Dollar</th>
        <td align="right"><%=Utilitaire.formaterAr(hTDollar)%></td>
    </tr>
    <tr>
        <th>TVA Dollar</th>
         <td align="right"><%=Utilitaire.formaterAr(tvaDollar)%></td>
    </tr>
    <tr>
        <th>TTC Dollar</th>
        <td align="right"><%=Utilitaire.formaterAr(ttcDollar)%></td>
    </tr>
</table>
</div>
</div>
        
    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
