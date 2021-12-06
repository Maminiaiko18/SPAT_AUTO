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
        <a class="btn btn-primary pull-left btnentete"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">TRESORERIE</a> 
      
        <div class="menu-container">
            <div class="row singlebtn">
                
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=caisse/situation-comptes.jsp"> 
                        <button class="menubtn">Situation des comptes courants</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn"></div>
            <div class="row singlebtn">
                
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=placement/analyse-placement.jsp&colGroupe1=valentite&colGroupe2=valbanque"> 
                        <button class="menubtn">Placement</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

