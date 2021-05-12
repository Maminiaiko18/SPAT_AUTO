<%-- 
    Document   : en-attente-de-visa
    Created on : 20 févr. 2016, 11:04:59
    Author     : ITU
--%>
<%@page import="facture.FactureClient"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    FactureClient facture = new FactureClient();
    facture.setNomTable("factureclientMSumC");
    String listeCrt[] = {"id","daty","tiers","designation","type","date_echeance"};
    String listeInt[] = {"daty","date_echeance"};
    String libEntete[] = {"id","daty","tiers","designation","type","tva","remarque","iduser","date_echeance","montant"};
    PageRecherche pr = new PageRecherche(facture, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.getFormu().getChamp("daty1").setLibelle("date debut");
    pr.getFormu().getChamp("daty2").setLibelle("date fin");
    pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
    pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
    
    pr.setApres("facture/factureclient-visa-multiple.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des facture client &agrave; viser</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/mouvement-visa.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="id" id="id">
            <input type="hidden" name="bute" value="facture/factureclient-visa-multiple.jsp"/>
            <input type="hidden" name="classe" value="facture.FactureClient"/>
            <input type="hidden" name="acte" value="viser"/>
            
            <%
                
                String libEnteteAffiche[] ={"id","daty","tiers","designation","type","tva","remarque","user","date echeance","montant"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                pr.getTableau().setNameBoutton("Viser");
                
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>

        </form>
            <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>