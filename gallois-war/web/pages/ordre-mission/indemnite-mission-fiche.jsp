

<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@page import="ordremission.IndemniteMission"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    IndemniteMission t = new IndemniteMission();
    t.setNomTable("indemnite_mission_lib");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID( );
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idcategorieprofessionnel").setVisible(false);
    pc.getChampByName("idcategorieprofessionnellib").setLibelle("Catégorie Professionnel");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("fraishebergement").setLibelle("Frais d'hébergement");
    pc.getChampByName("fraisrestauration").setLibelle("Frais de restauration");
    pc.getChampByName("fraisdeplacement").setLibelle("Frais de déplacement");
    pc.getChampByName("fraisforfaitaire").setLibelle("Frais forfaitaire");
    pc.setTitre("Fiche d'un indemnité de mission ");
    String lien = (String) session.getValue("lien");
    String pageModif = "ordre-mission/indemnite-mission-modif.jsp";
    String classe = "ordremission.IndemniteMission";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="#"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
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
} %>
