<%-- 
    Document   : report-liste
    Created on : 13 nov. 2019, 09:24:05
    Author     : john
--%>

<%@page import="mg.spat.Report"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        Report report = new Report();
        String table = "reportlib";
        if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
            table=request.getParameter("table");
        }
        
        report.setNomTable(table);
        String listeCrt[] = {"id", "daty","caisse","devise"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id",  "daty", "caisse", "montant", "devise"};
        PageRecherche pr = new PageRecherche(report, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");

        pr.setOrdre(" order by daty desc");

        pr.setApres("treso/report-liste.jsp");
        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listereport.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des reports</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/report-liste.jsp" method="post" name="listereport" id="listereport">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                Etat : 
                <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                   <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("reportlib") == 0) {%>    
                    <option value="reportlib" selected>Tous</option>
                    <% } else { %>
                    <option value="reportlib" >Tous</option>
                    <% } %>
                    <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("report_cree") == 0) {%>    
                    <option value="REPORTLIBC" selected>Cr��</option>
                    <% } else { %>
                    <option value="REPORTLIBC" >Cr��</option>
                    <% } %>
                    <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("report_vise") == 0) {%>    
                    <option value="REPORTLIBV" selected>Vis�</option>
                    <% } else { %>
                    <option value="REPORTLIBV" >Vis�</option>
                    <% } %>

                </select>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/report-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Date", "Caisse", "Montant","Devise"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
