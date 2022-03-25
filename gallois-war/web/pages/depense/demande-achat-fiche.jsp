<%@page import="mg.spat.DemandeAchatMere"%>
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
    DemandeAchatMere e = new DemandeAchatMere();
    e.setNomTable("dem_achat_merelib");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE DEMANDE ACHAT");
    e = (DemandeAchatMere) pc.getBase();
    String id= e.getId();
    String idengagement=e.getIdengagement();
    String lien = (String) session.getValue("lien");
       
    pc.getChampByName("idengagementlib").setLibelle("Engagement");
    pc.getChampByName("codeetablissementlib").setLibelle("Code &eacute;tablissement");
    pc.getChampByName("projetlib").setLibelle("Projet");
    pc.getChampByName("num").setLibelle("Num&eacute;ro");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("idengagement").setVisible(false);
    pc.getChampByName("codeetablissement").setVisible(false);
    pc.getChampByName("projet").setVisible(false);
    pc.getChampByName("idengagementlib").setLien(lien + "?but=depense/engagement-fiche.jsp","id="+idengagement+"&id=");
    
    Map<String, String> map = new HashMap();
    map.put("details-demande-achat","");
    
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "details-demande-achat";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";

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
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but=stock/bc/bondecommande-multiple.jsp&idDa=" + id %>" style="margin-right: 10px">Saisir BC</a>
                    </p>
                    <hr>
                </div>
            </div>
        </div>
    </div>
     <div class="row">
        <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("details-demande-achat")%>"><a href="module.jsp?but=depense/demande-achat-fiche.jsp&id=<%=e.getId()%>&tab=details-demande-achat">Détails demande achat</a></li>
                    
                </ul>
                <div class="tab-content">
                    <div class="tab-content">       
                        <jsp:include page="<%=tab%>">
                            <jsp:param name='idengagement' value="<%=e.getId()%>"/> 


                        </jsp:include>
                    </div>
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

