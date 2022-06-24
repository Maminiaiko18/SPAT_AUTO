<%-- 
    Document   : factureclient-fiche-vaovao
    Created on : 12 mai 2021, 13:56:24
    Author     : nyamp
--%>

<%@page import="data.FactureFData"%>
<%@page import="data.FactureData"%>
<%@page import="utilitaire.Constante"%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import=" facture.FactureFournisseur"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="facture.EtatProvision"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Constante"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        UserEJB u = (user.UserEJB) session.getValue("u");
        FactureFournisseur e = new FactureFournisseur();
        e.setNomTable("factfourn_msum_lib_fiche");
        PageConsulte pc = new PageConsulte(e, request, u);
        pc.setTitre("FICHE FACTURE FOURNISSEUR");

        //pc.getChampByName("iduser").setVisible(false);
        //pc.getChampByName("type").setVisible(false);
//        pc.getChampByName("tiers").setVisible(false);
//        pc.getChampByName("etatlib").setVisible(false);
        pc.getChampByName("Idcategorie").setVisible(false);
        pc.getChampByName("IdProvision").setVisible(true);
        //pc.getChampByName("projet").setVisible(false);
//        pc.getChampByName("idProvisionlib").setVisible(false);
//        pc.getChampByName("montanttva").setVisible(false);
      //  pc.getChampByName("estMictsl").setVisible(false);
//        pc.getChampByName("estDDPMICTSL").setVisible(false);
//        pc.getChampByName("escale").setVisible(false);
//        pc.getChampByName("idprevision").setVisible(false);
        pc.getChampByName("idProvision").setVisible(false);
//        pc.getChampByName("nature").setVisible(false);
//        pc.getChampByName("code_etablissement").setVisible(false);
        pc.getChampByName("tierslib").setLibelle("Tiers");
        //pc.getChampByName("naturelib").setLibelle("Nature");
//        pc.getChampByName("numeroop").setLibelle("N° facture");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("montantHTSansRemise").setLibelle("Montant HT Sans Remise");

        pc.getChampByName("montant").setLibelle("Montant HT");
        pc.getChampByName("montanttva").setLibelle("Montant TVA");
        pc.getChampByName("montantavoir").setLibelle("Montant Avoir");
//        pc.getChampByName("montantttcvrai").setLibelle("Montant TTC");
        pc.getChampByName("montantttc").setLibelle("Net à payer");
        pc.getChampByName("date_echeance").setLibelle("Date echeance");
        pc.getChampByName("montantpaye").setLibelle("Montant payé");
        pc.getChampByName("montantreste").setLibelle("Reste à payer");
        pc.getChampByName("typelib").setLibelle("Type");
       pc.getChampByName("idProvisionlib").setLibelle("Bon Provisoire");
        pc.getChampByName("projetlib").setLibelle("Projet");
        pc.getChampByName("idEngagementlib").setLibelle("Engagement");
        pc.getChampByName("dateRegul").setLibelle("Date de régul");
//        pc.getChampByName("numeroop").setVisible(false);
        pc.getChampByName("code_etablissementlib").setLibelle("Code direction");
        //pc.getChampByName("escale").setLibelle("Escale");
        //pc.getChampByName("codeProvision").setLibelle("Provision");
        pc.getChampByName("exercice").setLibelle("Exercice");
        pc.getChampByName("numeroop").setLibelle("N° facture");

        String[] attribus = {"iduser","type","tiers","etatlib","Idcategorie","IdProvision","projet","estMictsl","estDDPMICTSL","escale","idprevision","idProvision","nature","code_etablissement","tierslib","naturelib","numeroop","daty","montantHTSansRemise","montant","montanttva","montantavoir","montantttcvrai","montantttc","date_echeance","montantpaye","montantreste","typelib","idProvisionlib","dateRegul","code_etablissementlib","escale","codeProvision","exercice"};
       // pc.setOrdre(attribus);

        pc.getChampByName("code").setLibelle("Numero Compta");
        e = (FactureFournisseur) pc.getBase();
        pc.getChampByName("IdProvision").setLien((String) session.getValue("lien") + "?but=facture/facture-fournisseur-fiche-vaovao.jsp&id=" + e.getIdProvision(), "");
        String categorie = "";
        if (e.getIdcategorie() != null) {
            categorie = e.getIdcategorie();
        }
        if (categorie.equals(Constante.getCategorieFFBP())) {
            pc.setTitre("Fiche Bon provisoire");
        } else {
            pc.setTitre("Fiche Facture Fournisseur");
        } 
        pc.getChampByName("categorielib").setLibelle("Categorie");
        //pc.getChampByName("codePrestation").setVisible(false);
        //pc.getChampByName("codePrestationlib").setLibelle("Code Prestation");
        //pc.getChampByName("codePrestationlib").setVisible(false);
        //pc.getChampByName("deviseMere").setLibelle("Devise");

        pc.getChampByName("designation").setLibelle("Note explicative");
        //pc.getChampByName("idengagement").setVisible(false);

        //
//Si categorieFC = proforma alors “Fiche Facture Proforma”
//
//Si categorieFC = provision alors “Fiche Facture de provision”
//        pc.getChampByName("escale").setLien((String) session.getValue("lien") + "?but=capitainerie/quais/quais-prevision-fiche.jsp&id=" + e.getIdprevision(), "escale=");
        String bute = "facture/facture-fournisseur-fiche-vaovao.jsp";
        String classe = "facture.FactureFournisseur";
        String classefille = "facture.FactureFournisseurDetails";
        String modifPage = "facture/facture-fournisseur-modif-vaovao.jsp";

        String lien = (String) session.getValue("lien");
        String redirect = lien + "?but=" + modifPage + "&id=" + request.getParameter("id");
        //if(e.getEtat() < ConstanteEtat.getEtatValider()) out.println("<script language='JavaScript'> document.location.replace('"+redirect+"'); </script>");

        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "facture";
        String id = e.getId();

        Map<String, String> map = new HashMap<String, String>();
        map.put("facture-fournisseur-fille", "");
        map.put("avoirFF-liste", "");
        map.put("bondelivraisonFF", "");
        map.put("paiementFF", "");
        map.put("regularisationFF", "");
//        map.put("activite", "");
//        map.put("facturesdefinitives", "");
//        map.put("provision-facturesdefinitives", "");
//        map.put("regularisation", "");
        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "facture-fournisseur-fille";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";

        //String vue = e.getId().startsWith(Constante.fcPrefix) ? "ANALYSEGLOBALEFACTURE_VAOVAO" : "ANALYSEGLOBALEANTSIKA";
       // String vue = e.getRemarque() != null && e.getRemarque().startsWith("--") ? "ANALYSEGLOBALEFACTURE_VAOVAO" : "ANALYSEGLOBALEANTSIKA";
%>

<style type="text/css">
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
            <input type="hidden" name="bute" value="avoir/avoirFC-saisie.jsp&idfacture=<%=e.getId()%>&type=1">
        </div>
    </form>
    <div class="row">
        <div class="col-md-7 col-md-offset-2">

            <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> <%=pc.getTitre()%> 
                </h1>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                </div>
                <div class="box-footer">
                    <p>
                        <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id")%>&bute=facture/facture-fournisseur-fiche-vaovao.jsp&classe=facture.FactureFournisseur" style="margin-right: 10px">Viser</a>
                        <a class="btn btn-danger"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&id=" + request.getParameter("id")%>&bute=facture/facture-fournisseur-fiche-vaovao.jsp&classe=facture.FactureFournisseur" style="margin-right: 10px">Annuler Visa</a>
                        <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId()%>&acte=dupliquer&bute=<%=bute%>&classe=<%=classe%>&nomClasseFille=<%=classefille%>&nomColonneMere=idmere" style="margin-right: 10px">Dupliquer</a>
                        <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=facture/recurrentFF.jsp&id=" + e.getId()%>" style="margin-right: 10px">Récurrent</a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/depense-saisie.jsp&idFacture=" + id+"&mode=1"%>" style="margin-right: 10px">Sortie banque</a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/depense-saisie.jsp&idFacture=" + id+"&mode=2"%>" style="margin-right: 10px">Sortie caisse</a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/ordonnervaliderpayement-saisie.jsp&ded_id=" + id%>" style="margin-right: 10px">Editer OP</a>
                    <hr>
                    
                    <p>

                        <a class="btn"  href="<%=(String) session.getValue("lien") + "?but=avoir/avoirFF-saisie.jsp&idfacture=" + e.getId()%>&type=2" style="margin-right: 10px; background-color: #947a31!important; color: white!important;">Avoir</a>
                    </p>
                    <hr>
                    <p>
                        <a class="btn btn-default"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + e.getId() + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=" + bute + "&id=" + e.getId()%>" style="margin-right: 10px">Attacher Fichier</a>
                    </p>
                    <hr>
                    <p>
                        <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerFactureFournisseur&id=<%=id%>" style="margin-right: 10px">Imprimer</a>
                    </p>
                    </hr>
                    <p>
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but=" + modifPage + "&id=" + e.getId()%>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-modif-simple.jsp&id=" + e.getId()%>" style="margin-right: 10px">Modifier entête </a>
                    </p>
                    <hr>
                    <%
                        if (e.getIdcategorie() != null && e.getIdcategorie().equals(Constante.getCategorieFFBP())) {%>
                    <p>
                        <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=apresFacture.jsp&id=" + e.getId()%>&acte=genererDefinitiveFF&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Générer facture définitive</a>
                        <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=facture/regul-ff-provision.jsp&idProvision=" + e.getId()%>" style="margin-right: 10px">Regulariser</a>
                    </p><hr>
                    <%}
                    %>
                    <%
                        if (e.getIdcategorie() != null && e.getIdcategorie().equals(Constante.idCategorieFCDefinitive)) {%>
                    <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresFacture.jsp&id=" + e.getId()%>&acte=genererProvision&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Générer Provision</a>

                    <%}
                    %>

                    <hr>
                </div>
            </div>
        </div>
    </div>

    <!-- Trop perçu -->     
    <% if (e.getIdcategorie() != null && e.getIdcategorie().equals(Constante.getCategorieFFBP())) { 
        //double montant = 0;
        //if(etatProv.getMontantreste() < 0) montant = -etatProv.getMontantreste();
        FactureFData factData = new FactureFData();
        factData.initData(e.getId());
    %>
    <div class="row">
        <div class="col-md-7 col-md-offset-2">

            <div class="box">
                <div class="box-body">
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td align="left"><b><%= factData.getLib() %></b></td>
                                <td align="right"><%=Utilitaire.formaterAr(factData.getMontantTP())%></td>
                                <td align="center"><a class="btn btn-primary" href="<%=(String) session.getValue("lien")%>?but=avoir/avoirFF-saisie.jsp&idfacture=<%=e.getId()%>&type=2" <%=factData.isDisabled() ? "disabled" : ""%>>Rembourser</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%}%>
    <!--    detail      -->


    <div class="row">
        <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("facture-fournisseur-fille")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=facture-fournisseur-fille&idmere=<%=e.getId()%>">D&eacute;tails facture client</a></li>
                    <li class="<%= map.get("avoirFF-liste")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&idfacture=<%=e.getId()%>&tab=avoirFF-liste">Facture avoir</a></li>
                    
                    <li class="<%= map.get("paiementFF")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&idfact=<%=e.getId()%>&tab=paiementFF">Paiement</a></li>
                    <% if (e.getIdcategorie().equals(Constante.getCategorieFFBP())) {%>
                    <li class="<%= map.get("facturesfdefinitives")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=facturesfdefinitives">Factures d&eacute;finitives</a></li>
                    <li class="<%= map.get("regularisationFF")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=regularisationFF&idProvision=<%=e.getId()%>">Régularisation</a></li>
                    <% } %>
                </ul>
                <div class="tab-content">       

                    <div class="tab-content">       
                        <jsp:include page="<%=tab%>" >
                            <jsp:param name="idmere" value="<%=e.getId()%>" />
                            <jsp:param name="idbc" value="<%=e.getId()%>" />
                            <jsp:param name="idplacement" value="<%=e.getId()%>" />
                            <jsp:param name="idfacture" value="<%=e.getId()%>" />
                            <jsp:param name="idProvision" value="<%=e.getId()%>" />
                            <jsp:param name="iddefinitive" value="<%=e.getId()%>" />
                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>  

        <!--    fin detail      -->
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="box-title with-border">
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
                                <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
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
    <%
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> alert('<%=e.getMessage()%>');
        history.back();</script>
        <% }%>

