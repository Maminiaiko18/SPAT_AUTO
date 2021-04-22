<%-- 
    Document   : parcours-professionnel-liste
    Created on : 29 nov. 2019, 09:57:11
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.Parcours_professionnel"%>
<%@page import="mg.spat.relationhumaine.InfoProfessionnel"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Parcours_professionnel info = new Parcours_professionnel();
    info.setNomTable("parcours_professionnel_lib");
    String listeCrt[] = {"id","idPersonnel","poste_occupe","societe"};
    String listeInt[] = {"annee_parcours_pro"};
    String libEntete[] = {"id","idPersonnel","poste_occupe","societe","annee_parcours_pro","duree"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("carriere/parcours-professionnel-liste.jsp");
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
        <h1>Liste parcours professionnel</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/parcours-professionnel-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/parcours-professionnel-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Personnel","Poste occupe","Societe","Annee parcours professionnel","Duree"};
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


