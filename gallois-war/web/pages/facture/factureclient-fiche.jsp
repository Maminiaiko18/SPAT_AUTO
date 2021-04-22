<%-- 
    Document   : factureclient-fiche.jsp
    Created on : 14 janv. 2021, 15:37:16
    Author     : nyamp
--%>
<%@page import="mg.spat.FactureAnalyse"%>
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
    FactureAnalyse facture = new FactureAnalyse();
    facture.setNomTable("ANALYSEGLOBALEFACTURE_ANALYSE");
    PageConsulte pc = new PageConsulte(facture, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche facture client");
//    pc.getChampByName("dateSaisie").setVisible(false);
    pc.getChampByName("nmfact").setLibelle("Id");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("categorie_facture").setLibelle("Catégorie facture");
    pc.getChampByName("sous_categorie_facture").setLibelle("Sous catégorie facture");
    pc.getChampByName("categorie_client").setLibelle("Catégorie client");
    pc.getChampByName("mttc").setLibelle("Montant TTC");
    pc.getChampByName("mtht").setLibelle("Montant HT");
    pc.getChampByName("devfact").setLibelle("Devise");
    pc.getChampByName("mtdevise").setLibelle("Motant devise");
    pc.getChampByName("mtavoir").setLibelle("Motant avoir");
    pc.getChampByName("numCompte").setLibelle("Numero compte");
    pc.getChampByName("valCat").setLibelle("catégorie");
//    pc.getChampByName("idplacement").setLien((String) session.getValue("lien") + "?but=placement/placement-fiche.jsp", "id=");
    facture=(FactureAnalyse)pc.getBase();
    id=facture.getNmFact();
    id=facture.getNmFact();
    AttacherFichier[] fichiers = UploadService.getUploadFile(id);
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier = "factureclient";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/journalcaisse-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a>Fiche facture client</h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="pull-right">
                        <p>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/recette-saisie.jsp&idFacture="+id%>" style="margin-right: 10px">Entrée banque</a>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/journalcaisse-saisie.jsp&idFacture="+id %>" style="margin-right: 10px">Entrée caisse</a>
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
        
         