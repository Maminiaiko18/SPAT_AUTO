
<%@page import="mg.spat.Contrat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    try{
    //Information sur les navigations via la page
    String lien = (String) session.getValue("lien");
    String pageModif = "travaux/contrat-modif-nouveau.jsp";
    String classe = "mg.spat.Contrat";
    String pageActuel = "travaux/contrat-fiche-nouveau.jsp";

    //Information sur la fiche
    Contrat t = new Contrat();
    t.setNomTable("CONTRATLIBCPLT");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
//    t = (Contrat) pc.getBase();
    String id=request.getParameter("id");
//    pc.getChampByName("id").setLibelle("Id");
//    pc.getChampByName("nom").setLibelle("Nom");
//    pc.getChampByName("montantTotal").setLibelle("Montant Total");
    pc.setTitre("Fiche contrat");


    Map<String, String> map = new HashMap();
    map.put("avenant","");
    
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "avenant";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=travaux/contrat-fiche-nouveau.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
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
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <!-- a modifier -->
                    <li class="<%=map.get("avenant")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=avenant">Avenants</a></li>

                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idmere" value="<%= id %>" />
                    </jsp:include>
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
