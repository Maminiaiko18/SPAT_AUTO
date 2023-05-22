    <%@page import="utilitaire.Utilitaire"%>
    <%@page import="affichage.PageRechercheChoix"%>
    <%@page import="bean.TypeObjet"%>

    <%
        String criteria = "";
        String champReturn = request.getParameter("champReturn");
        
        TypeObjet motifVoyage = new TypeObjet();
        motifVoyage.setNomTable("motif_voyage");

        String listeCrt[] = {"id","val","desce"};
        String listeInt[] = {};
        String libEntete[] = {"id","val","desce"};
        int range = 2;
        PageRechercheChoix pr = new PageRechercheChoix(motifVoyage, request, listeCrt, listeInt, range, libEntete, libEntete.length);
        pr.setChampReturn(champReturn);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("motif-voyage-choix.jsp");


        pr.getFormu().getChamp("val").setLibelle("Valeur");
        pr.getFormu().getChamp("desce").setLibelle("description");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);

    %>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>Choix motif voyage</title>
            <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
            <jsp:include page='../elements/css.jsp'/>
        </head>
        <body class="skin-blue sidebar-mini">
            <div class="wrapper">
                <section class="content-header">
                    <h1>Titre</h1>
                </section>
                <section class="content">
                    <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                        <% out.println(pr.getFormu().getHtmlEnsemble());%>
                    </form>
                    <form action="apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                        <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                        <% 
                            String libEnteteAff[] =    {"ID","Valeur","Description"};
                            pr.getTableau().setLibeEntete(libEnteteAff);
                            out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                    </form>
                    <% out.println(pr.getBasPage());%>
                </section>
            </div>
            <jsp:include page='../elements/js.jsp'/>
        </body>
    </html>