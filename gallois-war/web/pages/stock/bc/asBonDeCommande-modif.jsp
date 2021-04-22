<%-- 
    Document   : asBonDeCommande-modif
    Created on : 8 déc. 2020, 09:28:55
    Author     : Sanda
--%>
<%@page import="elementchantier.ElementChantier"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageUpdate" %>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BonDeCommande cmd = new BonDeCommande();
    cmd.setNomTable("as_bondecommande_libs");
    PageUpdate pi = new PageUpdate(cmd, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    BonDeCommande baseBC = (BonDeCommande) pi.getBase();
    
    pi.getFormu().getChamp("fournisseur").setValeurLibelle(baseBC.getFournisseur_lib());
    pi.getFormu().getChamp("projet").setValeurLibelle(baseBC.getProjet_lib());
    pi.getFormu().getChamp("code_etab").setValeurLibelle(baseBC.getCode_etab_lib());
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("remarque").setLibelle("remarque");
    pi.getFormu().getChamp("designation").setLibelle("Reference");
    pi.getFormu().getChamp("numbc").setLibelle("Numero Bon De Commande");
    pi.getFormu().getChamp("delaipaiement").setLibelle("Délai de paiement");
    pi.getFormu().getChamp("fournisseur").setLibelle("Fournisseur");
    pi.getFormu().getChamp("fournisseur").setAutre("readonly");
    pi.getFormu().getChamp("fournisseur").setPageAppel("choix/listeTiersChoix.jsp");
    
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    
    pi.getFormu().getChamp("code_etab").setLibelle("Code Etablissement");
    pi.getFormu().getChamp("code_etab").setAutre("readonly");
    pi.getFormu().getChamp("code_etab").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    
    pi.getFormu().getChamp("tva").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("fournisseur_lib").setVisible(false);
    pi.getFormu().getChamp("code_etab_lib").setVisible(false);
    pi.getFormu().getChamp("projet_lib").setVisible(false);
    pi.getFormu().getChamp("modepaiement_lib").setVisible(false);
    
    pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
	 affichage.Champ[] liste = new affichage.Champ[1];

    TypeObjet d = new TypeObjet();
    d.setNomTable("modepaiement");
    liste[0] = new Liste("modepaiement", d, "val", "id");
	
    pi.getFormu().changerEnChamp(liste);
	
    
    pi.preparerDataFormu();
%>
<script  language="JavaScript">
	function calculerMontant(indice) {
        var quantite, pu, montant;
        quantite = parseFloat($('#quantite' + indice).val());
        pu = parseFloat($('#pu' + indice).val());
        if (!isNaN(quantite) && !isNaN(pu)) {
            montant = quantite * pu;
            $('#montant' + indice).val(montant.toFixed(2));
        } else {
            $('#montant' + indice).val('');
        }
    }
</script>
<div class="content-wrapper">
    <div class="col-md-10 col-md-offset-1">
        <h1 class="box-title">Modification bon de commande</h1>
        <form action="<%=pi.getLien()%>?but=stock/bc/apresBC.jsp" method="post" name="bondecommande" id="bondecommande" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertCommande();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    </div>
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="box-content">
                    <div class="box">
                        <div class="box-title with-border">
                            <h1 class="box-title">D&eacute;tails</h1>
                        </div>
                        <div class="box-body table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th style="background-color:#bed1dd">ID</th>
                                        <th style="background-color:#bed1dd">Produit</th>
                                        <th style="background-color:#bed1dd">Prix Unitaire</th>
                                        <th style="background-color:#bed1dd">Quantite</th>
                                        <th style="background-color:#bed1dd">Montant</th>
                                    </tr></thead>
                                <tbody>
                                    <%
                                        BonDeCommandeFille p = new BonDeCommandeFille();
                                        p.setNomTable("as_bondecommande_fille_libelle");
                                        BonDeCommandeFille[] listef = (BonDeCommandeFille[]) CGenUtil.rechercher(p, null, null, " and idbc='"+request.getParameter("id")+"' order by id asc");
                                         for (int i = 0; i < listef.length; i++) {
                                    %>
                                <input type="hidden" class="form form-control" name="nb" id="nb" value="<%=listef.length%>">
                                <tr>
                                    <td><input type="hidden" class="form form-control" name="idFille" id="idFille<%=i%>" value="<%=listef[i].getId()%>"><%=listef[i].getId()%></td>
                                    <td><input type="text" class="form form-control" name="produit" id="produit<%=i%>" value="<%=listef[i].getProduit()%>"></td>
                                    <td><input type="text" class="form form-control" name="pu" id="pu<%=i%>" value="<%=listef[i].getPu()%>" onblur="calculerMontant(<%=i%>)"></td>
                                    <td><input type="text" class="form form-control" name="quantite" id="quantite<%=i%>" value="<%=listef[i].getQuantite()%>" onblur="calculerMontant(<%=i%>)"></td>
                                    <td><input type="text" class="form form-control" name="montant" id="montant<%=i%>" readonly="true"></td>
                                    <td><input type="hidden" class="form form-control" name="rm" id="remarque<%=i%>" value="<%=Utilitaire.champNull(listef[i].getRemarque())%>"></td>
                                </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                                
        <input name="acte" type="hidden" id="nature" value="updateBC">
        <input name="bute" type="hidden" id="bute" value="stock/bc/asBonDeCommande-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.stock.BonDeCommande">
        <button type="submit" name="Submit2" class="btn btn-success pull-right" style="margin-right: 25px;">Enregistrer</button>
        <button type="reset" name="Submit2" class="btn btn-default pull-right" style="margin-right: 15px;">R&eacute;initialiser</button>
    </form>
</div>