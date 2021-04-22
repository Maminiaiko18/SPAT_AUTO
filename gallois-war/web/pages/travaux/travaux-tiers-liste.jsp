<%-- 
    Document   : travaux-tiers-liste
    Created on : 4 déc. 2019, 13:44:13
    Author     : john
--%>

<%@page import="mg.spat.Travaux_tiers"%>
<%@page import="mg.spat.Tiers"%>
<%@page import="mg.spat.Travaux"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Travaux_tiers t = new Travaux_tiers();
    t.setNomTable("travaux_tierslib");
    String listeCrt[] = {"id","idtravaux","idtiers","description"};
    String listeInt[] = {};
    String libEntete[] = {"id","idtravaux","idtiers","description","montant"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/travaux-tiers-liste.jsp");
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
        <form action="<%=pr.getLien()%>?but=travaux/travaux-tiers-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux"
                    + "/travaux-tiers-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Travaux","Tiers","Description","Montant"};
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





