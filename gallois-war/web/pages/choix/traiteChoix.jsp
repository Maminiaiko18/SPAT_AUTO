
<%@page import="facture.tr.Traite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String champReturn = request.getParameter("champReturn");
    Traite navire = new Traite();
    navire.setNomTable("TRAITEMTTRESTE");
    String libEntete[] = {"id", "tiers", "banque", "daty", "dateEcheance", "montant", "montantreste", "reference"};
    String listeCrt[] = {"id", "tiers", "banque", "daty", "dateEcheance", "montant", "reference"};
    String listeInt[] = {""};
    PageRechercheChoix pr = new PageRechercheChoix(navire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("traiteChoix.jsp");
    double montantTotalJc = 0.0;

    if(request.getParameter("idtiers") != null)
        pr.setAWhere(" and cdclt = '" + request.getParameter("idtiers") + "'");
    if(request.getParameter("traite") != null){
        if(request.getParameter("montanttotaljc")!=null)montantTotalJc=Double.valueOf(request.getParameter("montanttotaljc"));
        pr.setAWhere(" and montantreste > 0 and etat = 11 and montantreste>="+montantTotalJc);
    }
    pr.setOrdre(" order by dateEcheance asc");
        
    pr.setChampReturn(champReturn);
    String[] colSomme = null;
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
                <h1>Choix Traite</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% if(request.getParameter("traite") != null){ %>
                        <input type="hidden" name="traite" value="true">
                        <input type="hidden" name="montanttotaljc" value="<%=montantTotalJc%>">
                    <%}%>
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    
                    <% 
                         String libEnteteAffiche[] = {"Id", "Tiers", "Banque", "Date", "Date Echeance", "Montant",  "Montant Disponible", "Reference"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
