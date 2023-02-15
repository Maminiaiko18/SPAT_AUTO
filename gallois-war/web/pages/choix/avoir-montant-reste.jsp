<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRechercheChoix"%>

<%@page import="avoir.AvoirFC"%>


<%
    String criteria = "";
    String champReturn = request.getParameter("champReturn");
    AvoirFC avoirFc = new AvoirFC();
    avoirFc.setNomTable("avoirfc_montant_regroup");
    String tiers = "";

    String listeCrt[] = {"id","DATY","CATEGORIELIB","MOTIFLIB","CODE" ,"TYPELIB","DESIGNATION","MONTANT","MONTANTPAYE","MONTANTRESTE","CDCLT"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","daty","tierslib","categorielib","motiflib","code" ,"typelib","designation","montant","montantpaye","montantreste","cdclt"};
   
    PageRechercheChoix pr = new PageRechercheChoix(avoirFc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    //pr.setOrdre(" order by daty desc");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("avoir-montant-reste.jsp");
   
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
    
    if(request.getParameter("DATY1")==null || request.getParameter("DATY1").equals("")){
        criteria += " and daty>= '"+Utilitaire.dateDuJour()+"'";
    }
    
    if(request.getParameter("idtiers") != null){
        tiers = request.getParameter("idtiers");
       criteria +=" and tiers = '" + tiers + "' ";
    }
    
    criteria += " and montantreste > 0";
    
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
                <form action="../<%=pr.getLien()%>?but=choixMultiple/apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                        String libEnteteAff[] =   {"id","Date","Tiers","Catégorie","Motif","code" ,"type","Designation","Montant","Montant payé","Montant reste","Code Client"};
                        pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithMultipleCheckbox()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>