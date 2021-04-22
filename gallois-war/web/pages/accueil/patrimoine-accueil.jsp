<%-- 
    Document   : menuprincipal
    Created on : 15 nov. 2019, 09:08:51
    Author     : Antsa
--%>
<%@page import="mg.cnaps.patrimoine.StatistiquePatrimoine"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        StatistiquePatrimoine statPat = new StatistiquePatrimoine();
        double nbTerrain = statPat.getTerrain().getNombre();
        double nbMatNav = statPat.getMaterielNaval().getNombre();
        double nbMatRoul = statPat.getMaterielRoulant().getNombre();
        double nbLogBat = statPat.getLogementEtBatiment().getNombre();
        double nbQuais = statPat.getQuais().getNombre();
        double nbMagHang = statPat.getMagasinHangar().getNombre();
        double total = statPat.getTotal();
%>
<div class="content-wrapper">
    <div class="menupage" style="background-image: url('../assets/img/spat_fond.jpg');">
        <a class="btn btn-primary pull-left btnentete"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">GESTION PATRIMOINES</a> 

        <div class="menu-container">
            <div class="row singlebtn">
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=Terrains / Terre-pleine&currentMenu=MEN00200"> 
                        <button class="menubtn">Terrains / Terre-pleines (<%=Utilitaire.doubleToInt(""+nbTerrain)%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn">
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine= navals&currentMenu=MEN00200"> 
                        <button class="menubtn">Matériels navals (<%=Utilitaire.doubleToInt(""+nbMatNav)%>)</button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine= roulants&currentMenu=MEN00200"> 
                        <button class="menubtn">Matériels roulants (<%=Utilitaire.doubleToInt(""+nbMatRoul)%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn">
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=Logements/&currentMenu=MEN00200"> 
                        <button class="menubtn">Logements/Bâtiments (<%=Utilitaire.doubleToInt(""+nbLogBat)%>)</button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="#"> 
                        <button class="menubtn">Quais (<%=Utilitaire.doubleToInt(""+nbQuais)%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn" >
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=Magasins et Hangars&currentMenu=MEN00200"> 
                        <button class="menubtn">Magasins et Hangars (<%=Utilitaire.doubleToInt(""+nbMagHang)%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn" >
                <div class="col-lg-12">
                    <a class ="menulink" href="#"> 
                        <button class="menubtn">Total: (<%=Utilitaire.doubleToInt(""+total)%>)</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%} catch (Exception ex) {
        ex.printStackTrace();
    }%>

