<%-- 
    Document   : diplomes-obtenus-liste
    Created on : 30 nov. 2019, 14:50:48
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.Diplome"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Diplome info = new Diplome();
    info.setNomTable("diplome_lib");
    String listeCrt[] = {"id", "idPersonnel", "titre", "options", "etablissement","annee_diplome"};
    String listeInt[] = {"annee_diplome"};
    String libEntete[] = {"id", "idPersonnel", "titre", "options", "etablissement","annee_diplome"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/diplomes-obtenus-liste.jsp");
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
        <h1>Liste diplome obtenus</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/diplomes-obtenus-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/diplomes-obtenus-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Personnel", "Titre", "Options", "Etablissement","Annee diplome"};
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



