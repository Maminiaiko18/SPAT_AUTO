<%-- 
    Document   : formOffreChoix
    Created on : 13 oct. 2015, 13:38:44
    Author     : user
--%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="mg.cnaps.formation.FormOffreFormation"%>
<%
    String champReturn = request.getParameter("champReturn");
    FormOffreFormation e = new FormOffreFormation();
    e.setNomTable("form_offre_formation_libelle");
    String listeCrt[]={"id","id_type", "id_formateur","date_debut","date_fin","etablissement"};
    String listeInt[]={"date_debut","date_fin"};
    String libEntete[]={"id","id_type", "id_formateur","date_debut","date_fin","etablissement"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("formOffreChoix.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("id_type").setLibelleAffiche("Type");
    pr.getFormu().getChamp("id_formateur").setLibelleAffiche("Formateur");
    pr.getFormu().getChamp("date_debut1").setLibelleAffiche("Date début Min");
    pr.getFormu().getChamp("date_debut2").setLibelleAffiche("Date début Max");
    pr.getFormu().getChamp("date_fin1").setLibelleAffiche("Date fin Min");
    pr.getFormu().getChamp("date_fin2").setLibelleAffiche("Date fin Max");
    pr.getFormu().getChamp("etablissement").setLibelleAffiche("Etablissement");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cynthia 2.0 | CNaPS</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Offre de formation</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="offre" id="offre">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
//                    String lienTableau[] = {pr.getLien() + "?but=employeur/employeur-fiche.jsp"};
//                    String colonneLien[] = {"id"};
                    String libelles[]={"ID","Type", "Formateur","Date début","Date fin","Etablissement"};
//		    pr.getTableau().setLien(lienTableau);
//                    pr.getTableau().setColonneLien(colonneLien);
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
