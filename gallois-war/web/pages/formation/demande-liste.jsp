<%-- 
    Document   : demande-liste
    Created on : 13 oct. 2015, 10:26:05
    Author     : Jetta
--%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%@page import="affichage.PageRecherche"%>
<% 
    FormDemande lv = new FormDemande();
    String etat = "FORM_DEMANDE_LIB_TOUS";
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) etat = request.getParameter("etat");
    lv.setNomTable(etat);
    
    String listeCrt[] = {"id", "type_demandeur", "id_type", "form_domaine", "id_etablissement", "log_service",  "date_debut","date_fin"};
    String listeInt[] = {"date_debut","date_fin"};
    String libEntete[] = {"id", "type_demandeur", "id_type", "form_domaine", "id_etablissement", "log_service", "date_debut","date_fin"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 8);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
    pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
    pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
    pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
    pr.getFormu().getChamp("type_demandeur").setLibelle("Type demande");
    pr.getFormu().getChamp("id_type").setLibelle("Type de formation");
    pr.getFormu().getChamp("form_domaine").setLibelle("Domaine");
    pr.getFormu().getChamp("id_etablissement").setLibelle("Etablissement");
    pr.getFormu().getChamp("log_service").setLibelle("Service");
    pr.setApres("formation/demande-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des demandes de formation </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/demande-liste.jsp" method="post" name="demande" id="demande">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <br>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4" align="center">
                    Etat :
                    <select name="etat" class="champ form-control" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_DEMANDE_LIB_TOUS") == 0) {%>    
                        <option value="FORM_DEMANDE_LIB_TOUS" selected>Tous</option>
                        <% } else { %>
                        <option value="FORM_DEMANDE_LIB_TOUS" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_DEMANDE_LIB_CREE") == 0) {%>    
                        <option value="FORM_DEMANDE_LIB_CREE" selected>Créé</option>
                        <% } else { %>
                        <option value="FORM_DEMANDE_LIB_CREE" >Créé</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("FORM_DEMANDE_LIB_VISEE") == 0) {%>    
                        <option value="FORM_DEMANDE_LIB_VISEE" selected>Visé</option>
                        <% } else { %>
                        <option value="FORM_DEMANDE_LIB_VISEE" >Visé</option>
                        <% } %>
                    </select>
                </div>
            </div>
            
            <br>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=formation/demande-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] =  {"id", "Type demande", "Type de formation", "Domaine", "Etablissement", "Service","Date d&eacute;but","Date fin"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
        <script>
function changerDesignation() 
{	
    document.demande.submit();
}
</script>