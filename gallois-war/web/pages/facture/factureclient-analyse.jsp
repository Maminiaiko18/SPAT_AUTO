
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
    try {
        FactureClientDetails base = new FactureClientDetails();
        base.setNomTable("FCFILLECOMPLET_ANALYSE");

        String listeCrt[] = {"daty", "libellerubrique", "catclient"};
        String listeInt[] = {"daty"};
        String colDefaut[] = {"libellerubrique", "catclient"};
        String[] pourcentage = {};
        String somDefaut[] = {"montantttc"};
        PageRechercheGroupe pr = new PageRechercheGroupe(base, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, somDefaut.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/factureclient-analyse.jsp");

        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);
        
        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);
            pr.setAWhere(" and daty>='"+debutDate+"' and daty<='"+dateFin+"'");
        }
        
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
//        pr.getFormu().getChamp("daty1").setDefaut(debutDate);
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        //pr.getFormu().getChamp("daty2").setDefaut(dateFin);
        pr.getFormu().getChamp("libellerubrique").setLibelle("Rubrique");

        /*String date1 = request.getParameter("daty1");
        String date2 = request.getParameter("daty2");
        String awhere = "";
        if(date1 == null || date1.trim().isEmpty()){
            awhere += String.format(" and daty >=  '%s' ", debutDate);
        }
        if(date2 == null || date2.trim().isEmpty()){
            awhere += String.format(" and daty <=  '%s' ", dateFin);
        }*/
//        pr.setAWhere(awhere);
        pr.creerObjetPage();
        
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse facture client</h1>
    </section>
    <section class="content">
        <form action='<%= pr.getLien() + "?but=" + pr.getApres()%>' method="post" name="analyse" id="analyse">
            <% out.println(pr.getFormu().getHtmlEnsemble()); %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <% out.println(pr.getTableauRecap().getHtml()); %>
        <br>
        <%
//            String libEnteteAffiche[] = {"Id", "Daty", "Tiers", "Type client", "Escale", "Désignation", "Categorie", "Tva", "Date echeance", "Montant", "Montant TVA", "Montant TTC", "Montant Avoir", "Montant paye","Montant reste"};
//            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
