<%-- 
    Document   : cloturer-billetage-fiche
    Created on : 7 nov. 2019, 09:49:27
    Author     : john
--%>

<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.CloturerBilletage"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
        CloturerBilletage cloture = new CloturerBilletage();
        cloture.setNomTable("cloturerbilletage");
        PageConsulte pc = new PageConsulte(cloture, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.setTitre("Fiche cloture");
        CloturerBilletage clotureVise = (CloturerBilletage)pc.getBase();

        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier="clotureBilletage";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/cloturer-billetage-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche cloture billetage</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="pull-right">
                            <p>
                        
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=treso/cloturer-billetage-liste.jsp&classe=mg.spat.CloturerBilletage" style="margin-right: 10px">Viser</a>
                                <a href="<%=(String) session.getValue("lien") + "?but=treso/cloturer-billetage-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=treso/cloturer-billetage-liste.jsp&classe=mg.spat.CloturerBilletage"><button class="btn btn-danger">Supprimer</button></a>
                                <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/cloturer-billetage-saisie.jsp"%>" style="margin-right: 10px">Cloture</a>
                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/cloturer-billetage-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                            </p>
                        </div>
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
<%}catch(Exception e){
    e.printStackTrace();
}%>
