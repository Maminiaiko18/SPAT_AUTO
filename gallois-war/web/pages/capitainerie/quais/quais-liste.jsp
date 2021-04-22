<%-- 
    Document   : quais-liste
    Created on : 22 nov. 2019, 09:06:34
    Author     : john
--%>

<%@page import="mg.spat.Quais"%>
<%@page import="mg.spat.Navire"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    Quais quais = new Quais();
    quais.setNomTable("quaislib");
     
    String listeCrt[] = {"id","val","typequais","pays"};
    String listeInt[] = {};
    String libEntete[] = {"id","val","typequais","pays","longueur","profondeur"};
    PageRecherche pr = new PageRecherche(quais, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("typequais").setLibelle("type quais");
    pr.getFormu().getChamp("val").setLibelle("Quais");
    pr.getFormu().getChamp("pays").setLibelle("Pays");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("capitainerie/quais/quais-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste quais</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/quais/quais-liste.jsp" method="post" name="listequais" id="listequais">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie"
                    + "/quais/quais-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Quais","Type Quais","Pays","Longueur","Profondeur"};
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
