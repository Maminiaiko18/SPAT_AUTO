
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.TypeObjet"%>
<%@page import="facture.SuiviProvision"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    SuiviProvision suiviProvision = new SuiviProvision();
    String setNomTableNormale = "SUIVI_PROVISION";
    suiviProvision.setNomTable(setNomTableNormale);
    String listeCrt[] = {"id", "caisse","daty","numpiece","tiers","code","codeprovision","numcheque"};
    String listeInt[] = {"daty"};       
    String libEntete[] = {"id", "daty", "caisse","credit","numpiece","codeprovision","montantprovision","numcheque", "tiers","montant","dateliaison","code"};
    PageRecherche pr = new PageRecherche(suiviProvision, request, listeCrt, listeInt, 3, libEntete, libEntete.length);

    pr.setTitre("Suivi Provision");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facture/suivi-provision.jsp");
   
    affichage.Champ[]liste = new affichage.Champ[1];
    TypeObjet caisse = new TypeObjet();
    caisse.setNomTable("CAISSE");
    liste[0] = new affichage.Liste("caisse", caisse, "val", "val");

    String debutDate = "01/01/"+Utilitaire.getAnnee(Utilitaire.dateDuJourSql());
    String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", Utilitaire.dateDuJourSql());
    if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
        pr.getFormu().getChamp("daty1").setDefaut(debutDate);
        pr.getFormu().getChamp("daty2").setDefaut(dateFin);
    }
        
    pr.getFormu().getChamp("code").setLibelle("Code Facture");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("numpiece").setLibelle("Numero piece");

    pr.getFormu().changerEnChamp(liste);

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=treso/journalcaisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles � afficher
    String libEnteteAffiche[] = {"id", "daty", "caisse","credit","numero piece","code provision","montant provision","num cheque", "tiers","montant","date liaison","code facture"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">

                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>