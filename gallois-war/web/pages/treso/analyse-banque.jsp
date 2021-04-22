
<%@page import="mg.spat.compta.JournalBanque"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>

<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        JournalBanque journal = new JournalBanque();
        journal.setNomTable("journalcaisse_analyse");

        String listeCrt[] = {"id", "folio", "caisse", "numpiece", "libelle", "dateeffet"};
        String listeInt[] = {"dateeffet"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id", "folio", "caisse", "numpiece", "libelle", "dateeffet"};
        String somDefaut[] = null;
        
        if(request.getParameter("type") != null && request.getParameter("type").equals("debit")){
            somDefaut = new String[] {"debit"};
        }else if(request.getParameter("type") != null && request.getParameter("type").equals("credit")){
            somDefaut = new String[] {"credit"};
        }
        
        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, 2);
        if(request.getParameter("type") != null && request.getParameter("type").equals("debit")){
            pr.setAWhere(" and credit = 0");
        }else if(request.getParameter("type") != null && request.getParameter("type").equals("credit")){
            pr.setAWhere(" and debit = 0");
        }
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        
      
        pr.getFormu().getChamp("dateeffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateeffet2").setLibelle("Date effet max");
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/analyse-banque.jsp&type="+request.getParameter("type"));
        pr.creerObjetPage();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="treso/analyse-banque.jsp" />
            <input type="hidden" name="type" value="<%=request.getParameter("type")%>" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            //String libEnteteAffiche[] = {"Id", "Folio", "Caisse", "Num piece", "Libelle", "Remarque","Date saisie", "Date effet","Montant"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
             String lienTableau[] = {pr.getLien() + "?but=treso/depense-liste.jsp"};
            String colonneLien[] = {"debit"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
