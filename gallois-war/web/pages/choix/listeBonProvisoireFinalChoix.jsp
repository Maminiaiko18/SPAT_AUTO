<%-- 
    Document   : listeBonProvisoireChoix
    Created on : 30 déc. 2020, 20:52:34
    Author     : Lenovo
--%>

<%@page import="affichage.PageRechercheChoix"%>
<%@page import="facture.BonProvisoire"%>
<%@page import="utilitaire.Utilitaire"%>

<%
    
    try{
        

    String champReturn = request.getParameter("champReturn");
    BonProvisoire e = new BonProvisoire();
    e.setNomTable("bon_provisoire_final_lib");
        String listeCrt[] = {"id","daty","tierslib","caisselib","remarque"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "daty","montant", "remarque","tierslib","caisselib"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeBonProvisoireFinalChoix.jsp");
    pr.setChampReturn(champReturn);

        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("caisselib").setLibelle("Caisse");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Bon Provisoire</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Bon Provisoire</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="etab" id="etab">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
//                    String lienTableau[] = {pr.getLien() + "?but=facture/bon-provisoire-fiche.jsp"};
//                    String colonneLien[] = {"id"};
                    String libelles[] = {"Id", "Daty","Montant", "Remarque","Tiers","Caisse"};
		    //pr.getTableau().setLien(lienTableau);
//                    pr.getTableau().setColonneLien(colonneLien);
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

<%
        }catch(Exception e){
        e.printStackTrace();
}
%>