<%-- 
    Document   : listePlacementChoix
    Created on : 13 janv. 2021, 17:11:54
    Author     : Sanda
--%>

<%@page import="mg.spat.placement.Placement"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    try{
        String nomProjet = "SPAT",
                nomVue = "placementlib",
                titre = "Liste des placements",
                nomPage = "listePlacementChoix.jsp"
                ;
       
        String listeCrt[] = {"id", "entite", "date_placement", "date_echeance"};
        String listeInt[] = {"date_placement","date_echeance"};
        String libEntete[] = {"id", "entite", "numero", "date_placement", "date_echeance","duree","montant","taux"};
        String libelleAffiche[] = {"Id", "Entite", "Numero", "Date de placement", "Date d'echeance","Duree(en mois)","Montant","Taux"};

        Placement objet = new Placement();
        objet.setNomTable(nomVue);
        String champReturn = request.getParameter("champReturn");
        PageRechercheChoix pr = new PageRechercheChoix(objet, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres(nomPage);
        pr.setChampReturn(champReturn);
        
        pr.getFormu().getChamp("date_placement1").setLibelleAffiche("Date Placement min");
        pr.getFormu().getChamp("date_placement2").setLibelleAffiche("Date Placement max");
        pr.getFormu().getChamp("date_echeance1").setLibelleAffiche("Date Echeance min");
        pr.getFormu().getChamp("date_echeance2").setLibelleAffiche("Date Echeance max");
        pr.getFormu().getChamp("date_placement1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("date_placement2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%=nomProjet%></title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1><%=titre%></h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="<%=nomVue%>" id="<%=nomVue%>">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    pr.getTableau().setLibelleAffiche(libelleAffiche);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>"/>
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
