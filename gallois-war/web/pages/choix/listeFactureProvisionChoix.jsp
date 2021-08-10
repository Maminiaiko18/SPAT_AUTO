
<%@page import="java.sql.Date"%>
<%@ page import="user.*" %>
<%@page import="facture.FactureClient"%>    
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String champReturn = request.getParameter("champReturn");
    FactureClient navire = new FactureClient();
    navire.setNomTable("ProvisionViseeNonFacturee");
    String listeCrt[] = {"id", "daty", "tierslib", "designation", "date_echeance", "escale"};
    String listeInt[] = {"daty", "date_echeance"};
    String libEntete[] = {"id", "daty", "tierslib", "escale", "designation", "tva", "date_echeance", "montant", "montantTVA", "montantTTC", "montantAvoir", "montantpaye", "montantreste"};
    String libelleAffiche[] = {"id", "daty", "Client", "Escale", "designation", "tva", "date echeance", "montant HT", "montant TVA", "montant TTC", "montant Avoir", "Montant payé", "Reste à payer"};

    PageRechercheChoix pr = new PageRechercheChoix(navire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeFactureProvisionChoix.jsp");

    pr.getFormu().getChamp("daty1").setLibelle("date debut");
    pr.getFormu().getChamp("daty2").setLibelle("date fin");
    pr.getFormu().getChamp("tierslib").setLibelle("Client");

    Date firstDate = Utilitaire.dateDuJourSql();
    firstDate.setDate(1);
    Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);

    String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
    String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);

    if (request.getParameter("daty1") == null && request.getParameter("daty2") == null) {
        pr.getFormu().getChamp("daty1").setDefaut(debutDate);
        pr.getFormu().getChamp("daty2").setDefaut(dateFin);

    }
    pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
    pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");

    pr.setChampReturn(champReturn);
    String[] colSomme = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SPAT</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Choix facture client</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    pr.getTableau().setLibelleAffiche(libelleAffiche);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>O
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
