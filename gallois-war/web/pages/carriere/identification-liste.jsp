<%-- 
    Document   : identification-liste
    Created on : 29 nov. 2019, 09:51:24
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.InfoPersonnelGlobal"%>
<%@page import="mg.spat.Navire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.PrevisionMaterielNaval"%>

<% 
    InfoPersonnelGlobal info = new InfoPersonnelGlobal();
    //info.setNomTable("");
    String listeCrt[] = {"id","nom","prenom","numero_cin","numero_matricule","datenaissance","date_embauche"};
    String listeInt[] = {"datenaissance","date_embauche"};
    String libEntete[] = {"id","nom","prenom","adresse","genre","numero_cin","telephone","mail","numero_matricule","type_contrat"
            ,"categorie","poste","direction","anciennete_poste","situation_matrimoniale","nom_prenom_epoux",
            "nom_prenom_pere","nom_prenom_mere","datenaissance","date_embauche","age","anciennete"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/identification-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste identification</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/identification-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/identification-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Nom","Prenom","Adresse","Genre","Numero cin","Telephone","Mail","Numero matricule","Type contrat"
            ,"Categorie","Poste","Direction","Anciennete Poste","Situation matrimoniale","Nom prenom epoux",
            "Nom prenom pere","Nom prenom mere","Date naissance","Date embauche","Age","Anciennete"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

