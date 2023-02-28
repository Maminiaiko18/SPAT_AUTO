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
    try{
    JournalCaisseLibComplet cht = new JournalCaisseLibComplet();
    cht.setNomTable("paiementFC");
    String libEntete[] = {"id","idTraite", "libelle", "caisse","tierslib","numPiece","dateeffet", "montant"};
    String listeCrt[] = {"idfact"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"credit","debit"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id","Traite", "Libelle", "Caisse","tiers","Num piece","Date", "Entree","Sortie"};
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp",pr.getLien() + "?but=facture/traite-fiche.jsp"};
    String colonneLien[] = {"id","Traite"};
    String[] urlLienAffiche = {"id", "id"};
    String[] urlLienMultiple = {"id", "idTraite"};
    pr.getTableau().setUrlLienAffiche(urlLienAffiche);
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setUrlLien(urlLienMultiple);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche); 
    
    if(pr.getTableau().getHtml() != null)
    {
        out.println(pr.getTableau().getHtml());
        JournalCaisseLibComplet[] liste=(JournalCaisseLibComplet[])pr.getTableau().getData();

        double totalCredit=AdminGen.calculSommeDouble(liste,"montant");
%>   
    <table class="table table-striped table-bordered table-condensed table-responsive tree" >
        <tr>
            <th align="right"></th>
            <th width="14%">TOTAL</th>
        </tr>
        <tr>
            <td align="right"></td>
            <td align="right"><%=Utilitaire.formaterAr(totalCredit)%></td>
        </tr>
    </table>

    <% }else{
        %><center><h4>Aucun details </h4></center><%
    }
}catch(Exception e){
    e.printStackTrace();
}%>
