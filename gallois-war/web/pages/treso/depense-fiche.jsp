

<%@page import="mg.spat.Caisse"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String id = request.getParameter("id");
    JournalCaisseLibComplet jc = new JournalCaisseLibComplet();
    PageConsulte pc = new PageConsulte(jc, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche Journal Caisse");

    pc.getChampByName("idcaisse").setVisible(false);
    pc.getChampByName("caisse").setVisible(false);
    pc.getChampByName("valcaisse").setLibelle("caisse");
    pc.getChampByName("descecaisse").setVisible(false);
    pc.getChampByName("valtypecheque").setVisible(false);
    pc.getChampByName("descetypecheque").setVisible(false);
    pc.getChampByName("dateSaisie").setVisible(false);
    pc.getChampByName("dateEffet").setLibelle("Date");
    pc.getChampByName("numPiece").setVisible(false);
    pc.getChampByName("idmode").setVisible(false);
    pc.getChampByName("typemvt").setVisible(false);
    pc.getChampByName("idTypeCheque").setVisible(false);
    pc.getChampByName("iddevise").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("designation").setVisible(false);
    pc.getChampByName("numcheque").setLibelle("Numero chèque");
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("idplacement").setLibelle("Placement");
    pc.getChampByName("credit").setLibelle("Entrée");
    pc.getChampByName("debit").setLibelle("Sortie");

    JournalCaisseLibComplet jcaisse = (JournalCaisseLibComplet) pc.getBase();
//    pc.getChampByName("idplacement").setLien((String) session.getValue("lien") + "?but=placement/placement-fiche.jsp", "id=");
    pc.getChampByName("idordre").setLibelle("Ordre");
    pc.getChampByName("idordre").setLien((String) session.getValue("lien") + "?but=ded/ordonnerpayement-fiche.jsp", "id=");

    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier = "journal";
    //Caisse[] caisse = (Caisse[])CGenUtil.rechercher(new Caisse(), null, null,null, " and val like '"+jcaisse.idcaisse()+"'");


%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/depense-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche dépense</h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="pull-right">
                        <p>
                            <%if (jcaisse.getEtat() != ConstanteEtat.getEtatValider()) {%>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id%>&acte=valider&bute=treso/depense-fiche.jsp&classe=mg.spat.JournalCaisse">Viser</a>
                            <%}%>
                            <a href="<%=(String) session.getValue("lien") + "?but=treso/depense-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=treso/depense-liste.jsp&classe=mg.spat.JournalCaisse" style="margin-right: 5px"><button class="btn btn-danger" >Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/depense-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/cloture-saisie.jsp&caisse=" + jcaisse.getIdcaisse()%>" style="margin-right: 10px">cloturer</a> 
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

