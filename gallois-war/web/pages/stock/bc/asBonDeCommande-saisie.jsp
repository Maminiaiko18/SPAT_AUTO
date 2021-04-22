<%@page import="elementchantier.ElementChantier"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="utilitaire.Constante" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageInsert" %>

<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = (UserEJB) session.getAttribute("u");
        BonDeCommande cmd = new BonDeCommande();
        PageInsert pi = new PageInsert(cmd, request,u);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("tva").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
        affichage.Champ[] liste = new affichage.Champ[2];
        TypeObjet d = new TypeObjet();
        d.setNomTable("modepaiement");
        liste[0] = new Liste("modepaiement", d, "val", "id");
        TypeObjet liste2 = new TypeObjet();
        liste2.setNomTable("typecheque");
        liste[1] = new Liste("typepaiement", liste2, "val", "id");
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("code_etab").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("code_etab").setAutre("readonly");
        pi.getFormu().getChamp("fournisseur").setAutre("readonly");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("modepaiement").setDefaut(Constante.modepaiementDefaut);
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("remarque").setLibelle("Référence");
        pi.getFormu().getChamp("designation").setLibelle("Designation");
        pi.getFormu().getChamp("fournisseur").setLibelle("Fournisseur");
        pi.getFormu().getChamp("numbc").setLibelle("Numero bon de commande");
        pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
        pi.getFormu().getChamp("fournisseur").setPageAppel("choix/listeTiersChoix.jsp");
        pi.getFormu().getChamp("code_etab").setLibelle("Code etablissement");
        pi.getFormu().getChamp("delaipaiement").setLibelle("Délai de paiement (Jours)");
        pi.getFormu().getChamp("delailivraison").setLibelle("Délai de livraison");
        pi.getFormu().getChamp("typepaiement").setLibelle("Type paiement");
        String[] colOrdreF={"designation", "daty", "fournisseur", "modepaiement","remarque"};
        pi.getFormu().setColOrdre(colOrdreF);
       // pi.getFormu().setOrdre(new String[] {"designation", "daty", "fournisseur", "modepaiement","remarque"});
        pi.preparerDataFormu();
        int taille = 10;
        
        TypeObjet unite = new TypeObjet();
        unite.setNomTable("UNITECHANTIER");
        TypeObjet[] unites = (TypeObjet[]) CGenUtil.rechercher(unite, null, null, "");
        int j =0, tailleUnite = unites.length;
%>
<div class="content-wrapper">
    <h1 class="box-title">Enregistrer bon de commande</h1>
    <form class='container' action="<%=pi.getLien()%>?but=stock/bc/apresBC.jsp" method="post" name="bondecommande" id="bondecommande" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertCommande();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <div class="box">
            <div class="box-title with-border">
                <h1 class="box-title">D&eacute;tails</h1>
            </div>
            <div class="box-body table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="background-color:#bed1dd" colspan="2">Produit</th>
                            <th style="background-color:#bed1dd">Prix Unitaire</th>
                            <th style="background-color:#bed1dd">Quantite</th>
                            <th style="background-color:#bed1dd">Montant</th>
                            <th style="background-color:#bed1dd">Tva</th>
                            <th style="background-color:#bed1dd">Unité</th>
                        </tr></thead>
                    <tbody>
                        <%
                            for (int i = 0; i < taille; i++) {
                        %>
                    <tr>
                        <td><input type="text" class="form form-control" name="produit" id="produit<%=i%>" ></td>
                        <td>
                            <input name="choix" type="button" class="submit" onclick="pagePopUp('choix/produitChoix.jsp?champReturn=produit<%=i%>')" value="...">
                        </td>
                        <td><input type="text" class="form form-control" name="pu" id="pu<%=i%>" onblur="calculerMontant(<%=i%>)"></td>
                        <td><input type="text" class="form form-control" name="quantite" id="quantite<%=i%>" onblur="calculerMontant(<%=i%>)"></td>
                        <td><input type="text" class="form form-control" name="montant" id="montant<%=i%>" readonly="true"></td>
                        <td><input type="text" class="form form-control" name="tva" id="tva<%=i%>"></td>
                        <td><input type="hidden" class="form form-control" name="remarque" id="remarque<%=i%>"></td>
                        <td>
                            <select class="form form-control" name="unite" id="unite<%=i%>">
                                <%for(j=0;j<tailleUnite;j++){%>
                                    <option value="<%=unites[j].getId()%>"><%=unites[j].getVal()%></option>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <script>calculerMontant(<%=i%>)</script>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <input type="hidden" class="form form-control" name="nb" id="nb" value="<%=taille%>">                                    
        <input name="acte" type="hidden" id="nature" value="insertBC">
        <input name="bute" type="hidden" id="bute" value="stock/bc/asBonDeCommande-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.stock.BonDeCommande">
        <button type="submit" name="Submit2" class="btn btn-success pull-right" style="margin-right: 25px;">Enregistrer</button>
        <button type="reset" name="Submit2" class="btn btn-default pull-right" style="margin-right: 15px;">R&eacute;initialiser</button>
    </form>
</div>

<script  language="JavaScript">
    function calculerMontant(indice) {
        var quantite, pu, montant;
        quantite = parseFloat($('#quantite' + indice).val());
//        quantite = quantite / 1000;
        pu = parseFloat($('#pu' + indice).val());
        if (!isNaN(quantite) && !isNaN(pu)) {
            montant = quantite * pu;
            $('#montant' + indice).val(montant.toFixed(2));
        } else {
            $('#montant' + indice).val('');
        }
    }
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>
