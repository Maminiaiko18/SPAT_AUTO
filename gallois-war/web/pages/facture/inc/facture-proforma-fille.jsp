<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="facture.FactureProformaDetails"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureProformaDetails cht = new FactureProformaDetails();
    cht.setNomTable("FACTURE_CLIENT_PROFMONTANT");
    String libEntete[] = {"id", "designation", "quantite","devise","compte","pu", "taux","montanttaux"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "designation", "quantité", "devise","compte","pu", "taux","montant"};
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    FactureClientDetails[] liste=(FactureClientDetails[])pr.getTableau().getData();
    if(pr.getTableau().getHtml() != null){
        out.println(pr.getTableau().getHtml());
         double total=0;
        total=AdminGen.calculSommeDouble(liste,"montanttaux");
%>
        
    <table class="table table-striped table-bordered table-condensed table-responsive tree" >
        <tr>
            <th width="16%" align="right">Montant total</th>
            <td width="16%" align="right"><%=utilitaire.Utilitaire.formaterAr(total) %></td>
        </tr>
    </table>
         
    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
