<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    JournalCaisseLibComplet jc = new JournalCaisseLibComplet();
    jc.setNomTable("JOURNALCAISSELIBCOMPLET");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","folio","valcaisse","numPiece","libelle","remarque","dateSaisie","dateEffet","debit","credit"};
    PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setAWhere(" and caisse like '%"+request.getParameter("idcaisse")+"%' and dateEffet = to_date('"+request.getParameter("daty")+"','YYYY-MM-DD')");
    String[] colSomme = null;
    pr.setNpp(100);
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] ={"Id","Folio","Caisse","Num Piece","Libelle","Remarque","Date Saisie","Date Effet","Debit","Credit"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
        }
        else
            {
               %><center><h4>Aucune donn&eacute;e trouv&eacute;e</h4></center><%
        }
    %>
</div>
<% }catch (Exception e) {
        e.printStackTrace();
    }%>