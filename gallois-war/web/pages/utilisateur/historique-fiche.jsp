<%--
    Document   : historique-fiche
    Created on : 15 févr. 2016, 21:06:31
    Author     : Ntsou
--%>

<%@page import="java.util.HashMap"%>
<%@page import="bean.CGenUtil"%>
<%@page import="historique.VueHistoriqueValeur"%>
<%@page import="historique.Historique_valeur"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%
    String id = request.getParameter("idhisto");
    UserEJB u = null;
    String lien = null;
    
%>
<%
    try {
	u = (UserEJB) session.getAttribute("u");
	lien = (String) session.getValue("lien");
	VueHistoriqueValeur hv = new VueHistoriqueValeur();
	hv.setIdhisto(id);
	VueHistoriqueValeur[] listresult_hv = ((VueHistoriqueValeur[]) CGenUtil.rechercher(hv, null, null, " and IDHISTORIQUE='" + hv.getIdhisto() + "'"));
	if (listresult_hv.length == 0) {
	    throw new Exception("Historique introuvable");
	}
	VueHistoriqueValeur result_hv = listresult_hv[0];
	HashMap<String, String> liste_val = result_hv.listeVal();
%>
<!DOCTYPE html>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Fiche Historique Valeur</h1>
    </section>
    <section class="content">
	<form class="form-horizontal">
	    <div class="form-group">
		<label for="idhistorique" class="col-sm-2 control-label">IDHISTORIQUE</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="idhistorique" value="<%= result_hv.getIdhisto()%>">
		</div>
	    </div>
	    <div class="form-group">
		<label for="datehistorique" class="col-sm-2 control-label">DATE HISTORIQUE</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="datehistorique" value="<%= result_hv.getDatehistorique()%>">
		</div>
	    </div>
	    <div class="form-group">
		<label for="heure" class="col-sm-2 control-label">HEURE</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="heure" value="<%= result_hv.getHeure()%>">
		</div>
	    </div>
	    <div class="form-group">
		<label for="action" class="col-sm-2 control-label">ACTION</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="action" value="<%= result_hv.getAction()%>">
		</div>
	    </div>
	    <div class="form-group">
		<label for="idutilisateur" class="col-sm-2 control-label">IDUTILISATEUR</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="idutilisateur" value="<%= result_hv.getIdutilisateur()%>">
		</div>
	    </div>
	    <div class="form-group">
		<label for="refobjet" class="col-sm-2 control-label">REFOBJET</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="refobjet" value="<%= result_hv.getRefobjet()%>">
		</div>
	    </div>
	    <div class="form-group">
		<label for="id" class="col-sm-2 control-label">ID</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="id" value="<%= result_hv.getId()%>">
		</div>
	    </div>
	    <div class="form-group">
		<label for="nom_table" class="col-sm-2 control-label">NOM TABLE</label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="nom_table" value="<%= result_hv.getNom_table()%>">
		</div>
	    </div>
	    <% for (String key : liste_val.keySet()) {%>
	    <div class="form-group">
		<label for="<%= key.toUpperCase()%>" class="col-sm-2 control-label"><%= key.toUpperCase()%></label>
		<div class="col-sm-10">
		    <input readonly class="form-control" id="<%= key.toUpperCase()%>" value="<%= liste_val.get(key)%>">
		</div>
	    </div>
	    <% } %>

	</form>

    </section>
</div>
<% } catch (Exception e) {
	throw new Exception(e.getMessage());
    }
%>
