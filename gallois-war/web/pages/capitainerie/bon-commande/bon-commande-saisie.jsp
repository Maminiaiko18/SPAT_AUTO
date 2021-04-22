<%-- 
    Document   : bon-commande-saisie
    Created on : 10 déc. 2019, 17:39:05
    Author     : HP
--%>

<%@page import="mg.spat.ContratEngagementBonCommande"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ContratEngagementBonCommande pj = new ContratEngagementBonCommande();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("mode_reglement");
//    String [] val = {"Espece", "Cheque", "Mobile money"};
//    String [] aff = {"Espece", "Cheque", "Mobile money"};
    String [] val = {"Cheque", "Virement"};
    String [] aff = {"Cheque", "Virement"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("num_bc").setLibelle("Numero bon de commande");
    pi.getFormu().getChamp("organe_demandeur").setLibelle("Organe demandeur");
      pi.getFormu().getChamp("id_organe_demandeur").setVisible(false);
    pi.getFormu().getChamp("type_commande").setLibelle("Type commande");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("montant_ht").setLibelle("Montant ht");
    pi.getFormu().getChamp("montant_ttc").setLibelle("montant ttc");
    pi.getFormu().getChamp("montant_autoriser").setLibelle("Montant autoris&eacute;");
    pi.getFormu().getChamp("fournisseur_id").setLibelle("Fournisseur");
    pi.getFormu().getChamp("bon_livraison").setLibelle("Bon livraison");
    pi.getFormu().getChamp("bon_entre").setLibelle("Bon entr&eacute;");
    pi.getFormu().getChamp("date_livraison").setLibelle("Date livraison");
    pi.getFormu().getChamp("facturer").setLibelle("facturer");
    pi.getFormu().getChamp("ordre_de_paiement").setLibelle("Ordre de payer");
    pi.getFormu().getChamp("reference_paiement").setLibelle("Reference paiement");
    pi.getFormu().getChamp("type_paiement").setLibelle("Type paiement");
    pi.getFormu().getChamp("tva_valider").setLibelle("Tva valid&eacute;");
    pi.getFormu().getChamp("type").setLibelle("Type");
    pi.getFormu().getChamp("condition_reglement").setLibelle("Condition reglement");
    pi.getFormu().getChamp("mode_reglement").setLibelle("Mode reglement");
    pi.getFormu().getChamp("note").setLibelle("Observation");
    pi.getFormu().getChamp("fournisseur_id").setPageAppel("choix/listeFournisseurContratChoix.jsp");
    pi.getFormu().getChamp("fournisseur_id").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un Contrat d'Engagement de Bon de Commande</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/bon-commande/bon-commande-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.ContratEngagementBonCommande">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>
