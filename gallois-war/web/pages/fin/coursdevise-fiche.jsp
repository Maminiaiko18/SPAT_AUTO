<%-- 
    Document   : coursdevise-fiche
    Created on : 3 févr. 2021, 10:39:30
    Author     : Audace
--%>

<%@page import="fin.Coursdevise"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
   UserEJB u;
    Coursdevise a;
    try{
        a = new Coursdevise();
        a.setNomTable("coursdeviselib");
        PageConsulte pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));
        String[] ordre = {"daty"};
        pc.setOrdre(ordre);
        pc.getChampByName("iddevise").setLibelle("Devise");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("estMICTSLlib").setLibelle("Est MICTSL");
        pc.getChampByName("estMICTSL").setVisible(false);
        
        
        
        pc.setTitre("Fiche cours devise");
        
%>
        
    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="box-fiche">
                    <div class="box">
                        <div class="box-title with-border">
                            <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=fin/coursdevise-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                        </div>
                        <div class="box-body">
                            <%
                                out.println(pc.getHtml());
                            %>
                            <br/>
                        <div class="box-footer">                        
                                <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=fin/coursdevise-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>

                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%}catch(Exception exp){
        exp.printStackTrace();
    }
%>
