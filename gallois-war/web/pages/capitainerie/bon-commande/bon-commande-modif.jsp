<%-- 
    Document   : bon-commande-modif
    Created on : 10 déc. 2019, 17:39:25
    Author     : HP
--%>

<%@page import="mg.spat.ContratEngagementBonCommande"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ContratEngagementBonCommande c = new ContratEngagementBonCommande();
    PageUpdate pi = new PageUpdate(c, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("mode_reglement");
    String [] val = {"Espece", "Cheque", "Mobile money"};
    String [] aff = {"Espece", "Cheque", "Mobile money"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("num_bc").setLibelle("Numero bon de commande");
    pi.getFormu().getChamp("organe_demandeur").setLibelle("Organe demandeur");
    pi.getFormu().getChamp("type_commande").setLibelle("Type commande");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("montant_ht").setLibelle("Montant ht");
    pi.getFormu().getChamp("montant_ttc").setLibelle("montant ttc");
    pi.getFormu().getChamp("montant_autoriser").setLibelle("Montant autoriser");
    pi.getFormu().getChamp("fournisseur_id").setLibelle("Fournisseur");
    pi.getFormu().getChamp("bon_livraison").setLibelle("Bon livraison");
    pi.getFormu().getChamp("bon_entre").setLibelle("Bon entre");
    pi.getFormu().getChamp("date_livraison").setLibelle("Date livraison");
    pi.getFormu().getChamp("facturer").setLibelle("facturer");
    pi.getFormu().getChamp("ordre_de_paiement").setLibelle("Ordre de paiement");
    pi.getFormu().getChamp("reference_paiement").setLibelle("Reference paiement");
    pi.getFormu().getChamp("type_paiement").setLibelle("Type paiement");
    pi.getFormu().getChamp("tva_valider").setLibelle("Tva valider");
    pi.getFormu().getChamp("type").setLibelle("Type");
    pi.getFormu().getChamp("condition_reglement").setLibelle("Condition reglement");
    pi.getFormu().getChamp("mode_reglement").setLibelle("Mode reglement");
    pi.getFormu().getChamp("note").setLibelle("Note");
    pi.getFormu().getChamp("fournisseur_id").setPageAppel("choix/listeFournisseurContratChoix.jsp");
    pi.getFormu().getChamp("fournisseur_id").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification Contrat Bon Commande</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="capitainerie/bon-commande/bon-commande-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.ContratEngagementBonCommande">
                        <input name="nomtable" type="hidden" id="nomtable" value="contrat_engagement_boncommande">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
