<%-- 
    Document   : asBonDeCommande-modif-multiple
    Created on : 9 févr. 2021, 12:10:51
    Author     : andya
--%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{
    String titrePage = "Modification bon de commande" ,
            classeMere = "mg.spat.stock.BonDeCommande" ,
            classeFille = "mg.spat.stock.BonDeCommandeFille",
            buteLien = "stock/bc/asBonDeCommande-fiche.jsp" ,
            colonneMereDansFille = "idbc",
            buteApresVisa = "stock/bc/asBonDeCommande-fiche.jsp";
    
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BonDeCommande mere = new BonDeCommande();
    mere.setNomTable("AS_BONDECOMMANDE_LIBCOMPLET");
    BonDeCommandeFille fille = new BonDeCommandeFille();
    fille.setNomTable("AS_BONDECOMMANDE_FILLE_PRD");
    fille.setIdbc(request.getParameter("id"));
    BonDeCommandeFille[] liste = (BonDeCommandeFille[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    mere = (BonDeCommande)pi.getBase();
    pi.getFormu().getChamp("tva").setVisible(false);
    pi.getFormu().getChamp("Fournisseurlibelle").setVisible(false);
    pi.getFormu().getChamp("Code_etablibelle").setVisible(false);
    pi.getFormu().getChamp("Projetlibelle").setVisible(false);
    pi.getFormu().getChamp("etat").setAutre("readonly");
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
    affichage.Champ[] listess = new affichage.Champ[2];
    TypeObjet d = new TypeObjet();
    d.setNomTable("modepaiement");
    listess[0] = new Liste("modepaiement", d, "val", "id");
    TypeObjet liste2 = new TypeObjet();
    liste2.setNomTable("typecheque");
    listess[1] = new Liste("typepaiement", liste2, "val", "id");
    pi.getFormu().changerEnChamp(listess);
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("projet").setValeurLibelle(mere.getProjetlibelle());
    pi.getFormu().getChamp("code_etab").setAutre("readonly");
    pi.getFormu().getChamp("code_etab").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    pi.getFormu().getChamp("code_etab").setValeurLibelle(mere.getCode_etablibelle());
    pi.getFormu().getChamp("fournisseur").setAutre("readonly");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("modepaiement").setDefaut(Constante.modepaiementDefaut);
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("remarque").setLibelle("Référence");
    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("fournisseur").setLibelle("Fournisseur");
    pi.getFormu().getChamp("fournisseur").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("fournisseur").setValeurLibelle(mere.getFournisseurlibelle());
    pi.getFormu().getChamp("numbc").setLibelle("Numero bon de commande");
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("code_etab").setLibelle("Code etablissement");
    pi.getFormu().getChamp("delaipaiement").setLibelle("Délai de paiement (Jours)");
    pi.getFormu().getChamp("delailivraison").setLibelle("Délai de livraison");
    pi.getFormu().getChamp("typepaiement").setLibelle("Type paiement");
    pi.getFormu().getChamp("idengagement").setLibelle("Engagement");
    pi.getFormu().getChamp("idengagement").setAutre("readonly");
    pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp", "idengagement;idengagementlibelle");
    pi.getFormu().getChamp("idengagement").setValeurLibelle(Utilitaire.champNull(mere.getIdengagementlib()));
    pi.getFormu().getChamp("idengagementlib").setVisible(false);
    affichage.Champ[] listeUnit = new affichage.Champ[1];
    TypeObjet branche=new TypeObjet();
    branche.setNomTable("UNITECHANTIER");
    listeUnit[0]=new Liste("unite",branche,"val","id");
    pi.getFormufle().changerEnChamp(listeUnit);

    pi.getFormufle().getChamp("Unite_0").setLibelle("Unite");
    pi.getFormufle().getChamp("Remarque_0").setLibelle("Désignation");
    pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("produit_0").setLibelle("Produit");
    pi.getFormufle().getChamp("pu_0").setLibelle("Prix Unitaire");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantité");
    pi.getFormufle().getChamp("id_0").setLibelle("ID");
    pi.getFormufle().getChamp("idbc_0").setLibelle("Bon de commande");
    pi.getFormufle().getChamp("tva_0").setLibelle("TVA");
    pi.getFormufle().getChamp("remise_0").setLibelle("Remise %");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("Quantiteparpack"), false);
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idbc"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montant"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("produit"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("quantite"), " onchange='calculMontant(this)' " );
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("pu"), " onchange='calculMontant(this)' " );
//    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montant"), " onchange='calculMontant(this)' ");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("produitlib"), false);
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("produit"), "choix/produitChoix.jsp", "produit;produitlibelle");
    for(int i = 0 ; i < liste.length;i++)
    pi.getFormufle().getChamp("produit_"+i).setValeurLibelle(liste[i].getProduitlib());




//    String[] colOrdreF={"id","idfacture","medicament","Designation","quantite","montant","montantT","remarque"};
//    pi.getFormufle().setColOrdre(colOrdreF);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="box">
            <h1><%= titrePage %></h1>
            <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    pi.getFormufle().makeHtmlInsertTableauIndex();
                %>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                    <%    
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    </div>
                </div>
                   <center style="margin-bottom: 10px;"> <a class="btn btn-success button-margin"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=<%= buteApresVisa %>&classe=<%= classeMere %>">Viser</a> </center>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <%
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                    </div>
                </div>

                <input name="acte" type="hidden" id="nature" value="updateInsert">
                <input name="bute" type="hidden" id="bute" value="<%= buteLien %>?id=<%=request.getParameter("id")%>">
                <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille %>">

            </form>
        </div>
    </div>
</div>
<script>          
//    function calculMontant(elem){ 
//        let i = elem.id.split("_")[1];
//        console.log("elem",elem);
//        console.log("i",i);
//        document.getElementById("montantt_"+i).value = document.getElementById("quantite_"+i).value * document.getElementById("montant_"+i).value ;
//    }    
    function calculMontant(elem) {
        let indice = elem.id.split("_")[1];
        var quantite, pu;
        
        quantite = document.getElementById("quantite_"+indice).value;
        pu = document.getElementById("pu_"+indice).value;
        document.getElementById("montant_"+indice).value = pu * quantite;
    }
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
    throw new Exception("Cette bon de commande n'est pas modifiable.(CEMEDI)");
}%>
