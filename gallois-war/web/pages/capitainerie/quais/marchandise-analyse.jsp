
<%@page import="affichage.Liste"%>
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

        
        
    
        
        Liste[] listes = new Liste[2];
        listes[0] = new Liste("mois1");
        listes[1] = new Liste("mois2");
        
        listes[0].makeListeMois();
        
        Object[] affiche = listes[0].getValeurBrute();
        Object[] afficheV = new Object[affiche.length+1];
        afficheV[0] = "--";
        System.arraycopy(affiche, 0, afficheV, 1, affiche.length);
        listes[0].setValeurBrute(afficheV);
        listes[1].setValeurBrute(afficheV);

        String[] valeur = listes[0].getColValeurBrute();
        String[] valeurV = new String[valeur.length+1];
        valeurV[0] = "";
        System.arraycopy(valeur, 0, valeurV, 1, affiche.length);
        listes[0].setColValeurBrute(valeurV);
        listes[1].setColValeurBrute(valeurV);
        
        pr.getFormu().changerEnChamp(listes);
        
        pr.getFormu().getChamp("mois1").setLibelle("Mois Min");
        pr.getFormu().getChamp("mois2").setLibelle("Mois Max");
        pr.getFormu().getChamp("cargaisonlib").setLibelle("Cargaison");
        
        pr.setApres("capitainerie/quais/marchandise-analyse.jsp");
        
        pr.creerObjetPageCroise(colDefaut, pr.getLien() + "?but=capitainerie/quais/marchandise-analyse.jsp" );


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