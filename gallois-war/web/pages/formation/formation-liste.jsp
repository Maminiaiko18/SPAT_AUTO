<%-- 
    Document   : formation-liste
    Created on : 13 oct. 2015, 10:57:04
    Author     : Jetta
--%>


<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.Utilitaire"%>
<% FormFormation lv = new FormFormation();
    String etat = "FORM_FORMATION_LIBELLE5";
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        etat = request.getParameter("etat");
    }
    lv.setNomTable(etat);
    String listeCrt[] = {"id", "type_demandeur", "id_type", "form_domaine", "etablissement", "log_service", "id_direction", "date_debut", "date_fin"};
    String listeInt[] = {"date_debut", "date_fin"};
    String libEntete[] = {"id", "type_demandeur", "id_type", "form_domaine", "etablissement", "log_service", "id_direction", "date_debut", "date_fin"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 9);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if (request.getParameter("tdb") != null && request.getParameter("tdb").compareToIgnoreCase("oui") == 0) {
        String anneeMin = request.getParameter("annemin");
        String anneeMax = request.getParameter("annemax");
        if (anneeMin.compareToIgnoreCase(anneeMax) == 0) {
            int volana = Integer.parseInt(request.getParameter("volana"));
            int annee = Integer.parseInt(request.getParameter("annemax"));
            pr.getFormu().getChamp("date_debut1").setDefaut(Utilitaire.moisEtAnneeToDate(volana, annee, "min"));
            pr.getFormu().getChamp("date_debut2").setDefaut(Utilitaire.moisEtAnneeToDate(volana, annee, "max"));
            pr.setAWhere("and date_debut >='" + Utilitaire.moisEtAnneeToDate(volana, annee, "min") + "' and date_debut <='" + Utilitaire.moisEtAnneeToDate(volana, annee, "max") + "'");
        }
    }

    pr.getFormu().getChamp("form_domaine").setLibelle("Domaine");
    pr.getFormu().getChamp("log_service").setLibelle("Service");
    pr.getFormu().getChamp("id_direction").setLibelle("Direction");
    pr.getFormu().getChamp("id_type").setLibelle("Type formation");

    pr.getFormu().getChamp("type_demandeur").setLibelle("Type demande");
    pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
    pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
    pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
    pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");

    pr.setApres("formation/formation-liste.jsp");
    String[] colSomme = {};
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste formation </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/formation-liste.jsp" method="post" name="demande" id="demande">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <br>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <label for="etat">Etat :</label>
                    <select name="etat" class="champ form-control" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_FORMATION_LIBELLE4") == 0) {%>    
                        <option value="FORM_FORMATION_LIBELLE5" selected>Tous</option>
                        <% } else {%>
                        <option value="FORM_FORMATION_LIBELLE5" >Tous</option>
                        <% }%>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_FORMATION_ETAT_CREE") == 0) {%>    
                        <option value="FORM_FORMATION_ETAT_CREE" selected>Créée</option>
                        <% } else {%>
                        <option value="FORM_FORMATION_ETAT_CREE" >Créée</option>
                        <% }%>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_FORMATION_ETAT_ANNULE") == 0) {%>    
                        <option value="FORM_FORMATION_ETAT_ANNULE" selected>Annulé</option>
                        <% } else {%>
                        <option value="FORM_FORMATION_ETAT_ANNULE" >Annulé</option>
                        <% }%>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_FORMATION_ETAT_VISE") == 0) {%>    
                        <option value="FORM_FORMATION_ETAT_VISE" selected>Visé</option>
                        <% } else {%>
                        <option value="FORM_FORMATION_ETAT_VISE" >Visé</option>
                        <% }%>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_FORMATION_REALISE") == 0) {%>    
                        <option value="FORM_FORMATION_REALISE" selected>Réalisé</option>
                        <% } else {%>
                        <option value="FORM_FORMATION_REALISE" >Réalisé</option>
                        <% }%>
                    </select>
                </div>
            </div>
            <br>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=formation/formation-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Type demande", "Type formation", "Domaine", "Etablissement", "Service", "Direction", "Date debut", "Date fin"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
    <script>
        $(document).ready(ajouterDatePicker());

        function  ajouterDatePicker()
        {
            var ddebut = $("#date_debut1");
            var ncdebut = ddebut.attr("class") + " datepicker";
            ddebut.attr("class", ncdebut);
				
            ddebut = $("#date_debut2");
            ncdebut = ddebut.attr("class") + " datepicker";
            ddebut.attr("class", ncdebut);

				
            var dfin = $("#date_fin1");
            var ncfin = dfin.attr("class") + " datepicker";
            dfin.attr("class", ncfin);
				
            dfin = $("#date_fin2");
            ncfin = dfin.attr("class") + " datepicker";
            dfin.attr("class", ncfin);

				
            $('.datepicker').datepicker(
            {
                "setDate": new Date(),
                "autoclose": true
            }
        );
        } 	
    </script>
    <script>
        function changerDesignation() 
        {	
            document.demande.submit();
        }
    </script>
</div>