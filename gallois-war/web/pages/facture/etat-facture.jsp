<%@page import="facture.FactureClient"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="facture.EtatFacture"%>
<%@page import="utilitaire.Constante"%>
<%@page import="java.util.Map"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {
        String lien = (String) session.getValue("lien");
        
        String[] etatVal = {"FACTURECLIENT_EMISE_VALIDE", "FACTURECLIENT_EMISE_CREE", "FACTURECLIENT_EMISE_VISE", "FACTURECLIENT_EMISE_Apayer", "FACTURECLIENT_EMISE_AuComptant", "FACTURECLIENT_EMISE_ACredit", "FACTURECLIENT_EMISE_ANNULER", "FACTURECLIENT_EMISE_ENRETARD", "FACTURECLIENT_EMISE_ENALERTE", "FACTURECLIENT_EMISE_PAYEES"};
        String[] etatAff = {"Tous", "Creee(s)", "Visee(s)", "A payer", "Au comptant", "A credit", "Annulee", "En retard", "En alerte", "Payee(s)"};

        String daty1 = request.getParameter("daty1");
        String daty2 = request.getParameter("daty2");
        String tiers = request.getParameter("tiers");
        String tierslib = request.getParameter("tierslib");
        String etat = request.getParameter("etat") == null ? etatVal[0] : request.getParameter("etat");
        
        if (daty1 == null || daty1.trim().isEmpty()) {
            daty1 = "" + Utilitaire.dateDuJour();
        }
        
        if (daty2 == null || daty2.trim().isEmpty()) {
            daty2 = "" + Utilitaire.dateDuJour();
        }

        EtatFacture etatFacture = new EtatFacture();
        HashMap<String, EtatFacture> listeFacture = etatFacture.getListeFactureEmise(tiers, tierslib, etat, daty1, daty2,null);

%>
<style>
    th {
        text-align: center;
        vertical-align: middle!important;
    }
    .total {
        font-weight: bold;
    }
    .category {
        border: 0;
        border-top: double #060606;
    }
    .general {
        font-size: 17px;
    }
    .list {
        padding: 0 20px;
    }

    .tableca thead th{
        border: #000 solid 2px;
    }
</style>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des factures par tiers</h1>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form action="<%=lien%>?but=facture/etat-facture.jsp" method="post" >
                    <div class="box box-solid collapsed">
                        <div style="background:#103a8e; color:white;" class="box-header with-border">
                            <h3 class="box-title" color="#103a8e"><span color="#103a8e">Recherche avanc&eacute;e</span></h3>
                            <div class="box-tools pull-right"><button data-original-title="Collapse" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="" tabindex="1"><i class="fa fa-plus"></i></button> </div>
                        </div>
                        <div class="box-body" id="pagerecherche">
                            <div class="form-group">
                                <div class="col-md-4">
                                    <label for="annee">Client</label>
                                    <input name="tierslib" type="textbox" class="form-control" id="annee" value="<%=Utilitaire.champNull(tierslib)%>" onkeydown="return searchKeyPress(event)" tabindex="2">
                                </div>
                                <div class="col-md-4">
                                    <label for="annee">Code Client</label>
                                    <input name="tiers" type="textbox" class="form-control" id="annee" value="<%=Utilitaire.champNull(tiers)%>" onkeydown="return searchKeyPress(event)" tabindex="2">
                                    <!--<input name="tierslibelle" type="textbox" class="form-control" id="tierslibelle" value="" readonly="">-->
                                    <!--<input type="hidden" value="" name="tiers" id="tiers">-->
                                    <!--<input name="choix" type="button" class="submit" onclick="pagePopUp('choix/listeTiersChoix.jsp?champReturn=tiers;tierslibelle&amp;apresLienPageAppel=')" value="..." tabindex="2">-->
                                </div>
                                <div class="col-md-4">
                                    <label for="annee">Date Debut</label>
                                    <input name="daty1" type="textbox" class="form-control" id="annee" value="<%=Utilitaire.champNull(daty1)%>" onkeydown="return searchKeyPress(event)" tabindex="3">
                                </div>
                                <div class="col-md-4">
                                    <label for="annee">Date Fin</label>
                                    <input name="daty2" type="textbox" class="form-control" id="annee" value="<%=Utilitaire.champNull(daty2)%>" onkeydown="return searchKeyPress(event)" tabindex="4">
                                </div>
                                <div class="col-md-4">
                                    <label for="annee">Etat</label>
                                    <select name="etat" class="form-control" id="etat">
                                        <%for (int i = 0; i < etatVal.length; i++) {
                                                String selected = etatVal[i].equalsIgnoreCase(etat) ? "selected" : "";

                                        %>
                                        <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                                        <%}%>
                                    </select>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="row"></div>
                            <div class="row">
                                <div class="col-xs-4" align="center">
                                    <button type="reset" class="btn btn-default" tabindex="33">R&eacute;initialiser</button>
                                </div>
                                <div class="col-xs-4" align="center">
                                    <input name="afficher" value="Afficher" type="submit" class="btn" style="background:#103a8e; color:white" id="btnListe" tabindex="34">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="box list">
                <table class="table table-responsive table-hover tableca" width="100%">
                    <thead>
                        <tr>
                            <th>Tiers</th>
                            <th>Designation</th>
                            <th>Montant</th>
                            <th>Montant Pay&eacute;</th>
                            <th>Montant Provision</th>
                            <th>Montant Avoir</th>
                            <th>Montant Reste</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%if(listeFacture!=null){
                            for(String tier : listeFacture.keySet()){
                            
                                EtatFacture etatFact = listeFacture.get(tier);
                                List<FactureClient> factures = etatFact.getFactures();
                                String tierlib = etatFact.getTierslib();
                        %>
                        <tr class="category">
                            <th><%=Utilitaire.champNull(tierlib)%></th>
                        </tr>
                        <%if(factures!=null){for(FactureClient fact : factures){%>
                            <tr>
                                <td><a href="<%=lien%>?but=facture/factureclient-fiche-vaovao.jsp&id=<%=Utilitaire.champNull(fact.getTuppleID())%>"><%=Utilitaire.champNull(fact.getTuppleID())%></a></td>
                                <td><%=Utilitaire.champNull(fact.getDesignation())%></td>
                                <td align="right"><%=Utilitaire.formaterAr(fact.getMontant())%></td>
                                <td align="right"><%=Utilitaire.formaterAr(fact.getMontantpaye())%></td>
                                <td align="right"><%=Utilitaire.formaterAr(fact.getMontantprov())%></td>
                                <td align="right"><%=Utilitaire.formaterAr(fact.getMontantavoir())%></td>
                                <td align="right"><%=Utilitaire.formaterAr(fact.getMontantreste())%></td>
                            </tr>
                            
                        <%}}%>
                            <tr>
                                <td style="font-weight: bold;">Total</td>
                                <td></td>
                                <td align="right" style="font-weight: bold;"><%=Utilitaire.formaterAr(etatFact.getTotalmontant())%></td>
                                <td align="right" style="font-weight: bold;"><%=Utilitaire.formaterAr(etatFact.getTotalmontantregl())%></td>
                                <td align="right" style="font-weight: bold;"><%=Utilitaire.formaterAr(etatFact.getTotalmontantprov())%></td>
                                <td align="right" style="font-weight: bold;"><%=Utilitaire.formaterAr(etatFact.getTotalmontantavoir())%></td>
                                <td align="right" style="font-weight: bold;"><%=Utilitaire.formaterAr(etatFact.getTotalmontnatrap())%></td>
                            </tr>
                        <%}%>
                        <%}%>
                        
                        
                    </tbody>
                </table>
            </div>
            <div class="box-footer">
                <a class="btn btn-default" href="${pageContext.request.contextPath}/Paie?action=impressionEtat_facture&daty1=<%=daty1%>&daty2=<%=daty2%>&tiers=<%=tiers%>&etat=<%=etat%>" style="float:right">Imprimer</a>
            </div>
        </div>
    </section>
</div>
<%} catch (Exception ex) {
        ex.printStackTrace();
    }%>