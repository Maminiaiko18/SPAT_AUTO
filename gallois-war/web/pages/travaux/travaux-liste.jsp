<%-- 
    Document   : travaux-liste
    Created on : 4 déc. 2019, 13:13:10
    Author     : john
--%>


<%@page import="mg.spat.Travaux"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Travaux info = new Travaux();
    info.setNomTable("travauxlib");
    String listeCrt[] = {"id","nom","description","datedebut","datefin","PROJETLIB","CODEETABLISSEMENTLIB"};
    String listeInt[] = {"datedebut","datefin"};
    String libEntete[] = {"id","PROJETLIB","CODEETABLISSEMENTLIB","nom","description","datedebut","datefin","iddevise"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/travaux-liste.jsp");
    pr.getFormu().getChamp("datedebut1").setLibelle("Date Debut min");
    pr.getFormu().getChamp("datedebut2").setLibelle("Date Debut max");
    pr.getFormu().getChamp("datefin1").setLibelle("Date Fin min");
    pr.getFormu().getChamp("datefin2").setLibelle("Date Fin max");
    pr.getFormu().getChamp("PROJETLIB").setLibelle("Projet");
    pr.getFormu().getChamp("CODEETABLISSEMENTLIB").setLibelle("code Etab");

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
        <h1>Liste travaux</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/travaux-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux"
                    + "/travaux-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Projet","Code Etab","Nom","Description","Date debut","Date fin","Devise"};
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



