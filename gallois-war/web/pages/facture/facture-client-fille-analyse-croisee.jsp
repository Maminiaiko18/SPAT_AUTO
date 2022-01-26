<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="mg.spat.AnalyseDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        AnalyseDetails lv = new AnalyseDetails();
        lv.setNomTable("factureclientfille_libcompteCA");
        String listeCrt[] = {"libelleCompte","mois","annee"};
        String listeInt[] = {"mois","annee"};

        String[] pourcentage = {};
        String somDefaut[] ={"montantttc"}; //sum
        String colDefaut[] =  {"moislib"}; // colonne
        String[] colGrCol = {"libelleCompte"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("mois1").setVisible(false);
        pr.getFormu().getChamp("annee2").setVisible(false);
        pr.getFormu().getChamp("annee1").setLibelle("Annee");
        pr.getFormu().getChamp("libelleCompte").setLibelle("Libelle");
         affichage.Champ [] list = new affichage.Champ[1];
        int month = Utilitaire.getMoisEnCoursReel();
        if (month == 0) month = 12;
        
        Liste mois = new Liste("mois2");
        String affiche[] = {"-","Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"};
	String valeur[] = {" ","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
	mois.setValeurBrute(affiche);
	mois.setColValeurBrute(valeur);
//        mois.makeListeMois();
        list[0] = mois;
        pr.getFormu().changerEnChamp(list);
        pr.getFormu().getChamp("mois2").setDefaut(String.valueOf(month));
        pr.getFormu().getChamp("annee1").setDefaut(Utilitaire.getAnneeEnCours());
        
        pr.getFormu().getChamp("mois2").setLibelle("Mois");
        
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
        <script>
            $('label[for="mois1"]').remove();
            $('label[for="annee2"]').remove();
         </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>