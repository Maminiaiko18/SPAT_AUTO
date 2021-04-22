<%@ page language="java" contentType="text/html" %>
<%@page import="utilisateur.VueCNAPSUser"%>
<%@page import="affichage.PageRecherche"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%
	String lien=(String)session.getValue("lien");
%>
<div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            500 Erreur Page
          </h1>
        </section>

        <!-- Main content -->
        <section class="content">

          <div class="error-page">
            <h2 class="headline text-red">500</h2>
            <div class="error-content">
              <h3><i class="fa fa-warning text-red"></i> Oops! Quelque chose s'est mal pass&eacute;s.</h3>
              <p>
                Nous sommes en train de fixer le probl&egrave;me suivant <b><%=request.getParameter("message") %></b>.
                Retourner vers la <a onclick="back()">page pr&eacute;c&eacute;dente</a> ou cliquer sur l'un des onglets du menu.
              </p>
            </div>
          </div><!-- /.error-page -->
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
	  