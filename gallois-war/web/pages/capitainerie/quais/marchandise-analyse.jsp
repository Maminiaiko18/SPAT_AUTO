
<%@page import="mg.spat.CargaisonAnalyse"%>
<%@page import="utilitaire.Parametre"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {
        UserEJB u = (user.UserEJB) session.getValue("u");
        CargaisonAnalyse recap = new CargaisonAnalyse();
        String listeCrt[] = {"mois","cargaisonlib"};
        String listeInt[] = {"mois"};
        String m1="";
        String m2="";
        String cargaison="";
        String[] pourcentage = {};
        String somDefaut[] = {"tonnage"}; //sum
        String colGrCol[] = {"moislib"}; //ligne
        String[] colDefaut = {"cargaisonlib"}; // colonnes

        PageRechercheGroupe pr = new PageRechercheGroupe(recap, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, 4, 0);

        pr.setUtilisateur(u);
        pr.setLien((String) session.getValue("lien"));


        pr.setApres("capitainerie/quais/marchandise-analyse.jsp");

        // Problème : paginé foana ilay résultat (limit 25)
        // Solution : natao par rapport am count
//        Parametre.setNbParPage(OrdonnanceData.getCount(null, ord, awhere));

//        String apresLien = "&daty1=" + daty1 + "&daty2=" + daty2;

        pr.creerObjetPageCroise(colDefaut, pr.getLien() + "?but=capitainerie/quais/marchandise-analyse.jsp" );
        //Parametre.setNbParPage(25);


%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Tonnage marchandises</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres()%>" method="post" name="formulaire" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
        %>
    </section>
    <%
        if(request.getParameter("mois1")!=null ){
            m1=request.getParameter("mois1");
        }
        if(request.getParameter("mois2")!=null ){
            m2=request.getParameter("mois2");
        }
        if(request.getParameter("cargaisonlib")!=null ){
            cargaison=request.getParameter("cargaisonlib");
        }
    %>
    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=excel&mois1=<%= m1 %>&mois2=<%= m2%>&cargaisonlib=<%= cargaison%>" style="margin-right: 10px">EXCEL</a>
    <a class="btn btn-primary pull-right"  href="${pageContext.request.contextPath}/Paie?action=analyseMarchandise&mois1=<%= m1 %>&mois2=<%= m2%>&cargaisonlib=<%= cargaison%>" style="margin-right: 10px">PDF</a>

    <% //out.println(pr.getBasPage()); %>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>