
<%@page import="mg.spat.BonCommande"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@page import="facture.FactureClient"%>

<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        FactureClient mvt = new FactureClient();
        mvt.setNomTable("FACTURECLIENTMSUM_LIB");

        String listeCrt[] = {"tierslib", "designation", "daty", "date_echeance"};
        String listeInt[] = {"daty", "date_echeance"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id","daty","tierslib","designation","date_echeance"};
        String somDefaut[] = {"montant", "montanttva", "montantttc", "montantavoir"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, somDefaut.length);

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("date_echeance1").setLibelle("Date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("Date echeance fin");
        
        pr.setApres("facture/analyse-facture-client-vaovao.jsp");
        String colGroupe[] = {"montant", "montanttva", "montantttc"};
        pr.creerObjetPage(colGroupe);
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
        <form action="<%=pr.getLien()%>?but=facture/analyse-facture-client-vaovao.jsp" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="facture/analyse-facture-client-vaovao.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%  
            String lienTableau[] = { pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            pr.getTableau().setLien(lienTableau);
            String collien[] = {"id"};
            pr.getTableau().setColonneLien(collien);
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
