<%-- 
    Document   : bon-provisoire
    Created on : 30 nov. 2019, 14:55:20
    Author     : Tin
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.BonProvisoireComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    FactureFournisseur bp = new FactureFournisseur();
    bp.setNomTable("FACTFOURN_MSUM_LIB");
    PageConsulte pc = new PageConsulte(bp, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche Bon Provisoire");
    pc.getChampByName("id").setVisible(false);

    pc.getChampByName("tierslib").setLibelle("Bénéficiaire");
    pc.getChampByName("code").setLibelle("Numero pièce");
    pc.getChampByName("montantttc").setLibelle("Montant TTC");
    pc.getChampByName("etatlib").setLibelle("Etat");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("type").setVisible(false);
    pc.getChampByName("tva").setVisible(false);
    pc.getChampByName("date_echeance").setVisible(false);
    pc.getChampByName("idprevision").setVisible(false);
    pc.getChampByName("montant").setVisible(false);
    pc.getChampByName("montanttva").setVisible(false);
    pc.getChampByName("montantpaye").setVisible(false);
    pc.getChampByName("montantreste").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("contact").setVisible(false);
    pc.getChampByName("adresse").setVisible(false);
    pc.getChampByName("escale").setVisible(false);
    pc.getChampByName("typelib").setVisible(false);
    pc.getChampByName("idcategorie").setVisible(false);
    pc.getChampByName("categorielib").setVisible(false);
    pc.getChampByName("idProvision").setVisible(false);
    pc.getChampByName("idProvisionlib").setVisible(false);
    pc.getChampByName("estDDPMICTSL").setVisible(false);
    pc.getChampByName("deviseMere").setVisible(false);
    pc.getChampByName("codePrestation").setVisible(false);
    pc.getChampByName("codePrestationlib").setVisible(false);
    pc.getChampByName("estMictsl").setVisible(false);
    pc.getChampByName("codeProvision").setVisible(false);
    pc.getChampByName("iduser").setVisible(false);
    pc.getChampByName("montantavoir").setVisible(false);
    pc.getChampByName("etat").setVisible(false);
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="treso";
    bp = (FactureFournisseur) pc.getBase();
    String id = bp.getId();
//    BonProvisoireComplet bonprovisoireVise = (BonProvisoireComplet) pc.getBase();
//    BonProvisoireData data=new BonProvisoireData(bonprovisoireVise);
//    RegulBonProvisoire[] listeReg=data.getListeRegul();
//    RegulBonProvisoire[] listeRet=data.getListeRetour();
    
//    BonProvisoireComplet base = (BonProvisoireComplet) pc.getBase();
//
//    /*Onglets*/
//    String tab = null;
//    Map<String, String> map = new HashMap<String, String>();
//    map.put("facture-fournisseur-liste", "");
//    map.put("regularisation", "");
//
//    String id = request.getParameter("id");
//    tab = request.getParameter("tab");
//    if (tab == null) {
//        tab = "facture-fournisseur-liste";
//    }
//    map.put(tab, "active");
//    tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-modif-vaovao.jsp&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id%>&acte=valider&bute=treso/bon-provisoire-fiche-nouveau.jsp&classe=facture.FactureFournisseur" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/bon-provisoire-fiche-nouveau.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12">
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
                               <%if(fichiers==null || fichiers.length==0){%>
                               <tr>
                                    <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                                </tr>
                              <%} else{
                                    for(AttacherFichier fichier : fichiers){%> 
                                <tr class="treegrid-1 treegrid-expanded">
                                    <td><span class="treegrid-expander glyphicon glyphicon-minus"></span></td>
                                    <td><%=fichier.getChemin() %></td>
                                    <td><%=Utilitaire.champNull(fichier.getLibelle())%></td>
                                    <td><a href="#" class="btn btn-primary" onclick="javascript:pagePopUp('<%=cdn + dossier +"/"+ fichier.getChemin()%>')">Voir</a></td>
                                    <td></td>
                                </tr>
                                <%}}%>


                                </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
 <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
