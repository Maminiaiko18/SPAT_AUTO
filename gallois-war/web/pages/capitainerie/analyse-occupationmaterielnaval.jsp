<%@page import="mg.spat.AnalyseOccupationMaterielNaval"%>
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
        AnalyseOccupationMaterielNaval mvt = new AnalyseOccupationMaterielNaval();
        
       String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String listeCrt[] = {"id","idmateriel_naval","idnatureoperation","idmanoeuvrebord","idnavire","daty"};
        String listeInt[] = {"daty"};
//        String colDefaut[] = {"idmateriel_naval"};
        String colDefaut[] = {"id","idnavire","escale","idmateriel_naval", "idnatureoperation",
            "idmanoeuvrebord","daty","heuredebut","datefin",
        "heurefin"};
        String[] pourcentage = {""};
        //String colDefaut[] = { "id","escale", "daty", "heure", "nomnavire", "valconsignataire", "pavillonnavire","quaiprovenance", "typemvt", "quaidestination"};
        String somDefaut[] = {"duree"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 14, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by datefin desc");
        pr.getFormu().getChamp("daty1").setLibelle("Date mouvement min");
        pr.getFormu().getChamp("daty2").setLibelle("Date mouvement max");
//
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
     
        pr.getFormu().getChamp("idmateriel_naval").setLibelle("Mat&eacute;riel naval");
        pr.getFormu().getChamp("idnatureoperation").setLibelle("Nature de l'op&eacute;ration");
        pr.getFormu().getChamp("idmanoeuvrebord").setLibelle("Manoeuvre bord");
        pr.getFormu().getChamp("idnavire").setLibelle("Navire");
       
        
        pr.setApres("capitainerie/analyse-occupationmaterielnaval.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse prestation</h1>
    </section>
    <section class="content">
         <form action='<%= pr.getLien() + "?but="+pr.getApres() %>' method="post" name="analyse" id="analyse">
            <% out.println(pr.getFormu().getHtmlEnsemble()); %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID","Navire","Escale","Matériel naval","Nature opération","Manoeuvre bord","Date d'arrivée","Heure d'arrivée","Date de depart","Heure de depart","Duree"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            
            if(request.getParameter("colGroupe1")!=null){
                String lienTableau[] = {pr.getLien() + "?but=capitainerie/analyse-occupationmaterielnaval.jsp"};
                String colonneLien[] = {"duree"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setColonneLien(colonneLien);
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
    }
%>
