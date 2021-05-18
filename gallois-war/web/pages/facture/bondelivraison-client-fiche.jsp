<%-- 
    Document   : bondelivraison-client-fiche
    Created on : 17 mai 2021, 16:05:46
    Author     : nyamp
--%>

<%@page import="mg.spat.stock.BonDeLivraison"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="facture.FactureClientDetails"%>
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
    BonDeLivraison e = new BonDeLivraison();
    e.setNomTable("as_bondelivraison_cl");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE BON DE LIVRAISON CLIENT");
    
    pc.getChampByName("idbc").setLibelle("Facture");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("point").setVisible(false);
    e = (BonDeLivraison) pc.getBase();
    String bute="facture/bondelivraison-client-fiche.jsp";
    String classe="mg.spat.stock.BonDeLivraison";
    String modifPage="facture/bondelivraison-client-modif.jsp";
    String table="as_bondelivraison_cl";
    String id= e.getId();
    String lien = (String) session.getValue("lien");
    String redirect = lien + "?but="+modifPage+"&id=" + id;
        if(e.getEtat() < ConstanteEtat.getEtatValider()) out.println("<script language='JavaScript'> document.location.replace('"+redirect+"'); </script>");
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(id);
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="bondelivraison";
    FactureClientDetails fille=new FactureClientDetails();
    
    Map<String, String> map = new HashMap<String, String>();
    map.put("bondelivraison-client-fille", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "bondelivraison-client-fille";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
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
                        <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + e.getId() + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute="   +bute %>" style="margin-right: 10px">Attacher Fichier</a> 
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but="+modifPage+"&id=" + e.getId() %>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=valider&bute=<%=bute%>&classe=<%=classe%>&nomtable=<%=table%>" style="margin-right: 10px">Viser</a>
                        <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=annulerVisa&bute=<%=bute%>&classe=<%=classe%>&nomtable=<%=table%>" style="margin-right: 10px">Annuler visa</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
                    
    <!--    detail      -->
    
    
        <div class="row">
            <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("bondelivraison-client-fille")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=bondelivraison-client-fille">Detail bon de livraison</a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%=tab%>" >
                        <jsp:param name="numbl" value="<%=e.getId()%>" />
                    </jsp:include>
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

