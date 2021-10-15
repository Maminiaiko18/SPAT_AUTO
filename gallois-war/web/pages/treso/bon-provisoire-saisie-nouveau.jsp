
<%@page import="facture.FactureFournisseur"%>
<%@page import="mg.spat.Caisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureFournisseur pj = new FactureFournisseur();
    pj.setNomTable("facture_fourn_mere_vide");
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));

    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("type").setVisible(false);
    pi.getFormu().getChamp("tiers").setLibelle("Bénéficiaire");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listePersonnelChoix.jsp","tiers;tierslibelle");
    pi.getFormu().getChamp("tiers").setAutre("readonly");

    pi.getFormu().getChamp("designation").setLibelle("Désignation");
    pi.getFormu().getChamp("code").setLibelle("Numéro pièce");    
    pi.getFormu().getChamp("montant").setLibelle("Montant"); 
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un bon provisoire</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="treso/bon-provisoire-fiche-nouveau.jsp">
    <input name="classe" type="hidden" id="classe" value="facture.FactureFournisseur">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>