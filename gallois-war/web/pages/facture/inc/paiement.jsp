<%-- 
    Document   : paiement
    Created on : 26 mai 2021, 08:56:48
    Author     : nyamp
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JournalCaisseLibComplet cht = new JournalCaisseLibComplet();
    cht.setNomTable("journalcaisselib_vise");
    String libEntete[] = {"id", "libelle", "caisse","tierslib","dateeffet", "credit","debit"};
    String listeCrt[] = {"idplacement"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"credit","debit"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "Libelle", "Caisse","tiers","Date", "Débit","Crédit"};
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);    
    if(pr.getTableau().getHtml() != null)
    {
        out.println(pr.getTableau().getHtml());
        JournalCaisseLibComplet[] liste=(JournalCaisseLibComplet[])pr.getTableau().getData();

        double totalCredit=AdminGen.calculSommeDouble(liste,"credit");
        double totaldebit=AdminGen.calculSommeDouble(liste,"debit");
%>   
    <table class="table table-striped table-bordered table-condensed table-responsive tree" >
        <tr>
            <th align="right"></th>
            <th width="14%">Débit</th>
            <th width="14%">Crédit</th>
        </tr>
        <tr>
            <td align="right"></td>
            <td align="right"><%=Utilitaire.formaterAr(totalCredit)%></td>
            <td align="right"><%=Utilitaire.formaterAr(totaldebit)%></td>
        </tr>
    </table>

    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
%>
