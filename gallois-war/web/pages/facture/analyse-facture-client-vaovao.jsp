<%@page import="java.sql.Date"%>
<%@page import="affichage.Liste"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {

        FactureClientDetails lv = new FactureClientDetails();
        lv.setNomTable("FCFILLECOMPLET_ANALYSE");
        String listeCrt[] = {"daty","annee", "libelleRubrique","client"};
        String listeInt[] = {"daty"};
        
        
        String[] pourcentage = {};
        String somDefaut[] ={"montantttc"}; //sum
        String colDefaut[] =  {"moislib","catClient"}; // colonne
        String[] colGrCol = {"client"}; //ligne
        
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("annee").setDefaut(Utilitaire.getAnneeEnCours());
        pr.getFormu().getChamp("annee").setValeur(Utilitaire.getAnneeEnCours());
        if(request.getParameter("annee")==null || request.getParameter("annee").compareToIgnoreCase("")==0)
            pr.setAWhere(" and annee like '"+Utilitaire.getAnneeEnCours()+"'");
        
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);
        
        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);
            pr.setAWhere(" and daty>='"+debutDate+"' and daty<='"+dateFin+"'");
        }
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
//        if(request.getParameter("mois")==null || request.getParameter("mois").compareToIgnoreCase("")==0)
//            pr.setAWhere("' and mois like '"+String.valueOf(Utilitaire.getMoisEnCours())+"'");
        /*Liste[] listes = new Liste[1];
        listes[0] = new Liste("mois");
        listes[0].makeListeMois();
        
        listes[0].setDefaultSelected(String.valueOf(Utilitaire.getMoisEnCours()));
        
         Liste moisL = new Liste("mois");
        moisL.makeListeMois();
         System.out.println("Utilitaire.getMoisEnCoursReel()="+Utilitaire.getMoisEnCoursReel());
        moisL.setDefaut("" + Utilitaire.getMoisEnCoursReel());
        
        pr.getFormu().changerEnChamp(listes);*/
        /*String awhere="";
        if(request.getParameter("mois")==null){
            awhere=" and mois ="+Utilitaire.getMoisEnCoursReel();
        }
        pr.setAWhere(awhere);
        pr.getFormu().getChamp("mois").setDefaut(Utilitaire.getMoisEnCoursReel()+"");
        pr.getFormu().getChamp("mois").setLibelle("Mois");*/
        pr.getFormu().getChamp("annee").setLibelle("Année");
        pr.getFormu().getChamp("libelleRubrique").setLibelle("Rubrique");
         
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