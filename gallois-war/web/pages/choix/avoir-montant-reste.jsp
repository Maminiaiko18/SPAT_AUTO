<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRechercheChoix"%>

<%@page import="avoir.AvoirFC"%>


<%
    String criteria = "";
    String champReturn = request.getParameter("champReturn");
    AvoirFC avoirFc = new AvoirFC();
    avoirFc.setNomTable("avoirfc_montant_regroup_v");
    String tiers = "";

    String listeCrt[] = {"id","DATY","CATEGORIELIB","MOTIFLIB","code" ,"TYPELIB","designation","tierslib"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","daty","tierslib","categorielib","motiflib","code" ,"typelib","designation","montant","montantpaye","montantreste"};
   
    PageRechercheChoix pr = new PageRechercheChoix(avoirFc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    //pr.setOrdre(" order by daty desc");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("avoir-montant-reste.jsp");
   
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.getFormu().getChamp("tierslib").setLibelle("Tiers");

    
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.getDateMoins6Mois());
    
    /*if(request.getParameter("tierslib") != null){
        tiers = request.getParameter("idtiers");
       criteria +=" and tiers = '" + tiers + "' ";
    }*/
    
    criteria += " and montantreste > 0 and montantrestefc <= 0";
    pr.getFormu().getChamp("CATEGORIELIB").setLibelle("Categorie");
    pr.getFormu().getChamp("MOTIFLIB").setLibelle("Motif");
    pr.getFormu().getChamp("TYPELIB").setLibelle("Type");
    
    pr.setAWhere(criteria);
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
                <h1>Liste facture client</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                    <% if(request.getParameter("idtiers") != null){ %><input type="hidden" name="idtiers" value=<%=tiers%>><%}%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoixAvoir.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                        String libEnteteAff[] =   {"id","Date","Tiers","Cat�gorie","Motif","code" ,"type","Designation","Montant","Montant pay�","Montant reste"};
                        pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithMultipleCheckbox()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>