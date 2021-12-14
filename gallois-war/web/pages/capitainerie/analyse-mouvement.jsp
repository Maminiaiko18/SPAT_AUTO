<%-- 
    Document   : analyse-mouvement
    Created on : 12 nov. 2019, 16:32:26
    Author     : john
--%>

<%@page import="mg.spat.AnalyseMouvement"%>
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
        AnalyseMouvement mvt = new AnalyseMouvement();
        //mvt.setNomTable("MVTLIBCOMPLETANALYSEUNION1");
        //mvt.setNomTable("MVTLIBCOMPLETANALYSEUNIONDATE");
        mvt.setNomTable("TOUCHE_DE_NAVIRE");

        
        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"id","nomnavire","desceconsignataire","valQUAISPROVENANCE","DESCEMVT","VALQUAISDESTINATION","date_depart","dateArrivee","typenavire"};
        String listeInt[] = {"date_depart","dateArrivee"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id","escale","nomnavire","desceconsignataire","valQUAISPROVENANCE","DESCEMVT","VALQUAISDESTINATION","dateArrivee","heure","date_depart","heure_depart","difference","typenavire"};
        String somDefaut[] = {"arrivee"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        //pr.setAWhere(" order by depart, arrivee");
        pr.getFormu().getChamp("date_depart1").setLibelle("Date depart min");
        pr.getFormu().getChamp("date_depart2").setLibelle("Date depart max");
        
        pr.getFormu().getChamp("dateArrivee1").setLibelle("Date arrive min");
        pr.getFormu().getChamp("dateArrivee2").setLibelle("Date arrive max");
        
        pr.getFormu().getChamp("desceconsignataire").setLibelle("Consignataire");
        pr.getFormu().getChamp("valQUAISPROVENANCE").setLibelle("Quais Provenance");
        
        pr.getFormu().getChamp("DESCEMVT").setLibelle("Mouvement");
        pr.getFormu().getChamp("VALQUAISDESTINATION").setLibelle("Quais Destination");
        pr.getFormu().getChamp("nomnavire").setLibelle("Navire");

        //pr.getFormu().getChamp("daty1").setDefaut(fin[0]);
      //  pr.getFormu().getChamp("daty2").setDefaut(fin[1]);
        pr.setOrdre(" order by dateArrivee desc, heure desc ");
        pr.setApres("capitainerie/analyse-mouvement.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse mouvement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="capitainerie/analyse-mouvement.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/mouvement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Escale","Navire","Consignataire","Quai Provenance","Type Mouvement","Quais Destination","Date arrivee","Heure arrivee","Date depart","Heure depart","Diff. (en j)","Type navire",""};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            if(request.getParameter("colGroupe1")!=null){
                String tablink[] = {pr.getLien() + "?but=capitainerie/analyse-mouvement.jsp"};
                String collink[] = {"arrivee"};
                pr.getTableau().setLien(tablink);
                pr.getTableau().setColonneLien(collink);
            }
            
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

