<%-- 
    Document   : renseignement-interne-liste
    Created on : 30 nov. 2019, 12:38:40
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.Renseigement_interne"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Renseigement_interne info = new Renseigement_interne();
    info.setNomTable("renseignement_interne_lib");
    String listeCrt[] = {"id","idPersonnel","libelle","type","observation","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","idPersonnel","libelle","type","observation","daty"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
   // pr.getFormu().getChamp("daty").setLibelle("Date");
    pr.setApres("carriere/renseignement-interne-liste.jsp");
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
        <h1>Liste renseignement interne</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=carriere/renseignement-interne-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/renseignement-interne-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Personnel","Libelle","Type","Observation","Date"};
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




