
<%@page import="utilitaire.Utilitaire"%>
<%@page import="java.sql.Date"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="affichage.PageRechercheChoix"%>

<%
    try{
        String champReturn = request.getParameter("champReturn");
        FactureFournisseur choix = new FactureFournisseur();
        choix.setNomTable("FFengagementpopup");

        String listeCrt[] = {"id","daty","tierslib","designation","exercice","date_echeance","nature", "numeroop", "code", "projetlib","montantTTC","code_etablissementlib","remarque"};
        String listeInt[] = {"daty","date_echeance","exercice"};
        String libEntete[] = { "id", "code", "daty", "tierslib", "montant", "tva", "montantTVA", "montantTTCvrai", "numeroop", "datefacture", "designation", "projetlib", "code_etablissementlib","exercice", "date_echeance", "montantAvoir", "montantTTC", "montantpaye", "montantreste", "etatLib", "remarque"};
        String libEnteteAff[] = { "id", "Reference/Code", "date", "Fournisseur", "Montant HT", "TVA", "Montant TVA", "montant TTC", "N° Facture", "Date Facture", "Note explicative", "Projet", "Code direction", "exercice", "date echeance", "montant Avoir", "Net à payer", "Montant payé", "Reste à payer", "Etat", "ref compta"};
        int range = 3;
        PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
        pr.setTitre("Liste facture fournisseur");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("listeFFEngagementChoix.jsp");
        pr.setChampReturn(champReturn);
        affichage.Champ[]liste = new affichage.Champ[2];
        TypeObjet nature = new TypeObjet();
        nature.setNomTable("nature");
        liste[0] = new Liste("nature", nature, "val", "id");
        TypeObjet caisse = new TypeObjet();
        caisse.setNomTable("CAISSE");
        liste[1] = new Liste("valcaisserefpmt", caisse, "val", "val");
        pr.setNpp(100);
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("exercice1").setLibelle("debut exercice");
        pr.getFormu().getChamp("exercice2").setLibelle("fin exercice");
        pr.getFormu().getChamp("tierslib").setLibelle("Fournisseur");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("remarque").setLibelle("ref compta");
        pr.getFormu().getChamp("code").setLibelle("Reference/Code");     
        pr.getFormu().getChamp("montantTTC").setLibelle("Montant TTC");
        pr.getFormu().getChamp("code_etablissementlib").setLibelle("Code direction");

        pr.getFormu().changerEnChamp(liste);
        pr.getFormu().getChamp("nature").setLibelle("Nature");
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);
        firstDate.setMonth(0);
        Date lastDate = Utilitaire.dateDuJourSql();
        lastDate.setDate(31);
        lastDate.setMonth(11);
        String debutDate = "01/01/"+Utilitaire.getAnnee(Utilitaire.dateDuJourSql());
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);

        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);

        }
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        pr.getFormu().getChamp("designation").setLibelle("Note explicative");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        pr.getTableau().setLibeEntete(libEnteteAff);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= pr.getTitre() %></title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1><%= pr.getTitre() %></h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <form action="apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                        
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>