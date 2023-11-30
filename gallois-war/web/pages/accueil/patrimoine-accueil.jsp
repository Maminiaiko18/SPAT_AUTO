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
        double total = statPat.getTotal();
%>
<div class="content-wrapper">
    <div class="menupage" style="background-image: url('../assets/img/spat_fond.jpg');">
        <a class="btn btn-primary pull-left btnentete"  style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">GESTION PATRIMOINES</a> 

        <div class="menu-container">
            <div class="row singlebtn">
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=<%=statPat.getBatimentEtConstruction().getPatrimoine()%>&currentMenu=MEN00200"> 
                        <button class="menubtn" style="font-size: 150%"><%=statPat.getBatimentEtConstruction().getPatrimoine()%> (<%=Utilitaire.doubleToInt(""+statPat.getBatimentEtConstruction().getNombre())%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn">
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=<%=statPat.getMaterielsRoulants().getPatrimoine()%>&currentMenu=MEN00200"> 
                        <button class="menubtn" style="font-size: 150%"><%=statPat.getMaterielsRoulants().getPatrimoine()%> (<%=Utilitaire.doubleToInt(""+statPat.getMaterielsRoulants().getNombre())%>)</button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=<%=statPat.getMatMobBureau().getPatrimoine()%>&currentMenu=MEN00200"> 
                        <button class="menubtn" style="font-size: 150%"><%=statPat.getMatMobBureau().getPatrimoine()%> (<%=Utilitaire.doubleToInt(""+statPat.getMatMobBureau().getNombre())%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn">
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=<%=statPat.getMaterielInfo().getPatrimoine()%>&currentMenu=MEN00200"> 
                        <button class="menubtn" style="font-size: 150%"><%=statPat.getMaterielInfo().getPatrimoine()%> (<%=Utilitaire.doubleToInt(""+statPat.getMaterielInfo().getNombre())%>)</button>
                    </a>
                </div>
                <div class="col-lg-6">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=<%=statPat.getMatMobHospitalier().getPatrimoine()%>&currentMenu=MEN00200"> 
                        <button class="menubtn" style="font-size: 150%"><%=statPat.getMatMobHospitalier().getPatrimoine()%> (<%=Utilitaire.doubleToInt(""+statPat.getMatMobHospitalier().getNombre())%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn" >
                <div class="col-lg-12">
                    <a class ="menulink" href="<%= session.getValue("lien")%>?but=patrimoine/analyse-patrimoine.jsp&idTypePatrimoine=<%=statPat.getAutreMatEquipement().getPatrimoine()%>&currentMenu=MEN00200"> 
                        <button class="menubtn" style="font-size: 150%"><%=statPat.getAutreMatEquipement().getPatrimoine()%> (<%=Utilitaire.doubleToInt(""+statPat.getAutreMatEquipement().getNombre())%>)</button>
                    </a>
                </div>
            </div>
            <div class="row singlebtn" >
                <div class="col-lg-12">
                    <a class ="menulink" href="#"> 
                        <button class="menubtn" style="font-size: 150%">Total: (<%=Utilitaire.doubleToInt(""+total)%>)</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%} catch (Exception ex) {
        ex.printStackTrace();
    }%>

