<%-- 
    Document   : analye-conge
    Created on : 21 janv. 2020, 11:31:31
    Author     : Asus
--%>


<%@ page import="mg.spat.relationhumaine.CongePersonnel"%>
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
        CongePersonnel mvt = new CongePersonnel();
        //mvt.setNomTable("v_analyse_bon_commande_analyse");
        mvt.setNomTable("analyse_permission_personnel");

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String fin = String.valueOf(utilitaire.Utilitaire.getNombreJourMois(mois, an));

       String listeCrt[] = {"id","matriculesalarie","nom","prenom","genre","date_debut","date_fin"};
        String libEntete[] = {"id","matriculesalarie","nom","prenom","genre","dateNaissance","date_debut","date_fin","nombre"};
        String listeInt[] = {"dateNaissance","date_debut","date_fin"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id","matriculesalarie","nom","prenom","genre","dateNaissance","date_debut","date_fin"};
        String somDefaut[] = {"nombre"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 8, 2);

        pr.getFormu().getChamp("matriculesalarie").setLibelle("Numero Matricule Salaire");
        //pr.getFormu().getChamp("dateNaissance").setLibelle("Date de Naissance");
        //pr.getFormu().getChamp("date_debut").setLibelle("Date Debut");
        //pr.getFormu().getChamp("date_fin").setLibelle("Date Fin");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("rh/analyse-permission.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Permission</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="rh/analyse-permission.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Numero Matricule Salaire", "Nom", "Prénom", "Genre", "Date de Naissance", "Début", "Fin", "Nombre"};

            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
           
           
           // pr.getTableau().setColonneLien(somDefaut);
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

