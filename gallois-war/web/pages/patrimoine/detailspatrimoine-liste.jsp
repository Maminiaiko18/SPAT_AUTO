
<%@page import="mg.spat.DetailsPatrimoine"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    DetailsPatrimoine s = new DetailsPatrimoine();
    s.setNomTable("DETAILSPATRIMOINE_LIB");
    String listeCrt[] = {"id","idPatrimoine","natureObjet","surfaceOccupe","surfaceDisponible"};
    String listeInt[] = {"surfaceOccupe","surfaceDisponible"};
    String libEntete[] = {"id","idPatrimoine","natureObjet","surfaceOccupe","surfaceDisponible","remarque","utilisateur"};
    PageRecherche pr = new PageRecherche(s, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.getFormu().getChamp("idPatrimoine").setLibelle("Patrimoine");
    pr.getFormu().getChamp("natureObjet").setLibelle("Nature");
    pr.getFormu().getChamp("surfaceOccupe1").setLibelle("Surface occupée min");
    pr.getFormu().getChamp("surfaceOccupe2").setLibelle("Surface occupée max");
    pr.getFormu().getChamp("surfaceDisponible1").setLibelle("Surface disponible min ");
    pr.getFormu().getChamp("surfaceDisponible2").setLibelle("Surface disponible max");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("patrimoine/detailspatrimoine-liste.jsp");
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
        <h1>Liste des détails patrimoine</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=patrimoine/detailspatrimoine-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=patrimoine/detailspatrimoine-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Patrimoine","Nature","Surface Occupée","Surface Disponible","Remarque","Utilisateur"};
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





