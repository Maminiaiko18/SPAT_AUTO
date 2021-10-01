<%-- 
    Document   : avoirFC-fiche.jsp
    Created on : 12 mai 2021, 09:18:59
    Author     : nyamp
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="avoir.AvoirFC"%>
<%@page import="avoir.AvoirFCFille"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    AvoirFC e = new AvoirFC();
    e.setNomTable("avoirFF");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE AVOIR FACTURE FOURNISSEUR");
    
    pc.getChampByName("idfacture").setLibelle("Facture");
    pc.getChampByName("daty").setLibelle("Date");
//    pc.getChampByName("motif").setVisible(false);
    pc.getChampByName("categorie").setVisible(false);
    pc.getChampByName("type").setLibelle("Type");
//    pc.getChampByName("montant").setLibelle("Montant");
//    pc.getChampByName("montantpaye").setLibelle("Montant payé");
//    pc.getChampByName("montantreste").setLibelle("RAP");
//    pc.getChampByName("motiflib").setLibelle("Motif");
    pc.getChampByName("categorie").setLibelle("Categorie");
    pc.getChampByName("code").setLibelle("Code");
    pc.getChampByName("idfacture").setLien((String) session.getValue("lien") + "?but=facture/factureclient-fiche-vaovao.jsp", "id=");
    e = (AvoirFC) pc.getBase();
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="avoir";
    String id= e.getId();
    
    
    String bute="avoir/avoirFF-fiche.jsp";
    String classe="avoir.AvoirFF";
    String modifPage="avoir/avoirFF-modif.jsp";
    
    Map<String, String> map = new HashMap();
        map.put("avoirFFfille", "");
        map.put("paiements", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "avoirFFfille";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">

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
                    <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + e.getId() + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute="   +bute+"&id=" + e.getId() %>" style="margin-right: 10px">Attacher Fichier</a> 
                    <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but="+modifPage+"&id=" + e.getId() %>" style="margin-right: 10px">Modifier</a>
                    <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=valider&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Viser</a>
                    <!--<a class="btn btn-primary pull-primary"  href="<%=(String) session.getValue("lien") + "?but=avoir/avoirFC-regul.jsp&idAvoir=" + e.getId() %>" style="margin-right: 10px">Régulariser facture</a>--> 
                    <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/ordonnerpayement-saisie.jsp&idAvoir=" + e.getId() %>" style="margin-right: 10px">Payer</a>        
                    <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=annulerVisa&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Annuler visa</a>
                    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerAvoir&id=<%=id%>" style="margin-right: 10px">Imprimer</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("avoirFFfille")%>"><a href="module.jsp?but=<%=bute%>&idAvoir=<%=e.getId()%>&tab=avoirFFfille">D&eacute;tails Avoir</a></li>
                    <li class="<%= map.get("paiements")%>"><a href="module.jsp?but=<%=bute%>&idplacement=<%=e.getId()%>&tab=paiements">Paiements</a></li>
                </ul>
                <div class="tab-content">
                <div class="tab-content">       
                    <jsp:include page="<%=tab%>"></jsp:include>
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

