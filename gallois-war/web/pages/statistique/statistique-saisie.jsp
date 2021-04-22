<%-- 
    Document   : mouvementDepart-saisie
    Created on : 6 nov. 2019, 11:02:23
    Author     : Notiavina
--%>

<%@page import="mg.spat.Statistique"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@page import="mg.spat.Mouvement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    String lien = (String) session.getValue("lien");
%>
<div class="content-wrapper">
    <div class="box box-solid collapsed">
        <div style="background-color:#103a8e; color:white;" class="box-header with-border" align="center">
            <h3 class="box-title" color="#edb031"><span color="#edb031">Saisie statistique</span></h3>
        </div>
        <div class="box-body" id="pagerecherche" style="display: block;">
            <div class="form-group">
                <div class="col-xs-4" align="center">
                    <label>Choix : </label>
                </div>
                <div class="col-xs-4" align="center">
                    <select class="form-control" id="type">
                        <option value="conteneur">Conteneur</option>
                        <option value="societe">Societe</option>
                    </select>
                </div>
                <div class="col-md-4" align="center">
                    <input onclick="redirect()" value="Saisir" type="button" class="btn" style="background:#103a8e; color:white">
                </div>
            </div>
        </div>
    </div>    
</div>
    
<script language="JavaScript"> 
    function redirect(){
        document.location.replace("<%=lien%>?but=statistique/"+document.getElementById("type").value+"-saisie.jsp");
    }
</script>


<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
