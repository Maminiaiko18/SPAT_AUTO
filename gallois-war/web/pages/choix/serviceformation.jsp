
<%@page import="mg.cnaps.log.LogService"%>
<%@page import="affichage.PageRechercheChoix"%>


<%
    LogService service = new LogService();
    service.setNomTable("LOG_SERVICE_LIBELLEF");
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"id", "libelle", "code_service"};
    String listeInt[] = null;
    String libEntete[]= {"id", "libelle", "code_service"};
    PageRechercheChoix pr = new PageRechercheChoix(service, request, listeCrt, listeInt, 3, libEntete, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));  
    pr.getFormu().getChamp("code_service").setLibelle("Direction");
    pr.setApres("serviceformation.jsp");
    pr.setChampReturn(champReturn);
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    LogService[] listeService = (LogService[]) pr.getRs().getResultat();
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cynthia 2.0 | CNaPS</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Liste Service</h1>
            </section>
            <section class="content">
                <form action="serviceformation.jsp?champReturn=<%=pr.getChampReturn()%>" method="post" name="serviceliste" id="serviceliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                 
                <form action="../<%=pr.getLien()%>?but=choix/apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <table class="table table-bordered">
                            <tr class=info>
                                <th>#</th>
                                <th>ID</th>
                                <th>Service</th>
                                
                                <th>Direction</th>
                            </tr>
                            <%
                                String toReturn = "";
                                for (int i = 0; i < listeService.length; i++) {
                                    toReturn = listeService[i].getId()+";"+listeService[i].getLibelle()+";"+listeService[i].getDr_rattache()+";"+listeService[i].getCode_service();
                            %>
                            <tr>
                                <td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=toReturn%>" class="radio" /></td>
                                <td align=center><%=utilitaire.Utilitaire.champNull(listeService[i].getId())%></td>
                                <td align=center><%=utilitaire.Utilitaire.champNull(listeService[i].getLibelle())%></td>
                                <td align=center><%=utilitaire.Utilitaire.champNull(listeService[i].getCode_service())%></td>
                                  </tr>
                            <%}%>
                    </table>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

