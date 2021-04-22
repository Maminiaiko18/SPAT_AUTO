<%-- 
    Document   : quais-fiche
    Created on : 22 nov. 2019, 09:35:52
    Author     : rajao
--%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.Quais" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    AnalyseLien analyselien=new AnalyseLien();
   
    
    PageConsulte pc = pc = new PageConsulte(analyselien, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche Analyse Lien");
    pc.getChampByName("IdUtilisateur").setVisible(false);
    pc.getChampByName("Id").setLibelle("Identifiant");
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=analyse_lien/analyselien-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=analyse_lien/analyselien-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=analyse_lien/analyselien-liste.jsp&classe=bean.AnalyseLien"><button class="btn btn-danger">Supprimer</button></a>
      
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
                        
           
    </div>
</div>
                            <%
}catch(Exception e){
    e.printStackTrace();
}%>