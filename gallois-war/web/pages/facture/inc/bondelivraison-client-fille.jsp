<%-- 
    Document   : bondelivraison-client-fille
    Created on : 17 mai 2021, 16:08:18
    Author     : nyamp
--%>

<%@page import="mg.spat.stock.BonDeLivraisonClientFille"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    BonDeLivraisonClientFille cht = new BonDeLivraisonClientFille();
    cht.setNomTable("AS_BONDELIVRAISON_CL_FILLE_LIB");
    String libEntete[] = {"id", "produitlib", "quantite"};
    String listeCrt[] = {"numbl"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete);
    String libEnteteAffiche[] = {"id", "Produit", "quantite"};
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    //BonDeLivraisonFille[] liste=(BonDeLivraisonFille[])pr.getTableau().getData();
    if(pr.getTableau().getHtml() != null){
        out.println(pr.getTableau().getHtml());
//         double total=0;
//        total=AdminGen.calculSommeDouble(liste,"montanttaux");
%>
        
<!--    <table class="table table-striped table-bordered table-condensed table-responsive tree" >
        <tr>
            <th width="16%" align="right">Montant total</th>
            <td width="16%" align="right"><%//=total%></td>
        </tr>
    </table>-->
        
    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
