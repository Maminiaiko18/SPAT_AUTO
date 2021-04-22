<%-- 
    Document   : liste-personnel-permanent
    Created on : 6 janv. 2020, 16:48:24
    Author     : john
--%>

<%@page import="mg.spat.relationhumaine.Personnel"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Personnel menu = new Personnel();
    String listeCrt[] = {"id","nom","prenom","numeromatricule","genre","categorie","poste", "direction","qualification"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","prenom","datenaissance","adresse","telephone","mail","numeromatricule","genre","categorie","poste", "direction","qualification"};
    PageRecherche pr = new PageRecherche(menu, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("numeromatricule").setLibelle("Numéro matricule");
    pr.setApres("rh/personnel-liste.jsp");
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
        <h1>Liste personnel</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=rh/personnel-liste.jsp" method="post" name="listepersonnelpermanent" id="listepersonnelpermanent">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            //String lienTableau[] = {pr.getLien() + "?but=rh"
                 //   + "/statistique-activite-fiche.jsp"};
            //String colonneLien[] = {"id"};
           // pr.getTableau().setLien(lienTableau);
            //pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            //String libEnteteAffiche[] = {"sa_compteurnumero","matriculesalarie","nom","prenom","sexe","telephone","numsalarie","emploioccupe","categorie"};
            String libEnteteAffiche[] = {"Id","Nom","Prenom","Date de Naissance","Adresse","Telephone","Mail","Numero Matricule","Genre","Categorie","Poste", "Direction","Qualification"};
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


