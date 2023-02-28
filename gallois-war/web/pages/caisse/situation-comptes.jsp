<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="caisse.SituationComptesData"%>
<%@page import="bean.ClassMAPTable"%>
<%@page import="bean.AdminGen"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.amadia.stock.EtatdeStockDate"%>
<%
    try {
        String lien = (String) session.getValue("lien"),
                apres = "caisse/situation-comptes.jsp";
        String daty1, daty2;
        daty1 = request.getParameter("daty2");
        daty2 = request.getParameter("daty2");
        if (daty1 == null || daty1.compareToIgnoreCase("") == 0) {
            daty1 = Utilitaire.dateDuJour();
        }
        if (daty2 == null || daty2.compareToIgnoreCase("") == 0) {
            daty2 = Utilitaire.dateDuJour();
        }
        String colonne = null, ordre = null;
        if (request.getParameter("colonne") != null && request.getParameter("ordre") != null) {
            colonne = request.getParameter("colonne");
            ordre = request.getParameter("ordre");
        }

//        EtatdeStockDate[] stock = EtatdeStockDate.calculEtatCaisse(daty2, request.getParameter("ingredients"), null, null, colonne, ordre, daty1);
        SituationComptesData datas = new SituationComptesData(daty2, daty1, request.getParameter("ingredients"), colonne, ordre);
        ClassMAPTable[] caisseAr = datas.getCaisseAr();
        EtatdeStockDate totalComptes = datas.getTotalComptes();
        ClassMAPTable[] banqueDevise = datas.getBanqueDevise();
        EtatdeStockDate totalBanqueDevise = datas.getTotalBanqueDevise();
        EtatdeStockDate[] placementAr = datas.getPlacementAr();
        double totalPlacementAr = datas.getTotalPlacementAr();
        EtatdeStockDate[] placementDevise = datas.getPlacementDevise();
        double totalPlacementDevise = datas.getTotalPlacementDevise();
        EtatdeStockDate[] recapitulatifComptes = datas.getRecapitulatifComptes();
        EtatdeStockDate[] recapitulatifPlacement = datas.getRecapitulatifPlacement();
        double totalTresorerie = datas.getTotalTresorerie();
        double totalPlacement = datas.getTotalPlacement();
        double montantBP = datas.getTotal() - datas.getMontantBP();
        double total = datas.getTotal();
        
        
%>
<style>
    .th-center {
        vertical-align: middle !important;
        text-align: center; 
    }
</style>

<div class="content-wrapper" style="min-height: 638px;">
    <section class="content-header">
        <h1>SITUATION DE TRESORERIE ESTIMEE AU <%=daty1%></h1>
    </section>
    <section class="content">
        <div class="row">
            <form action="<%=lien%>?but=<%=apres%>" method="post" name="situation" id="situation">
                <div class="box box-solid collapsed">
                    <div style="background-color:#103a8e; color:white;" class="box-header with-border">
                        <h3 class="box-title" color="#edb031">
                            <span color="#edb031">Recherche avanc�e</span>
                        </h3>
                        <div class="box-tools pull-right">
                            <button data-original-title="Collapse" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="">
                                <i class="fa fa-minus"></i>
                            </button> 
                        </div>
                    </div>
                    <div class="box-body" id="pagerecherche" style="display: block;">
                        <div class="form-group">
                            <div class="col-md-4">
                                <!--<label for="Date" debut="">Date debut</label>
                                <input name="daty1" type="text" class="form-control datepicker" id="daty1" value="<%//=daty1%>" onkeydown="return searchKeyPress(event)">-->
                            </div>
                            <div class="col-md-4">
                                <label for="Date" debut="">Date</label>
                                <input name="daty2" type="text" class="form-control datepicker" id="daty1" value="<%=daty2%>" onkeydown="return searchKeyPress(event)">
                            </div>
                        </div>
                    </div>
                    <br/>
                    <div class="box-footer" style="display: block;">
                        <div class="row">
                            <div class="col-xs-4" align="center">
                                <button type="reset" class="btn btn-default">R�initialiser</button>
                                    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=recapitulatifCompteCourant&daty2=<%=daty2%>&daty1=<%=daty1%>&ingredient=<%=request.getParameter("ingredients")%>&colonne=<%=colonne%>&ordre=<%=ordre%>" style="margin-right: 10px">Imprimer</a>
                            </div>
                            <div class="col-xs-4" align="center">
                                <input name="afficher" value="Afficher" type="submit" class="btn" style="background:#103a8e; color:white" id="btnListe">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <br/>
        <div class="row">
            <div class="box box-solid">
                <div style="background:#ffb401; color:white;" class="box-header">
                    <h3 class="box-title" align="center">SITUATION COMPTES COURANTS</h3>
                </div>

                <div class="box-body table-responsive no-padding">
                    <div id="selectnonee">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <thead>
                                <tr class="head">
                                    <th align="center" valign="top" style="background-color:#103a8e;" rowspan="2" class="th-center">
                                        <a href="#" style="color:white;">NOM BANQUE</a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" rowspan="2" class="th-center">
                                        <a href="#" style="color:white;">SOLDE DU <%=Utilitaire.ajoutJourDateString(Utilitaire.stringDate(daty2), -1)%></a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" colspan="2" class="th-center">
                                        <a href="#" style="color:white;">MOUVEMENTS</a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" rowspan="2" class="th-center">
                                        <a href="#" style="color:white;">SOLDE FINAL</a>
                                    </th>
                                </tr>
                                <tr class="head">
                                    <th align="center" valign="top" style="background-color:#103a8e" class="th-center">
                                        <a href="#" style="color:white;">ENTREE</a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" class="th-center">
                                        <a href="#" style="color:white;">SORTIE</a>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = 0; i < caisseAr.length; i++) {
                                        EtatdeStockDate caisse = (EtatdeStockDate) caisseAr[i];
                                        String dateMin = Utilitaire.datetostring(Utilitaire.ajoutJourDate(caisse.getDaty(), 1));
                                %>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                    <td align="left"><%=Utilitaire.champNull(caisse.getIngredients())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(caisse.getReport())%></td>
                                    <td align="right"><a href="<%=lien%>?but=treso/recette-liste.jsp&mode&valcaisse=<%=Utilitaire.champNull(caisse.getIngredients())%>&etat=<%=ConstanteEtat.getEtatValider()%>&dateEffet1=<%=daty2%>&dateEffet2=<%=daty2%>&type=debit"><%=Utilitaire.formaterAr(caisse.getEntree())%></a></td>
                                    <td align="right"><a href="<%=lien%>?but=treso/depense-liste.jsp&mode&valcaisse=<%=Utilitaire.champNull(caisse.getIngredients())%>&etat=<%=ConstanteEtat.getEtatValider()%>&dateEffet1=<%=daty2%>&dateEffet2=<%=daty2%>"><%=Utilitaire.formaterAr(caisse.getSortie())%></a></td>
                                    <td align="right"><%=Utilitaire.formaterAr(caisse.getReste())%></td>
                                </tr>
                                <% }%>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                    <td align="right">TOTAL</td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalComptes.getReport())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalComptes.getEntree())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalComptes.getSortie())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalComptes.getReste())%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="box box-solid">
                <div style="background:#ffb401; color:white;" class="box-header">
                    <h3 class="box-title" align="center">SITUATION COMPTES BANQUES EN DEVISE</h3>
                </div>
                <div class="box-body table-responsive no-padding">
                    <div id="selectnonee">
                        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <thead>
                                <tr class="head">
                                    <th align="center" valign="top" style="background-color:#103a8e;" rowspan="2" class="th-center">
                                        <a href="#" style="color:white;">INTITULE</a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" rowspan="2" class="th-center">
                                        <a href="#" style="color:white;">SOLDE INITIAL</a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" colspan="2" class="th-center">
                                        <a href="#" style="color:white;">MOUVEMENTS</a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" rowspan="2" class="th-center">
                                        <a href="#" style="color:white;">SOLDE FINAL</a>
                                    </th>
                                </tr>
                                <tr class="head">
                                    <th align="center" valign="top" style="background-color:#103a8e" class="th-center">
                                        <a href="#" style="color:white;">ENTREE</a>
                                    </th>
                                    <th align="center" valign="top" style="background-color:#103a8e" class="th-center">
                                        <a href="#" style="color:white;">SORTIE</a>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < banqueDevise.length; i++) {
                                        EtatdeStockDate caisse = (EtatdeStockDate) banqueDevise[i];
                                %>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                    <td align="left"><%=Utilitaire.champNull(caisse.getIngredients())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(caisse.getReport())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(caisse.getEntree())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(caisse.getSortie())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(caisse.getReste())%></td>
                                </tr>
                                <% }%>
                                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                    <td align="right">TOTAL</td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalBanqueDevise.getReport())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalBanqueDevise.getEntree())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalBanqueDevise.getSortie())%></td>
                                    <td align="right"><%=Utilitaire.formaterAr(totalBanqueDevise.getReste())%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="col-md-6">
                <div class="box box-solid">
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr class="head">
                                        <th width="5%" align="center" valign="top" style="background-color:#103a8e; color: white" colspan="2" class="th-center">PLACEMENT EN ARIARY</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < placementAr.length; i++) {%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="left"><%=Utilitaire.champNull(placementAr[i].getIngredients())%></td>
                                        <td align="right"><%=Utilitaire.formaterAr(placementAr[i].getMontantStock())%></td>
                                    </tr>
                                    <% }%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="right">TOTAL</td>
                                        <td align="right"><%=Utilitaire.formaterAr(totalPlacementAr)%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="box box-solid">
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                <th align="center" valign="top" width="5%" style="background-color:#103a8e; color: white" colspan="2" class="th-center">PLACEMENT EN DEVISE</th>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < placementDevise.length; i++) {%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="left"><%=Utilitaire.champNull(placementDevise[i].getIngredients())%></td>
                                        <td align="right"><%=Utilitaire.formaterAr(placementDevise[i].getMontantStock())%></td>
                                    </tr>
                                    <% }%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="right">TOTAL EN EURO</td>
                                        <td align="right"><%=Utilitaire.formaterAr(totalPlacementDevise)%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="col-md-6">
                <div class="box box-solid">
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead>
                                    <tr class="head">
                                        <th align="center" valign="top" style="background-color:#103a8e; color:white;" class="th-center">RECAPITULATIF</th>
                                        <th align="center" valign="top" style="background-color:#103a8e; color:white;" class="th-center">MONTANT EN ARIARY</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < recapitulatifComptes.length; i++) {%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="left"><%=Utilitaire.champNull(recapitulatifComptes[i].getIngredients())%></td>
                                        <td align="right"><%=Utilitaire.formaterAr(recapitulatifComptes[i].getMontantStock())%></td>
                                    </tr>
                                    <% }%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="right">TOTAL TRESORERIE SPAT</td>
                                        <td align="right"><%=Utilitaire.formaterAr(totalTresorerie)%></td>
                                    </tr>
                                    <% for (int i = 0; i < recapitulatifPlacement.length; i++) {%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="left"><%=Utilitaire.champNull(recapitulatifPlacement[i].getIngredients())%></td>
                                        <td align="right"><%=Utilitaire.formaterAr(recapitulatifPlacement[i].getMontantStock())%></td>
                                    </tr>
                                    <% }%>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="">
                                        <td align="right">TOTAL PLACEMENT SPAT</td>
                                        <td align="right"><%=Utilitaire.formaterAr(totalPlacement)%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section>
        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
            <thead>
                <!--                <tr class="head">
                                    <th align="center" valign="top" style="background-color:#103a8e; color:white;" class="th-center">RECAPITULATIF</th>
                                    <th align="center" valign="top" style="background-color:#103a8e; color:white;" class="th-center">MONTANT EN ARIARY</th>
                                </tr>-->
            </thead>
            <tbody>
                
                <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''" style="border-top: solid; border-bottom: solid">
                    <td align="right" class="th-center"><h3>TOTAL</h3></td>
                    <td align="left" class="th-center"><h3><%=Utilitaire.formaterAr(total)%></h3></td>
                </tr>
                
            </tbody>
        </table>
    </section>
</div>
<% } catch (Exception ex) {
        ex.printStackTrace();
    }%>