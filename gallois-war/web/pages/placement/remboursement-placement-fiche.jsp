<%@page import="mg.spat.RemboursementPlacement"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %> 
<%@ page import="affichage.*" %> 
<%
    try {
        RemboursementPlacement rbpl = new RemboursementPlacement();
        rbpl.setNomTable("remboursementPlacementlib");
        PageConsulte pc = new PageConsulte(rbpl, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        rbpl = (RemboursementPlacement) pc.getBase();
        String id = rbpl.getId();

        pc.getChampByName("ID").setLibelle("Id");
        pc.getChampByName("idplacement").setLien((String) session.getValue("lien") + "?but=placement/placement-fiche.jsp", "id=");
        pc.getChampByName("montantPlace").setLibelle("MontantPlace");
        pc.getChampByName("caisse").setVisible(false);
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("banque").setLibelle("Banque");
        pc.getChampByName("entite").setLibelle("Entite");
        pc.getChampByName("interet").setLibelle("Interet");        
        pc.getChampByName("caisselib").setLibelle("Caisselib");        
        pc.getChampByName("etat").setLibelle("etat");



//        pc.getChampByName("nomfournisseur").setLien("module.jsp?but=travaux/tiers-fiche.jsp&id=" + a.getIdFournisseur(), "nom=");
        pc.setTitre("Fiche remboursement de placement");
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "op";

%>
<style>
    .col-md-center .box-fiche{
        min-width:100%;
    }
</style>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box" id="fiche">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=placement/placement-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%   out.println(pc.getHtml());%>
                </div>
                <div class="box-footer">
                    <div>
                        <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=ded.OrdonnerPayement&bute=ded/ordonnerpayement-fiche.jsp&id=" + id%>"  style="margin-right: 10px">Viser</a>
                        <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=ded/ordonnerpayement-modif.jsp&id=" + id%>"  style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-success pull-left"  href="${pageContext.request.contextPath}/Paie?action=imprimerBed2&id=<%=id%>" style="margin-right: 10px">Editer BED</a>
                    </div>
                  
                    <div>
                        <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=ded/ordonnerpayement-fiche.jsp&id=" + id%>" style="margin-right: 10px">Attacher Fichier</a> 
                    </div>
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
