<%-- 
    Document   : rubrique-facture-fournisseur-fiche.jsp
    Created on : 9 févr. 2021, 09:44:14
    Author     : nyamp
--%>


<%@page import="rubrique.RubriqueFactureFournisseur"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    RubriqueFactureFournisseur rubrique = new RubriqueFactureFournisseur();
    rubrique.setNomTable("rubriqueFactureFournisseurLib");
    PageConsulte pc = new PageConsulte(rubrique, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    rubrique = (RubriqueFactureFournisseur) pc.getBase();
    String id=rubrique.getId();
    pc.setTitre("Fiche rubrique facture fournisseur");
    pc.getChampByName("duree").setLibelle("Durée");
    AttacherFichier[] fichiers = UploadService.getUploadFile(id);
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="rubriqueff";
    

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/rubrique-facture-fournisseur-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=facture/rubrique-facture-fournisseur-modif.jsp&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id%>&acte=delete&bute=facture/rubrique-facture-fournisseur-liste.jsp&classe=rubrique.RubriqueFactureFournisseur"><button class="btn btn-danger">Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=facture/rubrique-facture-fournisseur-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
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
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>



