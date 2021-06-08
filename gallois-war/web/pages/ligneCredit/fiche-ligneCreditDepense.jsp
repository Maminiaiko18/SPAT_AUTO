<%-- 
    Document   : fiche-ligneCreditDepense
    Created on : 8 juin 2021, 09:53:04
    Author     : nyamp
--%>

<%@page import="lignecredit.LigneCredit"%>
<%@page import="utilitaire.Constante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    LigneCredit e = new LigneCredit();
    e.setNomTable("ligneCreditDepense");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE LIGNE CREDIT DEPENSE");
    e = (LigneCredit) pc.getBase();
    String id= e.getId();
    String bute="ligneCredit/fiche-ligneCreditDepense.jsp";
    String classe="lignecredit.LigneCredit";
    String modifPage="ligneCredit/modif-ligneCreditDepense.jsp";
    String table="ligneCreditDepense";
    String lien = (String) session.getValue("lien");
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(id);
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="ligneCreditDepense";
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-7 col-md-offset-2">

            <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> <%=pc.getTitre()%> 
                </h1>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                </div>
                <div class="box-footer">
                    <p>
                        <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute="   +bute+"&id=" + e.getId() %>" style="margin-right: 10px">Attacher Fichier</a> 
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but="+modifPage+"&id=" + id %>&nomtable=<%=table%>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=valider&nomtable=<%=table%>&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Viser</a>
                        <!--<a class="btn btn-danger"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&nomtable=<%=table%>&acte=annulerVisa&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Annuler visa</a>-->
                    </p>
                    <hr>
                </div>
            </div>
        </div>
    </div>
              
                
    <!--    fin detail      -->
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
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

