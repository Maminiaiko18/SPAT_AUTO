<%-- 
    Document   : enfant-personnel-liste
    Created on : 30 nov. 2019, 14:23:36
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.Enfant_personnel"%>
<%@page import="mg.spat.relationhumaine.InfoCongePermission"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Enfant_personnel info = new Enfant_personnel();
    info.setNomTable("enfant_personnel_lib");
    String listeCrt[] = {"id","idPersonnel","nom_prenom_enfant","dateNaissanceEnfant"};
    String listeInt[] = {"dateNaissanceEnfant"};
    String libEntete[] = {"id","idPersonnel","nom_prenom_enfant","dateNaissanceEnfant"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/enfant-personnel-liste.jsp");
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
        <h1>Liste enfant personnel</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/enfant-personnel-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/enfant-personnel-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Personnel","Nom prenom enfant","Date Naissance Enfant"};
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
