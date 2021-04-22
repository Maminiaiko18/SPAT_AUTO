<%-- 
    Document   : pourcentage-realisation-fiche
    Created on : 29 janv. 2020, 10:51:12
    Author     : john
--%>

<%@page import="mg.spat.travaux.PourcentageProjetComplet"%>
<%@page import="mg.spat.travaux.PourcentageProjet"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    //try {
        //PourcentageProjet c = new PourcentageProjet();
        PourcentageProjetComplet c = new PourcentageProjetComplet();
        c.setNomTable("POURCENTAGEPROJET_LIBCOMPLET");
//        c.setNomTable("pourcentageProjetLib");
        PageConsulte pc = new PageConsulte(c, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.setTitre("Fiche pourcentage");
        //pc.getChampByName("id").setVisible(false);
        
        c = (PourcentageProjetComplet) pc.getBase();
        
        pc.getChampByName("chantierlib").setLibelle("Chantier");
        pc.getChampByName("chantierlib").setLien((String) session.getValue("lien") + "?but=travaux/chantier-fiche.jsp&id="+c.getIdChantier(), "nom=");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("idUtilisateur").setVisible(false);
        pc.getChampByName("idChantier").setVisible(false);

        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "pourcentage";
        //pc.getChampByName("idChantier").setLien((String) session.getValue("lien") + "?but=travaux/chantier-fiche.jsp", "id=");

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=travaux/pourcentage-realisation-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="box-footer">
                        <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/pourcentage-realisation-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <!--<a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=travaux/pourcentage-realisation-liste.jsp&classe=mg.spat.travaux.PourcentageProjet"><button class="btn btn-danger">Supprimer</button></a>-->
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&bute=travaux/pourcentage-realisation-fiche.jsp&classe=mg.spat.travaux.PourcentageProjet&id=" + request.getParameter("id")%>" style="margin-right: 10px">Viser</a>
                        <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=travaux/pourcentage-realisation-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                    </div>
                    <br/>

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
<%
    /*} catch (Exception e) {
        e.printStackTrace();
    }*/
%>


