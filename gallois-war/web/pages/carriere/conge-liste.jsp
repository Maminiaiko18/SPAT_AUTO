<%-- 
    Document   : conge-liste
    Created on : 30 nov. 2019, 15:09:00
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.Conge"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Conge info = new Conge();
    info.setNomTable("conge_lib_etat");
    String listeCrt[] = {"id","idPersonnel","disponibilite","date_debut_conge","date_fin_conge","nombre"};
    String listeInt[] = {"date_debut_conge","date_fin_conge","nombre"};
    String libEntete[] = {"id","idPersonnel","disponibilite","date_debut_conge","date_fin_conge","nombre"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    String where="";
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/conge-liste.jsp");
    if(request.getParameter("table")!=null && request.getParameter("table").compareTo("0")!=0){
        where=" and etat="+request.getParameter("table");
        pr.setAWhere(where);
    }
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste conge </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/conge-liste.jsp" method="post" name="incident" id="incident">
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
        <form action="<%=pr.getLien()%>?but=carriere/conge-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/conge-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Personnel","Disponibilite","Date debut conge","Date fin conge","Nombre de jours"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>
