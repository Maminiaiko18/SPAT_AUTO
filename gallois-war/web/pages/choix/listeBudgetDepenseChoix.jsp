<%-- 
    Document   : listeBudgetDepenseChoix
    Created on : 31 janv. 2022, 15:45:39
    Author     : andri
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="lignecredit.LigneCredit"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%
    try{
    UserEJB u = (UserEJB) session.getAttribute("u");
    String listeCrt[] = {"id","designation", "compte", "comptestr", "montant","direction"};
    String listeInt[] = {};
    String libEntete[] = {"id","designation", "compte", "comptestr", "montant","direction"};
    
     LigneCredit cons = new LigneCredit();
    cons.setNomTable("SITUATIONLCDEPENSEV");
    
    PageRechercheChoix pr = new PageRechercheChoix(cons, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    
    pr.setChampReturn(request.getParameter("champReturn"));
    pr.setUtilisateur(u);
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("choix/listeBudgetDepenseChoix.jsp");
    
//    pr.getFormu().getChamp("d").setLibelle("Code Client");
    
    if(u.getCodeEtablissement() != null) { 
        String idCodeEtablissement = u.getCodeEtablissement().getId();
        pr.getFormu().getChamp("direction").setDefaut(Utilitaire.champNull(idCodeEtablissement)); 
        pr.setAWhere(String.format(pr.getAWhere() + " and direction like '%s'", idCodeEtablissement));
    }
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme); 
%>
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
                <h1>Liste Budget Depense</h1>
            </section>
            <section class="content">
                <form action="?but=<%=pr.getApres()%>&&champReturn=<%=pr.getChampReturn()%>" method="post" name="cc" id="cc">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%

                    String libelles[] = {"id","designation", "compte", "comptestr", "montant","direction"};
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
<% }catch(Exception ex){
    ex.printStackTrace();
}%>
