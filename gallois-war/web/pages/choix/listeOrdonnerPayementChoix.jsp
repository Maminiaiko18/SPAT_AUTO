<%-- 
    Document   : listeOrdonnerPayementChoix
    Created on : 5 janv. 2021, 09:20:51
    Author     : Sanda
--%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    try{
        String nomProjet = "SPAT",
                nomVue = "OrdonnerPayement_Vise",
                titre = "Liste des ordres de paies",
                nomPage = "listeOrdonnerPayementChoix.jsp"
                ;
        String listeCrt[] = {"id","ded_Id", "daty", "numeroop"};
        String listeInt[] = {"daty"};
        String libEntete[] =  {"id", "ded_Id", "daty","montant","remarque","numeroop"};
        String libelleAffiche[] = {"ID", "Facture", "Date","Montant","Remarque","num&eacute;ro op"};
        
        
        OrdonnerPayement objet = new OrdonnerPayement();
        objet.setNomTable(nomVue);
        String champReturn = request.getParameter("champReturn");
        PageRechercheChoix pr = new PageRechercheChoix(objet, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres(nomPage);
        pr.setChampReturn(champReturn);
        
        pr.getFormu().getChamp("ded_Id").setLibelle("facture");
        pr.getFormu().getChamp("daty1").setLibelle("date de début");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("numeroop").setLibelle("Numero OP");
        pr.setAWhere(" and ETAT = 11");
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
