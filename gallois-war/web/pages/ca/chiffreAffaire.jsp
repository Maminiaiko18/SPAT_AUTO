<%@page import="mg.spat.CA"%>
<%@page import="java.util.Map"%>
<%@page import="mg.spat.EtatCA"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%
    try {
        String lien = (String) session.getValue("lien");

        String mois = request.getParameter("mois");
        String annee = request.getParameter("annee");

        if (mois == null || mois.trim().isEmpty()) {
            mois = "" + Utilitaire.getMoisEnCoursReel();
        }
        if (annee == null || annee.trim().isEmpty()) {
            annee = "" + Utilitaire.getAneeEnCours();
        }

        Liste moisL = new Liste("mois");
        moisL.makeListeMois();
        moisL.setDefaut("" + mois);

        String moisEnLettre = (String) moisL.getValeurBrute()[Utilitaire.stringToInt(mois) - 1];

        EtatCA etatCA = new EtatCA(mois, annee, true);
        Map<String, CA[]> listeParRubrique = etatCA.getListeParRubrique();
        Map<String, CA> sommePartiel = etatCA.getSommePartiel();
        CA totalGeneral = etatCA.getTotalGeneral();
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
</style>
<div class="content-wrapper">
    <section class="content-header">
        <h1>CHIFFRE D'AFFAIRES SUR LES FACTURES EMISES MOIS DE <%= moisEnLettre.toUpperCase()%> <%= annee%>  </h1>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form action="<%=lien%>?but=ca/chiffreAffaire.jsp" method="post" >
                    <div class="box box-solid collapsed">
                        <div style="background:#103a8e; color:white;" class="box-header with-border">
                            <h3 class="box-title" color="#103a8e"><span color="#103a8e">Recherche avancée</span></h3>
                            <div class="box-tools pull-right"><button data-original-title="Collapse" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="" tabindex="1"><i class="fa fa-plus"></i></button> </div>
                        </div>
                        <div class="box-body" id="pagerecherche">
                            <div class="form-group">
                                <div class="col-md-4">
                                    <label for="mois">Mois</label>
                                    <%
                                        moisL.makeHtml();
                                        out.print(moisL.getHtml());
                                    %>
                                </div>
                                <div class="col-md-4">
                                    <label for="annee">Ann&eacute;e</label>
                                    <input name="annee" type="textbox" class="form-control" id="annee" value="<%=annee%>" onkeydown="return searchKeyPress(event)" tabindex="3">
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="row"></div>
                            <div class="row">
                                <div class="col-xs-4" align="center">
                                    <button type="reset" class="btn btn-default" tabindex="33">Réinitialiser</button>
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
                <table class="table table-responsive table-hover" width="100%">
                    <thead>
                        <tr>
                            <th rowspan="2">Libelle</th>
                            <th colspan="4">Mouvement du mois anterieur</th>
                            <th colspan="4">Mouvement du mois en cours</th>
                            <th rowspan="2">N. Cumule</th>
                            <th rowspan="2">Taux</th>
                        </tr>
                        <tr>
                            <th>Ancien Cumul</th>
                            <th>Regul 1</th>
                            <th>Regul E & P</th>
                            <th>A. Cum. Regul</th>
                            <th>Avoir E & P</th>
                            <th>Comptant</th>
                            <th>Credit</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (listeParRubrique != null) {
                                for (String rubrique : listeParRubrique.keySet()) {%>
                        <tr class="category">
                            <th><%=Utilitaire.champNull(rubrique.toUpperCase())%></th>
                        </tr>
                        <% for (CA ca : listeParRubrique.get(rubrique)) {%>
                        <tr>
                            <td><%=Utilitaire.champNull(ca.getLibelle())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getAnciencumul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getRegul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getRegulEETP())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getAvoirCumRegul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getAvoirEETP())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getComptant())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getCredit())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getTotal())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getNCumul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(ca.getTaux())%></td>
                        </tr>
                        <% } %>
                        <%
                            CA partiel = sommePartiel.get(rubrique);
                        %>
                        <tr class="total">
                            <td align="center"><%=rubrique.toUpperCase()%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getAnciencumul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getRegul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getRegulEETP())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getAvoirCumRegul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getAvoirEETP())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getComptant())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getCredit())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getTotal())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getNCumul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(partiel.getTaux())%></td>
                        </tr>
                        <% }
                            } %>
<!--
                        <tr class="category">
                            <th>ASSISTANCES AUX NAVIRES</th>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr class="total">
                            <td align="center">ASSISTANCES AUX NAVIRES</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>

                        <tr class="category">
                            <th>ASSISTANCES AUX NAVIRES</th>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr class="total">
                            <td align="center">ASSISTANCES AUX NAVIRES</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>

                        <tr class="category">
                            <th>ASSISTANCES AUX NAVIRES</th>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr class="total">
                            <td align="center">ASSISTANCES AUX NAVIRES</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>

                        <tr class="category">
                            <th>ASSISTANCES AUX NAVIRES</th>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr class="total">
                            <td align="center">ASSISTANCES AUX NAVIRES</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>

                        <tr class="category">
                            <th>ASSISTANCES AUX NAVIRES</th>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr class="total">
                            <td align="center">ASSISTANCES AUX NAVIRES</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>

                        <tr class="category">
                            <th>ASSISTANCES AUX NAVIRES</th>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr class="total">
                            <td align="center">ASSISTANCES AUX NAVIRES</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>

                        <tr class="category">
                            <th>ASSISTANCES AUX NAVIRES</th>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr>
                            <td>AUTORISATION D'IMMOBILISATION</td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">320226559.99</td>
                            <td align="right"></td>
                            <td align="right">221754.40</td>
                            <td align="right">23655672.07</td>
                            <td align="right">23677626.47</td>
                            <td align="right">344104195.45</td>
                            <td align="right">0.38</td>
                        </tr>
                        <tr class="total">
                            <td align="center">ASSISTANCES AUX NAVIRES</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>-->
                        <!--<tr class="category total general">
                            <td align="left">TOTAL GENERAL</td>
                            <td align="right">1214810099.25</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right">1214818099.25</td>
                            <td align="right"></td>
                            <td align="right">5983708.57</td>
                            <td align="right">51074715.23</td>
                            <td align="right">57058423.80</td>
                            <td align="right">1271888523.05</td>
                            <td align="right">0.90</td>
                        </tr>-->
                        <% if(totalGeneral != null) { %>
                        <tr class="category total general">
                            <td align="left"><%=Utilitaire.champNull(totalGeneral.getLibelle().toUpperCase())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getAnciencumul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getRegul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getRegulEETP())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getAvoirCumRegul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getAvoirEETP())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getComptant())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getCredit())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getTotal())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getNCumul())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getTaux())%></td>
                        </tr>
                        <% } %>
                        <tr class="total general">
                            <td align="left">TAUX</td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right"><%=Utilitaire.formaterAr(etatCA.getPourcAvoir())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(etatCA.getPourComptant())%></td>
                            <td align="right"><%=Utilitaire.formaterAr(etatCA.getPourcCredit())%></td>
                            <td align="right"></td>
                            <td align="right"></td>
                            <td align="right"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="box-footer">
                <a class="btn btn-default" href="${pageContext.request.contextPath}/Paie?action=impressionCA" style="float:right">Imprimer</a>
            </div>
        </div>
    </section>
</div>
<%} catch (Exception ex) {
        ex.printStackTrace();
    }%>