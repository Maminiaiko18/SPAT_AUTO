<%-- 
    Document   : additif-liste.jsp
    Created on : 18 déc. 2020, 09:55:43
    Author     : nyamp
--%>

<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.compta.Contrat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="affichage.PageConsulte"%>
<%@page import="avancement.AvancementContratLibcomplet"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    AvancementContratLibcomplet e = new AvancementContratLibcomplet();
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE AVANCEMENT CONTRAT");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("idcontratlib").setLibelle("Contrat");
    pc.getChampByName("idcontrat").setVisible(false) ;

    e = (AvancementContratLibcomplet) pc.getBase();
    pc.getChampByName("idcontratlib").setLien((String) session.getValue("lien") + "?but=travaux/contrat-fiche.jsp&id=" + e.getIdcontrat(), "nom");
    

    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="avancementProjet";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">

            <div class="box">
                <h1 class="box-title">
                    <a href="<%=(String) session.getValue("lien") + "?but=budget/projet-liste.jsp"%>">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> <%=pc.getTitre()%> 
                </h1>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                </div>
                <div class="box-footer">
                    <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + e.getId() + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=travaux/avancement-contrat-fiche.jsp&id=" + e.getId() %>" style="margin-right: 10px">Attacher Fichier</a> 
                    <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but=travaux/avancement-contrat-modif.jsp&id=" + e.getId() %>" style="margin-right: 10px">Modifier</a>
                    <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=valider&nomtable=avancement_contrat&bute=travaux/avancement-contrat-fiche.jsp&classe=projet.Projet" style="margin-right: 10px">Viser</a>
                </div>
            </div>
        </div>
    </div>
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
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

