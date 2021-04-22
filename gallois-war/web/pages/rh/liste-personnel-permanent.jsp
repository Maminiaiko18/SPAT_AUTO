<%-- 
    Document   : liste-personnel-permanent
    Created on : 6 janv. 2020, 16:48:24
    Author     : john
--%>

<%@page import="mg.spat.AnalysePersonnelPermanent"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    AnalysePersonnelPermanent menu = new AnalysePersonnelPermanent();
    menu.setNomTable("analyse_personnel_permanent");
    String listeCrt[] = {"sa_compteurnumero","nom","prenom","sexe","telephone","matriculesalarie","numsalarie"};
    String listeInt[] = {"numsalarie"};
    String libEntete[] = {"sa_compteurnumero","matriculesalarie","nom","prenom","sexe","telephone","numsalarie","emploioccupe","categorie"};
    PageRecherche pr = new PageRecherche(menu, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("sa_compteurnumero").setLibelle("Id");
    pr.getFormu().getChamp("matriculesalarie").setLibelle("Matricule salaire");
    pr.getFormu().getChamp("numsalarie1").setLibelle("Numero salaire min");
    pr.getFormu().getChamp("numsalarie2").setLibelle("Numero salaire max");
    pr.setApres("rh/liste-personnel-permanent.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listepersonnelpermanent.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste personnel permanent</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=rh/liste-personnel-permanent.jsp" method="post" name="listepersonnelpermanent" id="listepersonnelpermanent">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=rh"
                 //   + "/statistique-activite-fiche.jsp"};
            String colonneLien[] = {"id"};
           // pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            //String libEnteteAffiche[] = {"sa_compteurnumero","matriculesalarie","nom","prenom","sexe","telephone","numsalarie","emploioccupe","categorie"};
            String libEnteteAffiche[] = {"Id","Matricule salarie","Nom","Prenom","Sexe","Telephone","Numero salaire","Emploi occupe","Categorie"};
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


