<%-- 
    Document   : menuprincipal
    Created on : 06 dec. 2021, 09:55:04
    Author     : Andomahefa
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<div class="content-wrapper">
    <div class="menupage" style="background-image: url('../assets/img/spat_fond.jpg');">
        <a class="btn btn-primary pull-left btnentete"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">FACTURATION</a> 
      
        <div class="menu-container">
            <div class="row singlebtn"></div>
            <div class="row singlebtn"></div>
            <div class="row singlebtn">
                
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=facture/factureclient-analyse.jsp"> 
                        <button class="menubtn">Analyse simple</button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=facture/analyse-facture-client-vaovao.jsp"> 
                        <button class="menubtn">Analyse croisée</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

