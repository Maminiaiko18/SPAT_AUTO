<%@page import="mg.spat.ClientCategorie"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%
    try{
    UserEJB u = (UserEJB) session.getAttribute("u");
    String listeCrt[] = {"cdclt","cdcat", "nomclt", "adrclt", "categorie"};
    String listeInt[] = {};
    String libEntete[] = {"cdclt","cdcat", "nomclt", "adrclt", "categorie"};
    
    ClientCategorie cons = new ClientCategorie();
    
    PageRechercheChoix pr = new PageRechercheChoix(cons, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    
    pr.setChampReturn(request.getParameter("champReturn"));
    pr.setUtilisateur(u);
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("clientCategorieChoix.jsp");
    
    pr.getFormu().getChamp("cdclt").setLibelle("Code Client");
    pr.getFormu().getChamp("cdcat").setLibelle("Code Catégorie");
    pr.getFormu().getChamp("nomclt").setLibelle("Client");
    pr.getFormu().getChamp("adrclt").setLibelle("Adresse");
    pr.getFormu().getChamp("categorie").setLibelle("Catégorie");
    
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
                <h1>Liste Client Catégorie</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="cc" id="cc">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%

                    String libelles[] = {"Code Client", "Code Catégorie", "Client", "Adresse", "Catégorie"};
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
