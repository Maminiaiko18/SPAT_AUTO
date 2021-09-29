<%-- 
    Document   : factureclient-fiche.jsp
    Created on : 14 janv. 2021, 15:37:16
    Author     : nyamp
--%>
<%@page import="facture.RegulFCProvision"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String id = request.getParameter("nmfact");
    RegulFCProvision facture = new RegulFCProvision();
    facture.setNomTable("regulFCProvisionlib");
    PageConsulte pc = new PageConsulte(facture, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("FICHE REGULARISATION FACTURE");
//    pc.getChampByName("dateSaisie").setVisible(false);
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idProvisionCode").setLibelle("Code Provision");
    pc.getChampByName("idFactureCode").setLibelle("Code Facture");
    pc.getChampByName("etatlib").setLibelle("Etat");
    pc.getChampByName("etat").setVisible(false);
    pc.getChampByName("idProvision").setVisible(false);
    pc.getChampByName("idFacture").setVisible(false);
//    pc.getChampByName("idplacement").setLien((String) session.getValue("lien") + "?but=placement/placement-fiche.jsp", "id=");
    facture=(RegulFCProvision)pc.getBase();
    id=facture.getId();
    String idProvision = facture.getIdProvision();
    String idFacture = facture.getIdFacture();
    AttacherFichier[] fichiers = UploadService.getUploadFile(id);
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier = "regularisation";
    pc.getChampByName("idProvisionCode").setLien((String) session.getValue("lien") + "?but=facture/factureclient-fiche-vaovao.jsp&id="+idProvision, "code=");
    pc.getChampByName("idFactureCode").setLien((String) session.getValue("lien") + "?but=facture/factureclient-fiche-vaovao.jsp&id="+idFacture, "code=");

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/journalcaisse-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a>FICHE REGULARISATION FACTURE</h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="pull-right">
                        <p>
                            <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=facture.RegulFCProvision&bute=facture/regul-fc-fiche.jsp&id=" + id%>"  style="margin-right: 10px">Viser</a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/journalcaisse-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>
                        </p>
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
                              
</div> 
        
         