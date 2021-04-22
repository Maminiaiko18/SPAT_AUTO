<%-- 
    Document   : transfert-caisse-fiche.jsp
    Created on : 16 janv. 2021, 00:45:25
    Author     : nyamp
--%>


<%@page import="mg.spat.Caisse"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.MvttIntraCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String id = request.getParameter("id");
    MvttIntraCaisse jc = new MvttIntraCaisse();
    jc.setNomTable("mvtintracaisse_lib");
    PageConsulte pc = new PageConsulte(jc, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
//    pc.setTitre("Fiche Journal Caisse");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("caissedepart").setLibelle("Caisse départ");
    pc.getChampByName("caissearrivee").setLibelle("Caisse arrivée");
    pc.getChampByName("modepaiement").setLibelle("Mode de paiement");
    jc = (MvttIntraCaisse)pc.getBase();
    id=jc.getId();
    AttacherFichier[] fichiers = UploadService.getUploadFile(id);
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier = "mvttIntraCaisse";
    
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien") + "?but=treso/transfert-caisse-liste.jsp"%>"><i class="fa fa-arrow-circle-left"></i></a> Fiche mouvement intra caisse </h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="pull-right">
                        <p>
                            <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=valider&bute=treso/transfert-caisse-fiche.jsp&classe=mg.spat.MvttIntraCaisse">Viser</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=treso/transfert-caisse-modif.jsp&id=" + id%>"><button class="btn btn-warning ">Modifier</button></a>
                            <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/transfert-caisse-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>
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
        
                            

