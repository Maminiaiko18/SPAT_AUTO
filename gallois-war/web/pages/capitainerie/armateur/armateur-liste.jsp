<%-- 
    Document   : quais-liste
    Created on : 22 nov. 2019, 09:06:34
    Author     : john
--%>

<%@page import="mg.spat.Quais"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Armateur"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    Armateur quais = new Armateur();
    quais.setNomTable("armateur");
     
    String listeCrt[] = {"id","nom", "adresse"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","contact","adresse","nif","stat", "mail"};
    PageRecherche pr = new PageRecherche(quais, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    pr.getFormu().getChamp("adresse").setLibelle("Adresse");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("capitainerie/armateur/armateur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste armateur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/armateur/armateur-liste.jsp" method="post" name="listequais" id="listequais">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie"
                    + "/armateur/armateur-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID","Nom","Contact","Adresse","NIF","STAT", "Email"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            //pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
