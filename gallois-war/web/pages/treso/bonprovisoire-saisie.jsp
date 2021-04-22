
<%@page import="mg.spat.BonProvisoire"%>
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

    pi.getFormu().getChamp("datesaisie").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("datesaisie").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("dateeffet").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("numpiece").setLibelle("Numero pièce");
    pi.getFormu().getChamp("caisse").setLibelle("Caisse de retrait");
    pi.getFormu().getChamp("dateeffet").setLibelle("Date effet");
    pi.getFormu().getChamp("beneficiaire").setPageAppel("choix/listePersonnelChoix.jsp","beneficiaire;beneficiairelibelle");
    pi.getFormu().getChamp("beneficiaire").setAutre("readonly");

    pi.getFormu().getChamp("debit").setLibelle("Montant");
    pi.getFormu().getChamp("credit").setVisible(false);    
    pi.getFormu().getChamp("folio").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[1];
    Caisse esc = new Caisse();
    esc.setNomTable("CAISSE_UNIQUEMENT");
    liste[0] = new Liste("caisse", esc, "VAL", "id");

    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("caisse").setLibelle("Caisse de retrait");
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
    <input name="bute" type="hidden" id="bute" value="treso/bon-provisoire-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.BonProvisoire">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>