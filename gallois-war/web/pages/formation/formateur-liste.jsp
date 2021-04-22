<%-- 
    Document   : formateur-liste
    Created on : 13 oct. 2015, 10:04:29
    Author     : Jetta
--%>

<%@page import="mg.cnaps.formation.FormFormateur"%>
<%@page import="affichage.PageRecherche"%>
<% FormFormateur lv = new FormFormateur();
    lv.setNomTable("FORM_FORMATEUR_LIBELLE_2");
    
    String listeCrt[] = {"id", "nom", "niveau", "experience", "desce","id_etablissement"};
    String listeInt[] = null;
    String libEntete[] = {"id", "nom", "niveau", "experience", "desce","id_etablissement"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("desce").setLibelle("Description");
    pr.getFormu().getChamp("Id_etablissement").setLibelle("Id etablissement");
	pr.getFormu().getChamp("Experience").setLibelle("Expérience");//Experience
	
    pr.setApres("configuration/formateur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste FORMATEURS</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=configuration/formateur-liste.jsp" method="post" name="demande" id="demande">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=configuration/formateur-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID", "Nom", "Niveau", "Exp&eacute;rience", "Description","Etablissement"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
