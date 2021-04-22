<%-- 
    Document   : lignecredit-liste
    Created on : 9 févr. 2021, 09:21:27
    Author     : ACER
--%>

<%@page import="projet.Projet"%>
<%@page import="lignecredit.LigneCredit"%>

<%@page import="affichage.PageRecherche"%>

<% try{ 
    LigneCredit lc = new LigneCredit();
    lc.setNomTable("LIGNECREDIT_lib");
    String listeCrt[] = {"id", "designation", "compte", "annee", "mois", "idtypelingecredit"};

    String listeInt[] = {"annee","mois"};
    String libEntete[] = {"id", "designation", "creditinitial", "compte", "annee", "mois", "idtypelingecredit"};
    PageRecherche pr = new PageRecherche(lc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.getFormu().getChamp("annee1").setLibelle("Annee min");
    pr.getFormu().getChamp("annee2").setLibelle("Annee max");
    pr.getFormu().getChamp("mois1").setLibelle("Mois min");
    pr.getFormu().getChamp("mois2").setLibelle("Mois max");
    pr.getFormu().getChamp("idtypelingecredit").setLibelle("Type ligne crédit");
            
    pr.setApres("budget/lignecredit-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listestatistiqueactivite.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste ligne crédit</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=budget/lignecredit-liste.jsp" method="post" name="listestatistiqueactivite" id="listestatistiqueactivite">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=budget/lignecredit-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "désignation", "crédit initial", "compte", "année", "mois", "type ligne crédit"};
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