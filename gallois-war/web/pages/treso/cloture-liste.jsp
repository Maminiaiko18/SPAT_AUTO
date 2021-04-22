<%-- 
    Document   : navire-liste
    Created on : 5 nov. 2019, 11:09:25
    Author     : john
--%>

<%@page import="mg.spat.Cloture"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    Cloture cloture = new Cloture();
    cloture.setNomTable("cloturerlib");
    String listeCrt[] = {"id", "caisse", "solde","remarque"};
    String listeInt[] = {};
    String libEntete[] = {"id","daty", "caisse", "solde","remarque"};
    PageRecherche pr = new PageRecherche(cloture, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    //pr.getFormu().getChamp("daty").setLibelle("Date");
    
    
    pr.setApres("treso/cloture-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Clôtures</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/cloture-liste.jsp" method="post" name="listenavire" id="listenavire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso/cloture-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Date", "Caisse", "Solde","Remarque"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    throw e;
}%>