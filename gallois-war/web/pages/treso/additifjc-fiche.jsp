<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@ page import="mg.spat.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    AdditifJc t = new AdditifJc();
    t.setNomTable("AdditifJc");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    pc.setTitre("Fiche additif");
    String id=pc.getBase().getTuppleID();
    //pc.getChampByName("id").setLibelle("Id");
    //pc.getChampByName("nom").setLibelle("Nom");
    //pc.getChampByName("code").setLibelle("Code");
    pc.getChampByName("idjc").setLibelle("Journal caisse");
    pc.getChampByName("idjc").setLien((String) session.getValue("lien") + "?but=treso/journalcaisse-fiche.jsp&", "id=");

    //pc.setTitre("Fiche simple ");
    String lien = (String) session.getValue("lien");
    String pageModif = "treso/additifjc-modif.jsp";
    String classe = "mg.spat.AdditifJc";
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
                            <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=#&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
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


