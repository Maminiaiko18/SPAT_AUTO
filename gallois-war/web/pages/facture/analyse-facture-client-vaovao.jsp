<%@page import="affichage.Liste"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {

        FactureClientDetails lv = new FactureClientDetails();
        lv.setNomTable("facture_client_fille_libVM");
        String listeCrt[] = {"mois", "annee", "rubriquelib"};
        String listeInt[] = {};
        
        
        String[] pourcentage = {};
        String somDefaut[] ={"montanttaux"}; //sum
        String colDefaut[] =  {"moislib"}; // colonne
        String[] colGrCol = {"rubriquelib"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("annee").setDefaut(Utilitaire.getAnneeEnCours());
        pr.getFormu().getChamp("annee").setValeur(Utilitaire.getAnneeEnCours());
        if(request.getParameter("annee")==null || request.getParameter("annee").compareToIgnoreCase("")==0)
            pr.setAWhere(" and annee like '"+Utilitaire.getAnneeEnCours()+"'");
//        if(request.getParameter("mois")==null || request.getParameter("mois").compareToIgnoreCase("")==0)
//            pr.setAWhere("' and mois like '"+String.valueOf(Utilitaire.getMoisEnCours())+"'");
        Liste[] listes = new Liste[1];
        listes[0] = new Liste("mois");
        listes[0].makeListeMois();
        listes[0].setDefaultSelected(String.valueOf(Utilitaire.getMoisEnCours()));
        pr.getFormu().changerEnChamp(listes);
        
        pr.getFormu().getChamp("mois").setLibelle("Mois");
        pr.getFormu().getChamp("annee").setLibelle("Année");
        pr.getFormu().getChamp("rubriquelib").setLibelle("Rubrique");
        
        pr.setApres("facture/analyse-facture-client-vaovao.jsp");
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