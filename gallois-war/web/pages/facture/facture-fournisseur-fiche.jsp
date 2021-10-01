<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="facturefournisseur.Detailsffbonlivraison"%>
<%@page import="facturefournisseur.EtatFactureData"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {

        EtatFactureMontantDaty a = new EtatFactureMontantDaty();
        a.setNomTable("ETATFACTUREMONTANTDATYETATLIB");
        PageConsulte pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        a = (EtatFactureMontantDaty) pc.getBase();

//        pc.getChampByName("etat").setDefaut(a.getEtatText());
        pc.getChampByName("montantTTDevise").setVisible(false);
        pc.getChampByName("numid").setLibelle("Numéro compta");
        pc.getChampByName("montantPaye").setLibelle("Montant payé");
        pc.getChampByName("id").setLibelle("ID");
        pc.getChampByName("reste").setLibelle("Reste à payer");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("idfournisseur").setLibelle("ID Fournisseur");
        pc.getChampByName("nomfournisseur").setLibelle("Fournisseur");
        pc.getChampByName("budget").setVisible(false);
        pc.getChampByName("retenue").setVisible(false);
        pc.getChampByName("remarque").setLibelle("Référence");
        pc.getChampByName("numfact").setLibelle("Numéro Facture");
        pc.getChampByName("designation").setLibelle("Désignation");
        pc.getChampByName("iddevise").setLibelle("Devise");
        pc.getChampByName("montantttc").setLibelle("Montant TTC");
        pc.getChampByName("dateemission").setLibelle("Date émission");
        pc.getChampByName("datyecheance").setLibelle("Date echéance");
        pc.getChampByName("etatlib").setLibelle("Etat");
        pc.getChampByName("etat").setVisible(false);
        pc.getChampByName("montanttva").setLibelle("Montant TVA");
        pc.getChampByName("montantAvoir").setLibelle("Montant Avoir");
        pc.getChampByName("montantAdditif").setLibelle("Montant Additif");
        pc.getChampByName("montant").setLibelle("Montant HT");
        pc.getChampByName("code_etablissement").setLibelle("Code direction");
        pc.getChampByName("projet").setLibelle("Projet");
        pc.getChampByName("numid").setLibelle("Numero compta");
        pc.getChampByName("montantTotalApayer").setVisible(false);

        pc.getChampByName("nomfournisseur").setLien("module.jsp?but=travaux/tiers-fiche.jsp&id=" + a.getIdFournisseur(), "nom=");
        pc.getChampByName("entite").setVisible(false);
        pc.getChampByName("idtva").setVisible(false);
        pc.getChampByName("idfournisseur").setVisible(false);
        pc.getChampByName("type").setVisible(false);

        EtatFactureMontantDaty ff = (EtatFactureMontantDaty) pc.getBase();

        pc.setTitre("Consultation Facture Fournisseur");

        String designationOP = "Payement facture num " + ff.getId() + " " + Utilitaire.remplacerNull(ff.getNumFact()) + " de " + ff.getIdFournisseur();
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "ff";
        EtatFactureData data = new EtatFactureData(ff);
        a = (EtatFactureMontantDaty) pc.getBase();

        String id = a.getId();

        pc.setTitre("Fiche Facture Fournisseur");

        EtatFactureMontantDaty base = (EtatFactureMontantDaty) pc.getBase();
        /*Onglets*/
        String tab = null;
        Map<String, String> map = new HashMap<String, String>();
        map.put("avoirFF-liste", "");
        map.put("additif-liste", "");
        map.put("bon-provisoire-liste", "");
        tab = request.getParameter("tab");
        if (tab == null) {
            tab = "additif-liste";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";

        String blStart = "BL", ccStart = "CC";
        String lien = "";
        if (a != null && a.getRemarque() != null) {
            if (a.getRemarque().startsWith(blStart)) {
                lien = "stock/bl/bondelivraison-fiche.jsp";
            } else if (a.getRemarque().startsWith(ccStart)) {
                lien = "travaux/contrat-fiche.jsp";
            }
        }
        pc.getChampByName("remarque").setLien((String) session.getValue("lien") + "?but=" + lien, "id=");

%>
<style>
    .col-md-center .box-fiche{
        min-width:100%;
    }

    #div-password {
        position: fixed;
        z-index: 10;
        background-color: #f1f1f1;
        border: 1px solid #d3d3d3;
        text-align: center;
        top: 150px;
        left: 50vw;
        width: 300px;
        height: 180px;
        display: none;
        box-shadow: 3px 6px 47px 3px rgb(0 0 0);
    }

    #div-password-header {
        padding: 10px;
        cursor: move;
        z-index: 10;
        background-color: #2196F3;
        color: #fff;
    }
    .skin-blue .wrapper, .skin-blue .main-sidebar, .skin-blue .left-side {
        background-color: #ecf0f5;
    }
    .main-footer{
        margin-left: 0px;
    }
</style>
<script>
    function annulation() {
        document.getElementById("mdp").value = "";
        var elmnt = document.getElementById("div-password");
        elmnt.style.display = "none";
    }

    function envoyer() {
        document.getElementById("form-avoir-interne").submit();
    }

    function avoirInterne() {
        document.getElementById("mdp").value = "";
        var elmnt = document.getElementById("div-password");
        elmnt.style.display = "block";
    }
</script>
<div class="content-wrapper">
    <form action="<%=(String) session.getValue("lien")%>?but=apresMdp.jsp" method="post" id="form-avoir-interne">
        <div id="div-password">
            <div id="div-password-header">Sécurité</div>
            <br/>
            <p><b>Mot de passe</b></p>
            <p><input name="mdp" type="password" id="mdp"></p>
            <p><button type="button" name="annuler" onclick="annulation()" class="btn btn-danger pull-left" style="margin-left: 25px;margin-top: 10px;">Annuler</button></p>
            <p><button type="button" name="ok" onclick="envoyer()" class="btn btn-info pull-right" style="margin-right: 25px;margin-top: 10px;">OK</button></p>
            <br/>
            <input type="hidden" name="bute" value="avoir/avoirFC-saisie.jsp&idfacture=<%=ff.getId()%>&type=1">
        </div>
    </form>
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box" id="fiche">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/facture-fournisseur-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%   out.println(pc.getHtml());%>
                </div>
                <div class="box-footer">
                    <h4><i class="fa fa-edit"></i> Modification fiche</h4>
                    <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=facture/facture-fournisseur-fiche.jsp&id=" + id%>" style="margin-right: 10px">Attacher Fichier</a>
                    <%if (request.getParameter("idbon") != null && request.getParameter("idbon").compareTo("") != 0) {%>
                    <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=facturefournisseur.FactureFournisseur&bute=facture/facture-fournisseur-fiche.jsp&id=" + id + "&idbon=" + request.getParameter("idbon")%>"  style="margin-right: 10px">Viser</a>
                    <%} else {%>
                    <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=facturefournisseur.FactureFournisseur&bute=facture/facture-fournisseur-fiche.jsp&id=" + id%>"  style="margin-right: 10px">Viser</a>
                    <%}%>

                    <a class="btn btn-danger"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&classe=facturefournisseur.FactureFournisseur&bute=facture/facture-fournisseur-fiche.jsp&id=" + id%>" style="margin-right: 10px">Annuler Visa</a>

                    <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-modif-multiple.jsp&id=" + id%>" style="margin-right: 10px">Modifier</a>

                    <%if (request.getParameter("idbon") != null && request.getParameter("idbon").compareTo("") != 0) {%>
                    <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=facture/regularisation.jsp&idfacture=" + id + "&idbon=" + request.getParameter("idbon")%>" style="margin-right: 10px">Régulariser bon</a>
                    <%} else {%>
                    <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=facture/regularisation.jsp&idfacture=" + id%>" style="margin-right: 10px">Régulariser bon</a>
                    <%}%>

                    <hr>
                    <h4><i class="fa fa-plus"></i> Actions </h4>
                    <a style="margin-right : 5px" class="btn btn-success "  href="<%=(String) session.getValue("lien") + "?but=apresFacture.jsp&acte=payer&id=" + a.getId()%>">Payer</a>
                    <a class="btn"  href="<%=(String) session.getValue("lien") + "?but=avoir/avoirFF-saisie.jsp&idfacture=" + ff.getId()%>&type=2" style="margin-right: 10px; background-color: #947a31!important; color: white!important;">Avoir</a>
                </div>

            </div>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title">D&eacute;tails facture fournisseur</h1>
                </div>
                <div class="box-body table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Id</th>
                                <th>Produit</th>
                                <th>Compte</th>
                                <th>Quantit&eacute;</th>
                                <th>P.U</th>
                                <th>Montant HT</th>
                                <th>TVA</th>
                                <th>Montant TVA</th>
                                <th>Montant TTC</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                Detailsffbonlivraison[] liste = data.getListeFactureBonLivraison();
                                double totalMontant = AdminGen.calculSommeDouble(liste, "montant");
                                double totalMontanttva = AdminGen.calculSommeDouble(liste, "montanttva");
                                double totalMontantttc = AdminGen.calculSommeDouble(liste, "montantttc");
                                for (int i = 0; i < liste.length; i++) {%>
                            <tr  onmouseout="this.style.backgroundColor = ''">
                                <td  align="center"><%=liste[i].getId()%></td>
                                <td  align="center"><%=liste[i].getIdingredient()%></td>
                                <td  align="center"><%=Utilitaire.champNull(liste[i].getCompte())%></td>
                                <td  align="center"><%=Utilitaire.formaterAr(liste[i].getQte())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(liste[i].getPu())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr((liste[i].getMontant()))%></td>
                                <td  align="right"><%=Utilitaire.formaterAr((liste[i].getTva()))%></td>
                                <td  align="right"><%=Utilitaire.formaterAr((liste[i].getMontanttva()))%></td>
                                <td  align="right"><%=Utilitaire.formaterAr((liste[i].getMontantttc()))%></td>

                            </tr>
                            <% }%>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="6"></td>
                                <th align="right">Montant HT</th>
                                <td align="right"><%=Utilitaire.formaterAr(totalMontant)%></td>

                            </tr>
                            <tr>
                                <td colspan="6"></td>
                                <th align="right">Montant TVA</th>
                                <td align="right"><%=Utilitaire.formaterAr(totalMontanttva)%></td>

                            </tr>
                            <tr>
                                <td colspan="6"></td>
                                <th align="right">Montant TTC</th>
                                <td align="right"><%=Utilitaire.formaterAr(totalMontantttc)%></td>

                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title">Liste paiement</h1>
                </div>
                <div class="box-body table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Id</th>
                                <th>Ded Id</th>
                                <th>Date</th>
                                <th>Montant</th>
                                <th>Etat</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                OrdonnerPayement[] payment = data.getOrdonner();
                                double paymentTotal = AdminGen.calculSommeDouble(payment, "montant"); %>
                            <%if (payment == null || payment.length == 0) {%>
                            <tr>
                                <td colspan="5" style="text-align: center;"><strong>Aucun fichier</strong></td>
                            </tr>
                            <%} else {
                                for (int i = 0; i < payment.length; i++) {%>
                            <tr  onmouseout="this.style.backgroundColor = ''">
                                <td  align="center"><a href="<%=(String) session.getValue("lien") + "?but=ded/ordonnerpayement-fiche.jsp&id=" + payment[i].getId()%>"><%=payment[i].getId()%></a></td>
                                <td  align="center"><%=Utilitaire.champNull(payment[i].getDed_Id())%></td>
                                <td  align="center"><%=Utilitaire.formatterDaty(payment[i].getDaty())%></td>
                                <td  align="right"><%=Utilitaire.formaterAr(payment[i].getMontant())%></td>
                                <td  align="right"><%=ConstanteEtat.etatToChaine("" + payment[i].getEtat())%></td>
                            </tr>
                            <% }
                                }%>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3"></td>
                                <th align="right">Payement Total</th>
                                <td align="right"><%=Utilitaire.formaterAr(paymentTotal)%></td>

                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">                            
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%= map.get("avoirFF-liste")%>"><a href="globalnegoce.jsp?but=facture/facture-fournisseur-fiche.jsp&id=<%=request.getParameter("id")%>&tab=avoirFF-liste">Avoir</a></li>
                    <li class="<%= map.get("additif-liste")%>"><a href="globalnegoce.jsp?but=facture/facture-fournisseur-fiche.jsp&id=<%=request.getParameter("id")%>&tab=additif-liste&idfacture=<%=request.getParameter("id")%>">Additif</a></li>
                    <li class="<%= map.get("bon-provisoire-liste")%>"><a href="globalnegoce.jsp?but=facture/facture-fournisseur-fiche.jsp&id=<%=request.getParameter("id")%>&tab=bon-provisoire-liste&idfacture=<%=request.getParameter("id")%>">Liste Bon provisoire</a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%=tab%>">
                        <jsp:param name="idfacture" value="<%=base.getId()%>" />
                    </jsp:include>
                </div>
            </div>
        </div>   
    </div>            
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="">
                <h2 class="box-title" style="margin-left: 10px;">Les fichiers attachés</h2>
            </div>
            <div class="box-body">
                <table class="table table-striped table-bordered table-condensed table-responsive tree">
                    <thead>
                        <tr>
                            <th style="background-color:#bed1dd;"></th>
                            <th style="background-color:#bed1dd;">Libellé</th>
                            <th style="background-color:#bed1dd;">Fichier</th>
                            <th style="background-color:#bed1dd;">Voir</th>
                            <th style="background-color:#bed1dd;">#</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%if (fichiers == null || fichiers.length == 0) {%>
                        <tr>
                            <td colspan="5" style="text-align: center;"><strong>Aucun fichier</strong></td>
                        </tr>
                        <%} else {
                            for (AttacherFichier fichier : fichiers) {%> 
                        <tr class="treegrid-1 treegrid-expanded">
                            <td><span class="treegrid-expander glyphicon glyphicon-minus"></span></td>
                            <td><%=fichier.getChemin()%></td>
                            <td><%=Utilitaire.champNull(fichier.getLibelle())%></td>
                            <td><a href="#" class="btn btn-primary" onclick="javascript:pagePopUp('<%=cdn + dossier + "/" + fichier.getChemin()%>')">Voir</a></td>
                            <td></td>
                        </tr>
                        <%}
                            }%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $('#fiche .row .col-md-6').removeClass('col-md-6').removeClass('col-md-center').addClass('col-md-8').addClass('col-md-offset-2');
</script>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>
