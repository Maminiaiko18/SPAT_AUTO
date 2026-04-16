<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.EtatGrandCA"%>
<%@page import="utilitaire.Constante"%>
<%@page import="mg.spat.CA"%>
<%@page import="java.util.Map"%>
<%@page import="mg.spat.EtatCA"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%
    try {
        String lien = (String) session.getValue("lien");

        String datedebut = request.getParameter("datedebut");
        String datefin = request.getParameter("datefin");

        if (datedebut == null || datedebut.trim().isEmpty()) {
            datedebut = Utilitaire.dateDuJour();
        }
        if (datefin == null || datefin.trim().isEmpty()) {
            datefin = Utilitaire.dateDuJour();
        }

        String mois = "1";
        String annee = "2026";

        int moisAvant = Utilitaire.stringToInt(mois) - 1;
        int anneeInt = Utilitaire.stringToInt(annee);



//        Liste moisL = new Liste("mois");
//        moisL.makeListeMois();
//        moisL.setDefaut(mois);

//        String moisEnLettre = (String) moisL.getValeurBrute()[moisAvant];

        EtatGrandCA etatGrandCA = new EtatGrandCA(datedebut, datefin, false);
        HashMap<String, EtatCA> listeCA = etatGrandCA.getListeCA();
        CA totalgeneralgrandrubrique = etatGrandCA.getTotalgeneralgrandrubrique();
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
    .generalfinal {
        font-size: 20px;
    }
    #boxListCA {
        overflow-x: scroll!important;
    }
</style>
<script src="${pageContext.request.contextPath}/assets/js/html2pdf.bundle.min.js"></script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>CHIFFRE D'AFFAIRES SUR LES FACTURES EMISES DU <%= datedebut%> AU <%= datefin%>  </h1>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form action="<%=lien%>?but=ca/chiffreAffaire-entre2date.jsp" method="post" >
                    <div class="box box-solid collapsed">
                        <div style="background:#103a8e; color:white;" class="box-header with-border">
                            <h3 class="box-title" color="#103a8e"><span color="#103a8e">Recherche avanc�e</span></h3>
                            <div class="box-tools pull-right"><button data-original-title="Collapse" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="" tabindex="1"><i class="fa fa-plus"></i></button> </div>
                        </div>
                        <div class="box-body" id="pagerecherche">
                            <div class="form-group">
                                <div class="col-md-4">
                                    <label for="datedebut">Date debut</label>
                                    <input name="datedebut" type="date" class="form-control" id="datedebut" value="<%=datedebut%>" onkeydown="return searchKeyPress(event)" tabindex="3">
                                </div>
                                <div class="col-md-4">
                                    <label for="datefin">Date fin</label>
                                    <input name="datefin" type="date" class="form-control" id="datefin" value="<%=datefin%>" onkeydown="return searchKeyPress(event)" tabindex="3">
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="row"></div>
                            <div class="row">
                                <div class="col-xs-4" align="center">
                                    <button type="reset" class="btn btn-default" tabindex="33">R�initialiser</button>
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
            <div class="box list" id="boxListCA">
                <table class="table table-responsive table-hover tableca" width="100%">
                    <thead>
                    <tr>
                        <th rowspan="2">Libelle</th>
                        <th colspan="5">Mouvement du mois en cours</th>
                        <th rowspan="2">N. Cumule</th>
                        <th rowspan="2">Taux</th>
                    </tr>
                    <tr>
                        <th>Avoir Int</th>
                        <th>Avoir Ext</th>
                        <th>Comptant</th>
                        <th>Credit</th>
                        <th>Total</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Map.Entry<String, EtatCA> entry : listeCA.entrySet()) {
                            String cle = entry.getKey();
                            EtatCA etatCA = entry.getValue();
                            Map<String, CA[]> listeParRubrique = etatCA.getListeParRubrique();
                            Map<String, CA> sommePartiel = etatCA.getSommePartiel();
                            CA totalGeneral = etatCA.getTotalGeneral();
                    %>

                    <tr class="category total general">
                        <th colspan="14"><%=Utilitaire.champNull(cle)%></th>
                    </tr>

                    <%
                        if (listeParRubrique != null) {
                            for (String rubrique : listeParRubrique.keySet()) {%>
                    <tr class="category">
                        <th><%=Utilitaire.champNull(rubrique.toUpperCase())%></th>
                    </tr>
                    <% for (CA ca : listeParRubrique.get(rubrique)) {%>
                    <tr>
                        <td><%=Utilitaire.champNull(ca.getLibelle())%></td>
                        <td align="right">
                            <a href="<%= lien%>?but=avoir/avoirFC-Fille-liste.jsp&datedebut=<%=datedebut%>&datefin=<%=datefin%>&compte=<%=ca.getCompte()%>&recap=checked">
                                <%=Utilitaire.formaterAr(ca.getAvoirEETPINT())%>
                            </a>
                        </td>
                        <td align="right">
                            <a href="<%= lien%>?but=avoir/avoirFC-Fille-liste.jsp&datedebut=<%=datedebut%>&datefin=<%=datefin%>&compte=<%=ca.getCompte()%>&recap=checked">
                                <%=Utilitaire.formaterAr(ca.getAvoirEETPEXT())%>
                            </a>
                        </td>
                        <td align="right">
                            <a href="<%= lien%>?but=facture/facture-client-fille-listeSP.jsp&type=<%=Constante.typeAuComptant%>&datedebut=<%=datedebut%>&datefin=<%=datefin%>&compte=<%=ca.getCompte()%>&recap=checked">
                                <%=Utilitaire.formaterAr(ca.getComptant())%>
                            </a>
                        </td>
                        <td align="right">
                            <%
                                String moisBoucle = new String(mois);
                                String anneeBoucle = new String(annee);
                                if(ca.getCompte() != null && (ca.getCompte().compareTo(Constante.compteMICTSL1) == 0 || ca.getCompte().compareTo(Constante.compteMICTSL2) == 0 || ca.getCompte().compareTo(Constante.compteMICTSL3) == 0 )){
                                    if(Integer.parseInt(moisBoucle) == 12){
                                        moisBoucle = "1";
                                        anneeBoucle = String.valueOf(Integer.parseInt(anneeBoucle)+1);
                                    }
                                    else moisBoucle = String.valueOf((Integer.parseInt(moisBoucle))+1);
                                }
                            %>
                            <a href="<%= lien%>?but=facture/facture-client-fille-listeSP.jsp&type=<%=Constante.getTypeFCAcredit()%>&datedebut=<%=datedebut%>&datefin=<%=datefin%>&compte=<%=ca.getCompte()%>&recap=checked">
                                <%=Utilitaire.formaterAr(ca.getCredit())%>
                            </a>
                        </td>
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
                        <td align="right"><%=Utilitaire.formaterAr(partiel.getAvoirEETPINT())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(partiel.getAvoirEETPEXT())%></td>
                        <td align="right">
                            <!--<a href="<%= lien%>?but=facture/facture-client-fille-liste.jsp&type=<%=Constante.typeAuComptant%>&mois1=<%=moisAvant%>&mois2=<%=moisAvant%>&annee=<%=annee%>&recap=checked">-->
                            <%=Utilitaire.formaterAr(partiel.getComptant())%>
                            <!--</a>-->
                        </td>
                        <td align="right">
                            <!--<a href="<%= lien%>?but=facture/facture-client-fille-liste.jsp&type=<%=Constante.getTypeFCAcredit()%>&mois1=<%=moisAvant%>&mois2=<%=moisAvant%>&annee=<%=annee%>&recap=checked">-->
                            <%=Utilitaire.formaterAr(partiel.getCredit())%></td>
                        <!--</a>-->
                        <td align="right"><%=Utilitaire.formaterAr(partiel.getTotal())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(partiel.getNCumul())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(partiel.getTaux())%></td>
                    </tr>
                    <% }
                    } %>
                    <% if (totalGeneral != null) {%>
                    <tr class="category total general">
                        <td align="left"><%=Utilitaire.champNull(totalGeneral.getLibelle().toUpperCase())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getAvoirEETPINT())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getAvoirEETPEXT())%></td>
                        <td align="right">
                            <!--<a href="<%= lien%>?but=facture/facture-client-fille-liste.jsp&type=<%=Constante.typeAuComptant%>&mois1=<%=mois%>&mois2=<%=mois%>&annee=<%=annee%>&recap=checked">-->
                            <%=Utilitaire.formaterAr(totalGeneral.getComptant())%>
                            <!--</a>-->
                        </td>
                        <td align="right">
                            <!--<a href="<%= lien%>?but=facture/facture-client-fille-liste.jsp&type=<%=Constante.getTypeFCAcredit()%>&mois1=<%=mois%>&mois2=<%=mois%>&annee=<%=annee%>&recap=checked">-->
                            <%=Utilitaire.formaterAr(totalGeneral.getCredit())%>
                            <!--</a>-->
                        </td>
                        <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getTotal())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getNCumul())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(totalGeneral.getTaux())%></td>
                    </tr>
                    <% }
                    } %>
                    <tr class="category total generalfinal">
                        <td align="left">TOTAL GENERAL</td>
                        <td align="right"><%=Utilitaire.formaterAr(totalgeneralgrandrubrique.getAvoirEETPINT())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(totalgeneralgrandrubrique.getAvoirEETPEXT())%></td>

                        <td align="right">
                            <!--<a href="<%= lien%>?but=facture/facture-client-fille-liste.jsp&type=<%=Constante.typeAuComptant%>&mois1=<%=mois%>&mois2=<%=mois%>&annee=<%=annee%>&recap=checked">-->
                            <%=Utilitaire.formaterAr(totalgeneralgrandrubrique.getComptant())%>
                            <!--</a>-->
                        </td>
                        <td align="right">
                            <!--<a href="<%= lien%>?but=facture/facture-client-fille-liste.jsp&type=<%=Constante.getTypeFCAcredit()%>&mois1=<%=mois%>&mois2=<%=mois%>&annee=<%=annee%>&recap=checked">-->
                            <%=Utilitaire.formaterAr(totalgeneralgrandrubrique.getCredit())%>
                            <!--</a>-->
                        </td>
                        <td align="right"><%=Utilitaire.formaterAr(totalgeneralgrandrubrique.getTotal())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(totalgeneralgrandrubrique.getNCumul())%></td>
                        <td align="right"><%=Utilitaire.formaterAr(totalgeneralgrandrubrique.getTaux())%></td>
                    </tr>
                    <tr class="total general generalfinal">
                        <td align="left">Nombre de factures</td>
                        <td align="right"><%= Utilitaire.formaterAr(totalgeneralgrandrubrique.getNbComptant()) %></td>
                        <td align="right"><%= Utilitaire.formaterAr(totalgeneralgrandrubrique.getNbCredit()) %></td>
                        <td align="right"><%= Utilitaire.formaterAr(totalgeneralgrandrubrique.getNbFactureTotal()) %></td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                    <tr class="total general generalfinal">
                        <td align="left">TAUX</td>
                        <td align="right"><%=Utilitaire.formaterAr(etatGrandCA.getPourcAvoir())%>%</td>
                        <td align="right"><%=Utilitaire.formaterAr(etatGrandCA.getPourComptant())%>%</td>
                        <td align="right"><%=Utilitaire.formaterAr(etatGrandCA.getPourcCredit())%>%</td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="box-footer">   
                      <a class="btn btn-default" href="javascript:exporterPDF()" style="float:right">Imprimer</a>
                    <a class="btn btn-success" href="${pageContext.request.contextPath}/export/excel/ca?datedebut=<%=datedebut%>&datefin=<%=datefin%>" style="float:right; margin-right:10px;">
                        <i class="fa fa-file-excel-o"></i> Exporter Excel
                    </a>
            </div>
        </div>
    </section>
</div>

<script>
    function exporterPDF() {

        var element = document.getElementById('boxListCA');
        
        var opt = {
            margin:       [5, 8, 5, 8], // marges [haut, gauche, bas, droite] en mm
            filename:     'CA_<%=datedebut%>_au_<%=datefin%>.pdf',
            image:        { type: 'png', quality: 1 },
            html2canvas:  { 
                scale: 3, 
                useCORS: true,
                scrollY: 0,
                allowTaint: true,
                logging: false
            },
            jsPDF:        { unit: 'mm', format: 'a4', orientation: 'landscape' },
            pagebreak:    { mode: ['css', 'legacy'], before: '.page-break', avoid: ['tr', 'thead', 'tfoot'] }
        };

        var box = element.closest('.box');
        var wasCollapsed = box && box.classList.contains('collapsed-box');
        if(wasCollapsed) {
            var btn = box.querySelector('[data-widget="collapse"]');
            if(btn) btn.click();
        }


        html2pdf().set(opt).from(element).save().then(function() {
            if(wasCollapsed) {
                setTimeout(function() {
                    var btn = box.querySelector('[data-widget="collapse"]');
                    if(btn) btn.click();
                }, 500);
            }
        });
    }
</script>
<%
    } catch (Exception ex) {
        ex.printStackTrace();
    }%>