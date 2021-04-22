<%-- 
    Document   : interim-liste
    Created on : 7 nov. 2016, 14:11:08
    Author     : Doudou
--%>

<%@page import="affichage.PageRecherche"%>
<%
    utilisateur.UtilisateurInterimLibTous hv = new utilisateur.UtilisateurInterimLibTous();
    if (request.getParameter("etat") != null && !request.getParameter("etat").equals("")) {
        hv.setNomTable(request.getParameter("etat") );
    }
    String listeCrt[] = {"id", "nom_u_interim", "matricule_u_interim", "nom_u_a_remplacer", "matricule_u_a_remplacer", "fonction", "direction", "service"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nom_u_interim", "matricule_u_interim", "nom_u_a_remplacer", "matricule_u_a_remplacer", "fonction", "direction", "service"};
    PageRecherche pr = new PageRecherche(hv, request, listeCrt, listeInt, 3, libEntete, 8);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("nom_u_interim").setLibelleAffiche("Interim");
    pr.getFormu().getChamp("matricule_u_interim").setLibelleAffiche("Matricule interim");

    pr.getFormu().getChamp("nom_u_a_remplacer").setLibelleAffiche("Utilisateur à remplacer");
    pr.getFormu().getChamp("matricule_u_a_remplacer").setLibelleAffiche("Matricule de l'utilisateur  à remplacer");

    pr.setApres("utilisateur/interim-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste   utilisateur par interim</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/interim-liste.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="form-control" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") == null || request.getParameter("etat").compareToIgnoreCase("") == 0) {%>    
                        <option value="" selected>Tous </option>
                        <% } else { %>
                        <option value="" >Tous </option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("UTILISATEUR_I_LIB_TER") == 0) {%>    
                        <option value="UTILISATEUR_I_LIB_TER" selected>Terminé</option>
                        <% } else { %>
                        <option value="UTILISATEUR_I_LIB_TER" >Terminé</option>
                        <% } %>
                      
                     
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("UTILISATEUR_I_L_ACT_NON_T") == 0) {%>
                        <option value="UTILISATEUR_I_L_ACT_NON_T" selected>Activé non terminé </option>
                        <% } else { %>
                        <option value="UTILISATEUR_I_L_ACT_NON_T">Activé non terminé </option>
                        <% } %>
                        
                         <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("UTILISATEUR_I_LIB_NON_ACTIVER") == 0) {%>
                        <option value="UTILISATEUR_I_LIB_NON_ACTIVER" selected> Non  Activé </option>
                        <% } else { %>
                        <option value="UTILISATEUR_I_LIB_NON_ACTIVER">  Non Activé </option>
                        <% } %>

                    </select></br></br>
                </div> 
                <div class="col-md-4"></div>
            </div><br/><br/>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=utilisateur/utilisateurInterim-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID", "INTERIM", "MATRICULE INTERIM", "UTILISATEUR A  REMPLACER", "MATRICULE DE L'UTILISATEUR A REMPLACER", "FONCTION", "direction", "service"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>