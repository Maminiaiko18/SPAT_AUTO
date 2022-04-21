
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
        String colDefaut[] = {"direction"}; //sum
        String[] somDefaut = {"MONTANT","ENGAGEER","FACTURE","POURCENGAGE","PAYE","POURCPAYE","ARECOUVRIR","RESTEBUDGET","RESTEAPRESENGMT"}; // colonnes

        PageRechercheGroupe pr = new PageRechercheGroupe(recap, request, listeCrt, listeInt, 3, somDefaut, pourcentage, 4, 0);

        pr.setUtilisateur(u);
        pr.setLien((String) session.getValue("lien"));
        /*
        Liste[] listes = new Liste[2];
        listes[0] = new Liste("mois1");
        listes[1] = new Liste("mois2");
        
        listes[0].makeListeMois();
        
        Object[] affiche = listes[0].getValeurBrute();
        Object[] afficheV = new Object[affiche.length+1];
        afficheV[0] = "--";
        System.arraycopy(affiche, 0, afficheV, 1, affiche.length);
        listes[0].setValeurBrute(afficheV);
        listes[1].setValeurBrute(afficheV);

        String[] valeur = listes[0].getColValeurBrute();
        String[] valeurV = new String[valeur.length+1];
        valeurV[0] = "";
        System.arraycopy(valeur, 0, valeurV, 1, affiche.length);
        listes[0].setColValeurBrute(valeurV);
        listes[1].setColValeurBrute(valeurV);
        
        pr.getFormu().changerEnChamp(listes);
        
        pr.getFormu().getChamp("mois1").setLibelle("Mois Min");
        pr.getFormu().getChamp("mois2").setLibelle("Mois Max");
        pr.getFormu().getChamp("cargaisonlib").setLibelle("Cargaison");
        */
        pr.setApres("ligneCredit/situationLCDepense-analyse.jsp");
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
    </section>


    <% //out.println(pr.getBasPage()); %>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>