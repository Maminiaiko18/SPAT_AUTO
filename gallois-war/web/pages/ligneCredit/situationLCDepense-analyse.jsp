
<%@page import="lignecredit.LigneCredit"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Parametre"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {
        UserEJB u = (user.UserEJB) session.getValue("u");
        LigneCredit recap = new LigneCredit();
        recap.setNomTable("SITUATIONLCDEPENSEGRP");
        String listeCrt[] = {"projet","direction","annee"};
        String listeInt[] = {};
        String[] pourcentage = {};
        String colDefaut[] =  {"direction"};//colonne
        String[] somDefaut =  {"MONTANT","ENGAGEER","FACTURE","POURCENGAGE","PAYE","POURCPAYE","ARECOUVRIR","RESTEBUDGET","RESTEAPRESENGMT"};// sum

        PageRechercheGroupe pr = new PageRechercheGroupe(recap, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, somDefaut.length);
        
        pr.setUtilisateur(u);
        pr.setLien((String) session.getValue("lien"));
        
        pr.getFormu().getChamp("annee").setDefaut(Utilitaire.getAnneeEnCours());
        pr.setApres("ligneCredit/situationLCDepense-analyse.jsp");
        pr.setNpp(100);
        pr.creerObjetPage();


%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse dépense</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres()%>" method="post" name="formulaire" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
        %>
        <br>
        <%
            out.println(pr.getBasPage());
        %>
    </section>


    <% //out.println(pr.getBasPage()); %>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>