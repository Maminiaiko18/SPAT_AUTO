<%-- 
    Document   : permission-liste
    Created on : 30 nov. 2019, 16:37:02
    Author     : Antsa
--%>

<%@page import="mg.spat.relationhumaine.Permission"%>
<%@page import="affichage.PageRecherche"%>
<% 
    Permission permission = new Permission();
    permission.setNomTable("permission_lib_etat");
    String listeCrt[] = {"id","idpersonnel", "objet", "date_debut_permission","date_fin_permission","nombre"};
    String listeInt[] = {"nombre","date_debut_permission","date_fin_permission"};
    String libEntete[] = {"id","idpersonnel", "objet", "date_debut_permission","date_fin_permission","nombre"};
    PageRecherche pr = new PageRecherche(permission, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/permission-liste.jsp");
    String[] colSomme = null;
    String where="";
    if(request.getParameter("table")!=null && request.getParameter("table").compareTo("0")!=0){
        where=" and etat="+request.getParameter("table");
        pr.setAWhere(where);
    }
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Permission</h1>
    </section>
    <section class="content">
         <form action="<%=pr.getLien()%>?but=carriere/permission-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                      <option value="0">Tous</option>
                      <option value="1">Cree</option>
                      <option value="11">Valider</option>
                    </select>
                </div>
            </div>
        </form>
        <form action="<%=pr.getLien()%>?but=carriere/permission-liste.jsp" method="post" name="listepermission" id="listepermission">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere/permission-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Personnel", "objet", "Date début Permission","Date Fin Permission","Nombre de jours"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
