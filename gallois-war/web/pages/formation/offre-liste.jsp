<%-- 
    Document   : offre-liste
    Created on : 13 oct. 2015, 11:36:24
    Author     : Jetta
--%>

<%@page import="mg.cnaps.formation.FormOffreFormation"%>

<%@page import="affichage.PageRecherche"%>
<%
    try {

        FormOffreFormation lv = new FormOffreFormation();
        String etat = "FORM_OFFRE_FORMATION_LIBELLE3";
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            etat = request.getParameter("etat");
        }
        lv.setNomTable(etat);

        String listeCrt[] = {"id", "id_type", "log_service", "date_debut", "date_fin", "lieu", "cout_offre"};
        String listeInt[] = {"date_debut", "date_fin"};
        String libEntete[] = {"id", "id_type", "log_service", "date_debut", "date_fin", "lieu", "cout_offre"};
        PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 7);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("id_type").setLibelle("Type");
        pr.getFormu().getChamp("log_service").setLibelle("Service");
        pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
        pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
        pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
        pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
        pr.getFormu().getChamp("cout_offre").setLibelle("Co&ucirc;t");
        pr.setApres("formation/offre-liste.jsp");
        String[] colSomme = {"cout_offre"};

        pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des offres de formation </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/offre-liste.jsp" method="post" name="offre" id="offre">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <br>
            <div class=row>
                <div class="col-md-4"></div>
                <div class="col-md-4" align="center">
                    Etat : 
                    <select name="etat" class="champ form-control" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_OFFRE_FORMATION_LIBELLE3") == 0) {%>    
                        <option value="FORM_OFFRE_FORMATION_LIBELLE3" selected>Tous</option>
                        <% } else { %>
                        <option value="FORM_OFFRE_FORMATION_LIBELLE3" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_OFFRE_FORMATION_CREE") == 0) {%>    
                        <option value="FORM_OFFRE_FORMATION_CREE" selected>Créée</option>
                        <% } else { %>
                        <option value="FORM_OFFRE_FORMATION_CREE" >Créée</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_OFFRE_FORMATION_ANNULE") == 0) {%>    
                        <option value="FORM_OFFRE_FORMATION_ANNULE" selected>Annulé</option>
                        <% } else { %>
                        <option value="FORM_OFFRE_FORMATION_ANNULE" >Annulé</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_OFFRE_FORMATION_VISE") == 0) {%>    
                        <option value="FORM_OFFRE_FORMATION_VISE" selected>Visé</option>
                        <% } else { %>
                        <option value="FORM_OFFRE_FORMATION_VISE" >Visé</option>
                        <% } %>
                    </select>
                </div>
            </div>

            <br>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=formation/offre-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
                String libEnteteAffiche[] = {"id", "Type", "Service", "Date d&eacute;but", "Date fin", "Lieu", "Co&ucirc;t"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                out.println(pr.getTableau().getHtml());
                out.println(pr.getBasPage());

            } catch (Exception e) {
                e.printStackTrace();
            }

        %>
    </section>
</div>
<script>
    function changerDesignation()
    {
        document.offre.submit();
    }
</script>