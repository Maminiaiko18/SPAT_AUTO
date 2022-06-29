
<%@page import="facture.BonProvisoire"%>
<%@page import="mg.spat.Caisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BonProvisoire pj = new BonProvisoire();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pj.setNomTable("bon_provisoire_final");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("etat").setVisible(false);

    //pi.getFormu().getChamp("id").setLibelle("id");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("montant").setLibelle("montant");   
    pi.getFormu().getChamp("remarque").setLibelle("remarque");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("date"); 
    
    affichage.Champ[] liste = new affichage.Champ[1];
    Caisse esc = new Caisse();
    esc.setNomTable("Caisse");
    liste[0] = new Liste("caisse", esc, "val", "id");
    
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("caisse").setLibelle("Caisse de retrait");
    pi.getFormu().getChamp("caisse").setDefaut("CAIS000015");
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
    <input name="bute" type="hidden" id="bute" value="facture/bon-provisoire-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="facture.BonProvisoire">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>