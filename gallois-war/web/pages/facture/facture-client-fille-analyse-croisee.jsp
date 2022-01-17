<%@page import="mg.spat.AnalyseDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        AnalyseDetails lv = new AnalyseDetails();
        lv.setNomTable("factureclientfille_libcompteCA");
        String listeCrt[] = {"libelleCompte"};
        String listeInt[] = {};

        String[] pourcentage = {};
        String somDefaut[] ={"montantttc"}; //sum
        String colDefaut[] =  {"mois"}; // colonne
        String[] colGrCol = {"libelleCompte"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

//        pr.getFormu().getChamp("produit_lib").setLibelle("Produit");
//        pr.getFormu().getChamp("rubriquelib").setLibelle("Rubrique");
        
        pr.setApres("facture/facture-client-fille-analyse-croisee.jsp");
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