<%@page import="facture.FactureClientDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        FactureClientDetails lv = new FactureClientDetails();
        lv.setNomTable("facture_client_fille_lib");
        String listeCrt[] = {"categorieClientlib", "categorieFacturelib"};
        String listeInt[] = {};

        String[] pourcentage = {};
        String somDefaut[] ={"montanttaux"}; //sum
        String colDefaut[] =  {"categorieFacturelib"}; // colonne
        String[] colGrCol = {"categorieClientlib"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("categorieClientlib").setLibelle("Catégorie Client");
        pr.getFormu().getChamp("categorieFacturelib").setLibelle("Catégorie Facture");
        
        pr.setApres("facture/facture-client-fille-analyse.jsp");
        pr.creerObjetPageCroise(colDefaut, pr.getLien()+"?but="+pr.getApres());

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Facture Client</h1>
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
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>