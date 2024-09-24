<%-- 
    Document   : fiche-ligneCreditRecette.jsp
    Created on : 8 juin 2021, 09:02:54
    Author     : nyamp
--%>

<%@page import="lignecredit.Reamenagement"%>
<%@page import="utilitaire.Constante"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    Reamenagement e = new Reamenagement();
    e.setNomTable("REAMENAGEMENTLIB");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE REAMENAGEMENT");
    pc.getChampByName("idLigneDepartLib").setLibelle("Ligne D&eacute;part");
    pc.getChampByName("idLigneArriveLib").setLibelle("Ligne Arriv&eacute;");
    pc.getChampByName("idLigneDepart").setVisible(false);
    pc.getChampByName("idLigneArrive").setVisible(false);
    pc.getChampByName("id").setVisible(false);
    e = (Reamenagement) pc.getBase();
    String id= e.getId();
    String bute="ligneCredit/reamenagement-fiche.jsp";
    String classe="lignecredit.Reamenagement";
    String modifPage="ligneCredit/reamenagement-modif.jsp";
    String table="REAMENAGEMENTLIB";
    String lien = (String) session.getValue("lien");
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=lignecredit/reamenagement-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="box-footer">
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but="+modifPage+"&id=" + id %>&nomtable=<%=table%>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=valider&nomtable=<%=table%>&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Viser</a>
                    </div>
                    <br/>

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

