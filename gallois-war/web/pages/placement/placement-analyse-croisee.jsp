<%@page import="mg.spat.placement.Placement"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="mg.spat.AnalyseDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        Placement lv = new Placement();
        lv.setNomTable("PLACEMENT_ANALYSE");
        String listeCrt[] = {"entite","banque","anneerembousement","moisrembousement"};
        String listeInt[] = {"moisrembousement","anneerembousement"};

        String[] pourcentage = {};
        String somDefaut[] ={"interet_recevoir", "interetnet"}; //sum
        String colDefaut[] =  {"banque"}; // colonne
        String[] colGrCol = {"moisrembousementlib"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("anneerembousement1").setLibelle("Annee Min");
        pr.getFormu().getChamp("anneerembousement2").setLibelle("Annee Max");
        
         affichage.Champ [] list = new affichage.Champ[2];
        int month = Utilitaire.getMoisEnCoursReel();
        if (month == 0) month = 12;
        
        Liste mois = new Liste("moisrembousement1");
        String affiche[] = {"-","Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"};
	String valeur[] = {" ","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
	mois.setValeurBrute(affiche);
	mois.setColValeurBrute(valeur);
        mois.makeListeMois();
        list[0] = mois;
        Liste mois2 = new Liste("moisrembousement2");
	mois2.setValeurBrute(affiche);
	mois2.setColValeurBrute(valeur);
        mois2.makeListeMois();
        list[1] = mois2;
        pr.getFormu().changerEnChamp(list);
        pr.getFormu().getChamp("moisrembousement1").setDefaut(String.valueOf(1));
        pr.getFormu().getChamp("moisrembousement2").setDefaut(String.valueOf(12));
        
        pr.getFormu().getChamp("anneerembousement1").setDefaut(Utilitaire.getAnneeEnCours());
        pr.getFormu().getChamp("anneerembousement2").setDefaut(Utilitaire.getAnneeEnCours());
        
        pr.getFormu().getChamp("moisrembousement1").setLibelle("Mois Min");
        pr.getFormu().getChamp("moisrembousement2").setLibelle("Mois Max");
        
        String url = "placement/placement-analyse-croisee-details.jsp";
        String urla1 = "&anneeRembousement1=" +Utilitaire.getAnneeEnCours();
        if(request.getParameter("anneeRembousement1")!=null){
            urla1 = "&anneeRembousement1="+request.getParameter("anneeRembousement1");
        }
        String urla2 = "&anneeRembousement2=" +Utilitaire.getAnneeEnCours();
        if(request.getParameter("anneeRembousement2")!=null){
            urla2 = "&anneeRembousement2="+request.getParameter("anneeRembousement2");
        }
        url += urla1 + urla2;
        pr.setApres("placement/placement-analyse-croisee.jsp");
        pr.creerObjetPageCroise(colDefaut, pr.getLien()+"?but="+url);

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