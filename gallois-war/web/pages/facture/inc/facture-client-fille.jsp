<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
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
    String libEntete[] = {"id", "designation", "quantite","qtelivree","restealivrer", "devise","compte","pu", "taux","montanttaux"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "designation", "quantité","quantité livrée","reste à livrer", "devise","compte","pu", "taux","montant"};
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
%>
        
    <table class="table table-striped table-bordered table-condensed table-responsive tree" >
        <tr>
            <th width="16%" align="right">Montant total</th>
            <td width="16%" align="right"><%= utilitaire.Utilitaire.formaterAr(total)%></td>
        </tr>
    </table>
        
    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
