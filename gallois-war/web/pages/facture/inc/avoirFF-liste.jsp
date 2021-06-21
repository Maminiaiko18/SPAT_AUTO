<%-- 
    Document   : avoirFF-liste
    Created on : 21 juin 2021, 10:56:48
    Author     : nyamp
--%>
<%@page import="bean.AdminGen"%>
<%@page import="avoir.AvoirLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
   AvoirLibComplet cht = new AvoirLibComplet();
    cht.setNomTable("avoir_lib_val");
    String libEntete[] = {"id", "designation", "typeavoir_desce","remarque", "daty", "montant","tva"};
    String listeCrt[] = {"idfacture"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    
    String libEnteteAffiche[] = {"id", "Désignation","Type","remarque", "Date", "Montant","tva"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    String lienTableau[] = {pr.getLien() + "?but=avoir/avoir-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

       
    
    if(pr.getTableau().getHtml() != null){
        out.println(pr.getTableau().getHtml());        
        AvoirLibComplet[] liste=(AvoirLibComplet[])pr.getTableau().getData();

        double total=0;
        total=AdminGen.calculSommeDouble(liste,"montant");

%>
        
        <table class="table table-striped table-bordered table-condensed table-responsive tree" >
            <tr>
                <td colspan="5"></td>
                <th width="20%" align="right">Montant total</th>
                <td width="20%" align="right"><%=total%></td>
            </tr>
        </table>
    <% }else{
        %><center><h4>Aucun Avoir</h4></center><%
    }
%>
<%} catch (Exception e) {
       e.printStackTrace();
    }%>
