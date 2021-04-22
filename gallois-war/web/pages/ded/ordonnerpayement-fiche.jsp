<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %> 
<%@ page import="affichage.*" %> 
<%
    try {
        OrdonnerPayement a = new OrdonnerPayement();
        a.setNomTable("OrdonnerPayement_LIB");
        PageConsulte pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        a = (OrdonnerPayement) pc.getBase();
        String id = a.getId();
        pc.getChampByName("idLigne").setVisible(false);

        pc.getChampByName("Ded_Id").setLibelle("Facture");
        pc.getChampByName("Ded_Id").setLien((String) session.getValue("lien") + "?but=facture/facture-fournisseur-fiche.jsp", "id=");
        pc.getChampByName("numeroop").setLibelle("Numero OP");
        pc.getChampByName("destination").setVisible(false);
        pc.getChampByName("modepaiement").setLibelle("Mode de paiement");
        pc.getChampByName("remarque").setLibelle("Motif de paiement");
        pc.getChampByName("numfact").setLibelle("Numero facture");
        pc.getChampByName("daty").setLibelle("Date");

//        pc.getChampByName("nomfournisseur").setLien("module.jsp?but=travaux/tiers-fiche.jsp&id=" + a.getIdFournisseur(), "nom=");
        pc.setTitre("Fiche Ordre de Payer");
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
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/facture-fournisseur-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%   out.println(pc.getHtml());%>
                </div>
                <div class="box-footer">
                    <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=ded/ordonnerpayement-fiche.jsp&id=" + id%>" style="margin-right: 10px">Attacher Fichier</a> 
                    <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=ded.OrdonnerPayement&bute=ded/ordonnerpayement-fiche.jsp&id=" + id%>"  style="margin-right: 10px">Viser</a>
                    <% if(a.getDed_Id().startsWith("FC")){%>
                    <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=treso/journalcaisse-saisie.jsp&id=" + id +"&entree=1" %>"  style="margin-right: 10px">Entre caisse</a>
                    <%} else{%>
                    <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=treso/journalcaisse-saisie.jsp&id=" + id%>"  style="margin-right: 10px">sortie caisse</a>
                    <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=treso/depense-saisie.jsp&id=" + a.getId()%>" style="margin-right: 10px">Sortie banque</a>
                    <%}%>

                    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=ordonnerpayement&id=<%=id%>" style="margin-right: 10px">Imprimer OP</a>

                    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerBed2&id=<%=id%>" style="margin-right: 10px">Editer BED</a>


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
        throw e;
    }%>
