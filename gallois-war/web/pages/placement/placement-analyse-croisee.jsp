<%@page import="mg.spat.placement.Placement"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="mg.spat.AnalyseDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        Placement lv = new Placement();
        lv.setNomTable("PLACEMENT_ANALYSE");
        String listeCrt[] = {"entite","banque","anneePlacement","moisplacement"};
        String listeInt[] = {"moisplacement","anneePlacement"};

        String[] pourcentage = {};
        String somDefaut[] ={"montant"}; //sum
        String colDefaut[] =  {"banque", "interet_recevoir", "interetnet"}; // colonne
        String[] colGrCol = {"moisplacementlib"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

//        pr.getFormu().getChamp("mois1").setVisible(false);
//        pr.getFormu().getChamp("anneePlacement2").setVisible(false);
        pr.getFormu().getChamp("anneePlacement1").setLibelle("Annee Placement Min");
        pr.getFormu().getChamp("anneePlacement2").setLibelle("Annee Placement Max");
//        pr.getFormu().getChamp("moisplacement").setLibelle("Mois Placement");
         affichage.Champ [] list = new affichage.Champ[2];
        int month = Utilitaire.getMoisEnCoursReel();
        if (month == 0) month = 12;
        
        Liste mois = new Liste("moisplacement1");
        String affiche[] = {"-","Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"};
	String valeur[] = {" ","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
	mois.setValeurBrute(affiche);
	mois.setColValeurBrute(valeur);
        mois.makeListeMois();
        list[0] = mois;
        Liste mois2 = new Liste("moisplacement2");
	mois2.setValeurBrute(affiche);
	mois2.setColValeurBrute(valeur);
        mois2.makeListeMois();
        list[1] = mois2;
        pr.getFormu().changerEnChamp(list);
        pr.getFormu().getChamp("moisplacement1").setDefaut(String.valueOf(month));
        pr.getFormu().getChamp("moisplacement2").setDefaut(String.valueOf(month));
        
        pr.getFormu().getChamp("moisplacement1").setLibelle("Mois Placement Min");
        pr.getFormu().getChamp("moisplacement2").setLibelle("Mois Placement Max");
        
        pr.setApres("placement/placement-analyse-croisee.jsp");
        pr.creerObjetPageCroise(colDefaut, pr.getLien()+"?but="+pr.getApres());

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Placement</h1>
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
        <script>
//            $('label[for="mois1"]').remove();
            $('label[for="anneePlacement2"]').remove();
         </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>