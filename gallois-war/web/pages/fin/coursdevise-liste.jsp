<%-- 
    Document   : coursdevise-liste
    Created on : 8 févr. 2021, 16:26:55
    Author     : ACER
--%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="fin.Coursdevise"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        Coursdevise cd = new Coursdevise();
        cd.setNomTable("coursdeviselib");
        String listeCrt[] = {"id", "iddevise", "daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "daty", "iddevise", "montant", "estMICTSLlib"};
        PageRecherche pr = new PageRecherche(cd, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("iddevise").setLibelle("Devise");
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);
        
        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);
            
        }
    
        pr.setOrdre(" order by daty desc");
        pr.setApres("fin/coursdevise-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeplacement.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste cours devise</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=fin/coursdevise-liste.jsp" method="post" name="listeplacement" id="listeplacement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=fin/coursdevise-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Date", "Devise", "Montant", "Est MICTSL"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
