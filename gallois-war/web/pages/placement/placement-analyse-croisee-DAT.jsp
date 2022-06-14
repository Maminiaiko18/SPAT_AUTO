<%@page import="mg.spat.placement.Placement"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="mg.spat.AnalyseDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        Placement lv = new Placement();
        lv.setNomTable("PLACEMENT_ANALYSE_DAT");
        String listeCrt[] = {"designation", "banque", "montant", "anneeplacement"};
        String listeInt[] = {"anneeplacement"};

        String[] pourcentage = {};
        String somDefaut[] ={"montant"}; //sum
        String colDefaut[] =  {"banque"}; // colonne
        String[] colGrCol = {"designation"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("anneeplacement1").setLibelle("Annee Min");
        pr.getFormu().getChamp("anneeplacement2").setLibelle("Annee Max");
        
        pr.getFormu().getChamp("anneeplacement1").setDefaut(Utilitaire.getAnneeEnCours());
        pr.getFormu().getChamp("anneeplacement2").setDefaut(Utilitaire.getAnneeEnCours());
//        String awhere="";
//        
//        if(request.getParameter("anneerembousement1")==null && request.getParameter("anneerembousement2")==null 
//                && request.getParameter("moisrembousement1")==null && request.getParameter("moisrembousement2")==null  ){
//            awhere=String.format("and moisrembousement>=%s && moisrembousement<= %s",1,12);
//            
//            awhere=String.format("and anneerembousement=%s",Utilitaire.getAnneeEnCours());
//            
//            pr.setAWhere(awhere);
//        }
        
        String url = "placement/placement-analyse-croisee-details-DAT.jsp";
        String urla1 = "&anneePlacement1=" +Utilitaire.getAnneeEnCours();
        if(request.getParameter("anneeplacement1")!=null){
            urla1 = "&anneePlacement1="+request.getParameter("anneeplacement1");
        }
        String urla2 = "&anneePlacement2=" +Utilitaire.getAnneeEnCours();
        if(request.getParameter("anneeplacement2")!=null){
            urla2 = "&anneePlacement2="+request.getParameter("anneeplacement2");
        }
        url += urla1 + urla2;
        pr.setApres("placement/placement-analyse-croisee-DAT.jsp");
        pr.creerObjetPageCroise(colDefaut, pr.getLien()+"?but="+url+"&recap=checked");

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
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>