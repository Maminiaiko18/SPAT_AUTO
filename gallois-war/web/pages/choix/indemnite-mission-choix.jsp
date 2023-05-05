    <%@page import="utilitaire.Utilitaire"%>
    <%@page import="affichage.PageRechercheChoix"%>
    <%@page import="ordremission.IndemniteMission"%>

    <%
        String criteria = "";
        String champReturn = request.getParameter("champReturn");
        
        IndemniteMission indemnite = new IndemniteMission();
        indemnite.setNomTable("indemnite_mission_lib");

        String listeCrt[] = {"id","idcategorieprofessionnellib","daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id","idcategorieprofessionnellib","fraishebergement","fraisrestauration","fraisdeplacement","fraisforfaitaire"};
        int range = 2;
        PageRechercheChoix pr = new PageRechercheChoix(indemnite, request, listeCrt, listeInt, range, libEntete, libEntete.length);
        pr.setChampReturn(champReturn);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("indemnite-mission-choix.jsp");

        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("idcategorieprofessionnellib").setLibelle("Categorie professionnel");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);

    %>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>Choix indemnite mission</title>
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
                            String libEnteteAff[] =   {"ID","Categorie professionnel","Frais hebergement","Frais restauration","Frais deplacement","Frais forfaitaire"};
                            pr.getTableau().setLibeEntete(libEnteteAff);
                            out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                    </form>
                    <% out.println(pr.getBasPage());%>
                </section>
            </div>
            <jsp:include page='../elements/js.jsp'/>
        </body>
    </html>