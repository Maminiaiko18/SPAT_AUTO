<%-- 
    Document   : menuprincipal
    Created on : 15 nov. 2019, 09:08:51
    Author     : Antsa
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<div class="content-wrapper">
    <div class="menupage" style="background-image: url('../assets/img/spat_fond.jpg');">
        <div class="menu-container">
            <a class="btn btn-primary pull-left btnentete titreaccueil"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Romanm;margin-bottom: 5%;margin-top: -5%;">CONCESSIONNAIRES/PERMISSIONNAIRES</a> 
            </br>
            </br>
            <div class="row singlebtn">
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=capitainerie/statistique-activite/analyse-statistique-activite.jsp"> 
                        <button class="menubtn">Concessionnaires</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn">
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=capitainerie/statistique-activite/analyse-statistique-activite.jsp"> 
                        <button class="menubtn"><p>Permissionnaires</p></button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=capitainerie/statistique-activite/analyse-statistique-activite.jsp"> 
                        <button class="menubtn">Procédures</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn" >
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=capitainerie/statistique-activite/analyse-statistique-activite.jsp"> 
                        <button class="menubtn">Autres</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

