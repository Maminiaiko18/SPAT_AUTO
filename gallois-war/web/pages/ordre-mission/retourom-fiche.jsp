
<%@page import="ordremission.RetourOM"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    try{
    RetourOM  t = new RetourOM ();
    t.setNomTable("RETOUROMLIBCPLT");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    
    t = (RetourOM) pc.getBase();
    String id = t.getId();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("datearrivee").setLibelle("Date arriv&eacute;e");
    pc.getChampByName("heurearrivee").setLibelle("Heure arriv&eacute;e");
    pc.getChampByName("prixunitaire").setLibelle("Prix unitaire");
    pc.getChampByName("dureereelle").setLibelle("Dur&eacute;e r&eacute;elle");
    pc.getChampByName("nombres").setLibelle("Quantit&eacute;");
    pc.getChampByName("omlib").setLibelle("Ordre de mission");
    pc.getChampByName("omlib").setLien((String)session.getValue("lien")+"?but=ordre-mission/ordre-mission-fiche.jsp", "id="+t.getIdom()+"&id=");
    pc.getChampByName("idom").setVisible(false);
    
    pc.setTitre("Fiche retour OM");
    String lien = (String) session.getValue("lien");
    String pageModif = "ordre-mission/retourom-modif.jsp";
    String classe = "ordremission.RetourOM";
    String bute="ordre-mission/retourom-fiche.jsp"; 
       
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <dOiv class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien %>?but=ordre-mission/retourom-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin: 5px 10px 0px 0px">Modifier</a>
                            <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=validerROM&id=" + request.getParameter("id")%>&bute=facture/facture-fournisseur-modif-vaovao.jsp&classe=<%=classe %>" style="margin: 5px 10px 0px 0px">Viser</a>
                         </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
            
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
}
%>


