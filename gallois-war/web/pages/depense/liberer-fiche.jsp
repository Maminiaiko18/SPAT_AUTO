<%-- 
    Document   : liberer-fiche
    Created on : 22 févr. 2022, 14:01:41
    Author     : andri
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
<%@page import="mg.spat.Liberer"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    Liberer e = new Liberer();
    e.setNomTable("libererlib");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE LIBERER");
    e = (Liberer) pc.getBase();
    String id= e.getId();
    String idengagement=e.getIdengagement();
    String bute="depense/liberer-fiche.jsp";
    String classe="mg.spat.Libere";
    String modifPage="depense/liberer-modif.jsp";
    String table="liberer";
    String lien = (String) session.getValue("lien");
    
    
        pc.getChampByName("idengagementlib").setLibelle("Engagement");
//    pc.getChampByName("quantite").setVisible(false);
    pc.getChampByName("idengagement").setVisible(false);
   pc.getChampByName("idengagementlib").setLien(lien + "?but=depense/engagement-fiche.jsp","id="+idengagement+"&id=");
//    AttacherFichier[] fichiers = UploadService.getUploadFile(id);
//    configuration.CynthiaConf.load();
//    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
//    String dossier="ligneCreditDepense";
    
%>

<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-8 col-md-offset-2">
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
                         <a class="btn btn-warning"   href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=mg.spat.Liberer&bute=depense/liberer-fiche.jsp&id=" + request.getParameter("id")%>" style="margin-right: 5px">Viser</a>
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but="+modifPage+"&id=" + id %>&nomtable=<%=table%>" style="margin-right: 10px">Modifier</a>

                    </p>
                    <hr>
                </div>
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

