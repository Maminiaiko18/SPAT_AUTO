    <%@page import="mg.spat.relationhumaine.InfoPersonnelGlobal"%>
    <%@page import="utilitaire.Utilitaire"%>
    <%@page import="affichage.PageRechercheChoix"%>

    <%
        String criteria = "";
        String champReturn = request.getParameter("champReturn");
        
        InfoPersonnelGlobal tiers = new InfoPersonnelGlobal();
        tiers.setNomTable("INFOPERSONNELGLOBAL");

        String listeCrt[] = {"id", "nom", "prenom","poste", "categorie", "numero_matricule"};
        String listeInt[] = {};
        String libEntete[] = {"id", "nom", "prenom","poste", "categorie", "numero_matricule","adresse"};
        int range = 2;
        PageRechercheChoix pr = new PageRechercheChoix(tiers, request, listeCrt, listeInt, range, libEntete, libEntete.length);
        pr.setChampReturn(champReturn);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("info-personnel-global-choix.jsp");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);

    %>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>Choix personnel</title>
            <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
            <jsp:include page='../elements/css.jsp'/>
        </head>
        <body class="skin-blue sidebar-mini">
            <div class="wrapper">
                <section class="content-header">
                    <h1>Choix personnel</h1>
                </section>
                <section class="content">
                    <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                        <% out.println(pr.getFormu().getHtmlEnsemble());%>
                    </form>
                    <form action="apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                        <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                        <% 
                            String libEnteteAff[] = {"ID", "Nom", "Prenom","Poste", "Categorie", "Numero matricule","Adresse"};
                            pr.getTableau().setLibeEntete(libEnteteAff);
                            out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                    </form>
                    <% out.println(pr.getBasPage());%>
                </section>
            </div>
            <jsp:include page='../elements/js.jsp'/>
        </body>
    </html>