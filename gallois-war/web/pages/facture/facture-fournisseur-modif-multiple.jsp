<%-- 
    Document   : prixacte-modif
    Created on : 18 nov. 2020, 18:00:39
    Author     : Daniel
--%>

<%@page import="facturefournisseur.DetailsFactureFournisseur"%>
<%@page import="facturefournisseur.FactureFournisseur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureFournisseur inv = new FactureFournisseur();
    DetailsFactureFournisseur invF = new DetailsFactureFournisseur();
    invF.setIdmere(request.getParameter("id"));
    DetailsFactureFournisseur[] liste = (DetailsFactureFournisseur[])CGenUtil.rechercher(invF, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(inv, invF, liste, request, (user.UserEJB) session.getValue("u"), 10);
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idmere"), "readonly");
    affichage.Champ[] liste1 = new affichage.Champ[1];    
    TypeObjet op = new TypeObjet();
    op.setNomTable("DEVISEDEMAT");
    liste1[0] = new Liste("iddevise", op, "desce", "id");
//        Tva tva = new Tva();
//        liste[1] = new Liste("idtva", tva, "valeurtva", "valeurtva");    
    pi.getFormu().changerEnChamp(liste1);
    pi.getFormu().getChamp("iddevise").setAutre("onblur=\"dependanteChampUneValeur(this.value, 'montantdevise', 'coursdevise', 'fin.Coursdevise', 'iddevise', 'iddevise', 'montant','daty','desc');\"");
//    pi.getFormu().getChamp("exercice").setDefaut(Utilitaire.getAnneeEnCours());   
    pi.getFormu().getChamp("montantdevise").setAutre("readonly");
    pi.getFormu().getChamp("idfournisseur").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("idfournisseur").setAutre("readonly");
//    pi.getFormu().getChamp("remarque").setPageAppel("choix/listeChantierChoix.jsp");
    pi.getFormu().getChamp("remarque").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("code_etablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    pi.getFormu().getChamp("code_etablissement").setAutre("readonly");
//    pi.getFormu().getChamp("datyecheance").setDefaut(Utilitaire.dateDuJour());
//    pi.getFormu().getChamp("dateemission").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("budget").setVisible(false);
    pi.getFormu().getChamp("etat").setAutre("readonly");
    pi.getFormu().getChamp("idtva").setVisible(false);
    pi.getFormu().getChamp("montantttc").setVisible(false);
    pi.getFormu().getChamp("resp").setVisible(false);
    pi.getFormu().getChamp("numeroop").setVisible(false);
     pi.getFormu().getChamp("type").setVisible(false);
    pi.getFormu().getChamp("idfacturefournisseur").setVisible(false);        
    pi.getFormu().getChamp("numfact").setLibelle("Numéro Facture");
//    pi.getFormu().getChamp("remarque").setVisible(false); 
    pi.getFormu().getChamp("remarque").setLibelle("A facturer");
    pi.getFormu().getChamp("budget").setLibelle("Budget");
    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("dateemission").setLibelle("Date d'émission");
    pi.getFormu().getChamp("datyecheance").setLibelle("Date d'échéance");
    pi.getFormu().getChamp("montantdevise").setLibelle("Montant Devise");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idfournisseur").setLibelle("Tiers");
    pi.getFormu().getChamp("numid").setLibelle("Numéro Compta");
    pi.getFormu().getChamp("code_etablissement").setLibelle("Code direction");
    pi.getFormufle().getChamp("Id_0").setLibelle("ID");
    pi.getFormufle().getChamp("Idingredient_0").setLibelle("Référence");
    pi.getFormufle().getChamp("Qte_0").setLibelle("Quantité");
    pi.getFormufle().getChamp("Pu_0").setLibelle("P.U");
    pi.getFormufle().getChamp("Idmere_0").setLibelle("Facture fournisseur");
    pi.getFormufle().getChamp("Iddqe_0").setLibelle("Désignation");
    pi.getFormufle().getChamp("Tva_0").setLibelle("TVA");
    pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");

    pi.getFormufle().setApres("facture/facture-fournisseur-modif-multiple.jsp");
    pi.getFormufle().setRajoutLien("id-"+request.getParameter("id"));

    
    pi.preparerDataFormu();
    
 //pi.getFormufle().getChamp("idproduit_" + i).setPageAppel("choix/medMedPrescriptionChoix.jsp", "idproduit");
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2 ">
            <div class="">
                <div class="box">
                    <h1>Modification facture fournisseur multiple</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            pi.getFormufle().makeHtmlInsertTableauIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                        
                        
                        <input name="acte" type="hidden" id="nature" value="updateInsert">
                        <input name="bute" type="hidden" id="bute" value="facture/facture-fournisseur-modif-multiple.jsp&id=<%=request.getParameter("id")%>">
                        <input name="classe" type="hidden" id="classe" value="facturefournisseur.FactureFournisseur">
                        <input name="classefille" type="hidden" id="classefille" value="facturefournisseur.DetailsFactureFournisseur">
                        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                        <input name="colonneMere" type="hidden" id="colonneMere" value="idmere">
                        
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('tbody tr th:nth-child(8)').hide();
    $('tbody tr td:nth-child(8)').hide();
    $('tbody tr th:nth-child(10)').hide();
    $('tbody tr td:nth-child(10)').hide();
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>

