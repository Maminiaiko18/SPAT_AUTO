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
        <a class="btn btn-primary pull-left btnentete"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">MENU PRINCIPAL</a> 
      
        <div class="menu-container">
            <div class="row singlebtn">
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=accueil/accueil-capitainerie.jsp"> 
                        <button class="menubtn">Capitainerie</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn">
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=accueil/concessionnaire-accueil.jsp"> 
                        <button class="menubtn"><p>Concessionnaires<br>/Permissionnaires/Autres</p></button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=accueil/patrimoine-accueil.jsp"> 
                        <button class="menubtn">Gestion patrimoines</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn">
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=accueil/accueil-rh.jsp"> 
                        <button class="menubtn">Ressources Humaines</button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=travaux/analyse-travaux.jsp&currentMenu=MENP013"> 
                        <button class="menubtn">Travaux</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn" >
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien") %>?but=accueil/finance.jsp"> 
                        <button class="menubtn">Finances</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

