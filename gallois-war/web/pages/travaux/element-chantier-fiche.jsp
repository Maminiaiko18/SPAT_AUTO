<%-- 
    Document   : element-chantier-fiche
    Created on : 25 nov. 2020, 17:11:30
    Author     : Finaritra
--%>
<%@page import="affichage.PageConsulte"%>
<%@page import="elementchantier.ElementChantier"%>
<%
    try {
        ElementChantier chantier = new ElementChantier();
        PageConsulte pc = new PageConsulte(chantier, request, (user.UserEJB) session.getValue("u"));
        pc.setTitre("Fiche élément chantier");
        pc.getChampByName("code").setVisible(false);
        pc.getChampByName("caracteristique").setVisible(false);
        String id = request.getParameter("id");
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=travaux/pourcentage-realisation-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=travaux/element-chantier-fiche.jsp&classe=elementchantier.ElementChantier" style="margin-right: 10px" style = "margin-left: 10px">Viser</a>
                            <a class = "btn btn-warning pull-right" href="<%=(String) session.getValue("lien") + "?but=travaux/element-chantier-modif.jsp&id=" + request.getParameter("id")%>">Modifier</a>
                            
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>

<%    } catch (Exception ex) {
        ex.printStackTrace();
    }%>