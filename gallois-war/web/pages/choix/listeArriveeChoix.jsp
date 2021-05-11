<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    String champReturn = request.getParameter("champReturn");
    MouvementLibComplet mvt = new MouvementLibComplet();
    mvt.setNomTable("arrivee");
    String listeCrt[] = {"id", "date_depart", "nomnavire","heure"};
    String listeInt[] = {"date_depart"};
    String libEntete[] = {"id","escalelib","nomnavire", "desceconsignataire","valpaysdestination", "valcargaison", "datearrivee", "heure","valquaisdestination", "date_depart","heure_depart","duree", "noVoyage"};
    PageRechercheChoix pr = new PageRechercheChoix(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    //pr.setOrdre(" order by daty desc");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeArriveeChoix.jsp");
    pr.getFormu().getChamp("nomnavire").setLibelle("navire");
    pr.getFormu().getChamp("date_depart1").setLibelle("date départ min");
    pr.getFormu().getChamp("date_depart2").setLibelle("date départ max");
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
                <h1>Liste arrivées</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="arriveeliste" id="arriveeliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                       String libEnteteAff[] =  {"id","escale","navire", "consignataire","Destination", "cargaison", "date arrivée", "Heure d'arrivée","localistation", "date départ","heure départ","durée", "no Voyage"};
                       pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

