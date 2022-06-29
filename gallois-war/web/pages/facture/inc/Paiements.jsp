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
    String id = request.getParameter("id");
    JournalCaisseLibComplet cht = new JournalCaisseLibComplet();
    cht.setNomTable("journalcaisselibcomplet");
    String libEntete[] = {"id", "folio", "valcaisse","descetypecheque", "numPiece", "numcheque","libelle", "dateSaisie", "dateEffet", "credit", "debit","idplacement","numeroOP"};
    String listeCrt[] = {};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setAWhere(" and bonprovisoire='"+id+"'");
    
    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"credit","debit"};
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "folio", "valcaisse","descetypecheque", "numPiece", "numcheque","libelle", "dateSaisie", "dateEffet", "credit", "debit","idplacement","numeroOP"};
   // String lienTableau[] = {pr.getLien() + "?but=facture/bon-provisoire-fiche.jsp"};
    //String colonneLien[] = {"id"};
    //pr.getTableau().setLien(lienTableau);
   // pr.getTableau().setColonneLien(colonneLien);
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
%>
