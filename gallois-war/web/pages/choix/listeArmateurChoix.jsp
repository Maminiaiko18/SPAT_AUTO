<%@page import="mg.spat.Armateur"%>
<%@page import="mg.spat.exploitant.Activite"%>
<%@ page import="user.*" %>
<%@page import="mg.spat.Navire"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    String champReturn = request.getParameter("champReturn");
    Armateur quais = new Armateur(); 
    quais.setNomTable("ACTIVITELIBCOMPLET");

    String listeCrt[] = {"id","nom", "adresse"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","contact","adresse","nif","stat", "mail"};
    String libelleAffiche[] = {"ID","Nom","Contact","Adresse","NIF","STAT", "Email"};
    
    PageRechercheChoix pr = new PageRechercheChoix(quais, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeArmateurChoix.jsp");
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    pr.getFormu().getChamp("adresse").setLibelle("Adresse");
    
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
                <h1>Choix Armateur</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    pr.getTableau().setLibelleAffiche(libelleAffiche);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>O
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

<% }catch(Exception ex){
ex.printStackTrace();
}%>