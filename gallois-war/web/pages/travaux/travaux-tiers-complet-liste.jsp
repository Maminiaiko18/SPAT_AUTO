<%-- 
    Document   : travaux-tiers-complet-liste
    Created on : 4 déc. 2019, 17:25:26
    Author     : pro
--%>

<%@page import="mg.spat.TravauxTiersLibComplet"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    TravauxTiersLibComplet t = new TravauxTiersLibComplet();
    String listeCrt[] = {"id","idtravauxtiers","typetiers","nom","description","valtypetravaux","datedebut","datefin"};
    String listeInt[] = {"datedebut","datefin"};
    String libEntete[] = {"id","nom","description","idtravauxtiers","valtypetravaux","datedebut","datefin","nomtiers","descriptiontiers","avancement"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/travaux-tiers-complet-liste.jsp");
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
        <h1>Liste travaux tiers</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/travaux-tiers-complet-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Nom","Description","Travaux tiers","Type travaux","Date debut","Date fin","Tiers","Description","Avancement"};
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