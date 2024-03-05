<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@page import="mg.spat.placement.DetailsPlacements"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    try{
    DetailsPlacements t = new DetailsPlacements();
    t.setNomTable("DetailsPlacement");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    t = (DetailsPlacements)pc.getBase();
    String id= t.getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    /*pc.getChampByName("nom").setLibelle("Nom");
    pc.getChampByName("code").setLibelle("Code");
    pc.getChampByName("date").setLibelle("Date");*/
    pc.getChampByName("Montant_terme").setLibelle("montant &agrave; terme");
    pc.getChampByName("Interet_recevoir").setLibelle("Interet brut");
    pc.getChampByName("Interet_net").setLibelle("Interet net");
    pc.getChampByName("idmere").setLibelle("Placement");
    pc.getChampByName("idmere").setLien((String) session.getValue("lien") + "?but=placement/placement-fiche.jsp&id=" + t.getIdmere(), "");

    pc.setTitre("D&eacute;tails placement");
    String lien = (String) session.getValue("lien");
    String pageModif = "placement/detailsPlacement-modif.jsp";
    String classe = "mg.spat.placement.DetailsPlacements";
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
                            <%-- <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a> --%>
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


