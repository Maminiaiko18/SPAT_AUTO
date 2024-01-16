
<%@ page import="mg.spat.*" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    JourFerie t = new JourFerie();
    t.setNomTable("jour_ferie");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    String id=request.getParameter("id");
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("designation").setLibelle("Designation");
    pc.getChampByName("heureDebut").setVisible(false);
    pc.setTitre("Fiche jour f&eacuteri&eacute ");
    String lien = (String) session.getValue("lien");
    String pageModif = "parametre/jour-ferie-modif.jsp";
    String bute = "parametre/jour-ferie-liste.jsp";
    String classe = "mg.spat.JourFerie";
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
                            <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute="+bute+"&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
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

