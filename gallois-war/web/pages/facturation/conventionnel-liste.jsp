<%-- 
    Document   : conventionnel-liste
    Created on : 18 nov. 2019, 16:20:26
    Author     : john
--%>

<%@page import="mg.spat.compta.FactPrtMat"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        FactPrtMat journalCaisse = new FactPrtMat();
        journalCaisse.setNomTable("factprtmat");
        String listeCrt[] = {"nmfact","cdtarif","libprt","dtprvprt","dtprt","hrprvprt","hrdebprt","hrfinprt"};
        String listeInt[] = {"dtprvprt","dtprt","hrprvprt","hrdebprt","hrfinprt"};
        String libEntete[] = {"nmfact","cdtarif","libprt","dtprvprt","dtprt","hrprvprt","hrdebprt","hrfinprt","id","qtenb","duree","maj","red","mttligne","mttligar","mtttaxe","tauxtarif"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("/conventionnel-liste.jsp");
        /*pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateEffet2").setLibelle("Date effet max");*/
        String[] colSomme = {"id","qtenb","duree","maj","red","mttligne","mttligar","mtttaxe","tauxtarif"};
        pr.creerObjetPage(libEntete, colSomme);
        
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Details conventionnel</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/conventionnel-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=facturation/conventionnel-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
         
        <%
            String libEnteteAffiche[] ={"nmfact","cdtarif","libprt","dtprvprt","dtprt","hrprvprt","hrdebprt","hrfinprt","id","qtenb","duree","maj","red","mttligne","mttligar","mtttaxe","tauxtarif"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>

        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>

