<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="configuration.*" %>
<%@ page import="mg.cnaps.securite.*" %>
<%
    SecSite[] liste = SecService.getAllSite();
    String lien = (String) session.getAttribute("lien");
%>
<div class="content-wrapper">
    <div class="col-md-12">
        <div class="box box-primary">
            <div class="box-head">
                <h1 class="box-title">Choix du Site</h1>
            </div>
            <div class="box-body">
                <p>Selectionnez le site dont vous voulez voir le planning</p>                   
                <form method="post" action="<%=lien%>?but=choix/choixCalendrier.jsp">
                    <select name="site" id="site">
                    <% 
                    for (int i = 0; i < liste.length; i++) { 
                    %>
                    <option value="<%=liste[i].getId()%>"><%=liste[i].getAdresse()%></option>
                    <%
                    }
                    %>
                    </select>
                </form>
            </div>
        </div>
    </div>
</div>


