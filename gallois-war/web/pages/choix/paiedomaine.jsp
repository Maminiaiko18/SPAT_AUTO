<%-- 
    Document   : paiedomaine
    Created on : 25 nov. 2016, 10:56:55
    Author     : Jetta
--%>


<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    TypeObjet e = new TypeObjet();
    e.setNomTable("PAIE_DOMAINE");
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"id", "val", "desce"};
    String listeInt[] = {""};
    String libEntete[] = {"id", "val", "desce"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 2, libEntete,3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("paiedomaine.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("val").setLibelleAffiche("Valeur");
    pr.getFormu().getChamp("desce").setLibelleAffiche("Description");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    TypeObjet[] listeP = (TypeObjet[]) pr.getRs().getResultat();
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
                <h1>Liste domaines</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="agencecode" id="agencecode">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    String libelles[] = {"id", "val", "desce"};
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <table class="table table-bordered">
                            <tr class=info>
                                    <th>#</th>
                                    <th>id</th>
                                    <th>Libelle</th>
                                    <th>description</th>

                            </tr>
                            <%
                                    for (int i = 0; i < listeP.length; i++) {
                            %>
                            <tr>
                                <td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>;<%=listeP[i].getVal()%>" class="radio" /></td>
                                    <td align=center><%=listeP[i].getId()%></td>
                                    <td align=center><%=listeP[i].getVal()%></td>
                                    <td align=center><%=listeP[i].getDesce()%></td>
                                    
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
