<%--
    Document : accueil-rh
    Created on : 26 févr. 2020, 09:10:43
    Author : John
--%>
<%@ page import="mg.spat.relationhumaine.StatistiqueRH" %>
<style type="text/css">

    /* .row div a {
    width: 100%;
    }


    .content-accueil {
    margin-top: -75px;
    margin-left: auto;
    margin-right: auto;
    background: no-repeat;
    background-size: 60%;
    background-position: center;
    height: 600px;
    background-image: url("/spat/assets/img/spat_fond.jpg");
    }*/
    .row {
        margin-top: 100px;
    }


</style>
<%
    try {
        StatistiqueRH statRh = new StatistiqueRH();
        double nbPermanent = statRh.getPermanent().getNombre();
        double nbPrestataire = statRh.getPrestataire().getNombre();
        double nbTemp = statRh.getTemporaire().getNombre();
        double nbAutre = statRh.getAutres().getNombre();
        double total = statRh.getTotal();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="content-wrapper">
    <div class="container">
        <div class="menupage">
            <a class="btn btn-primary pull-left btnentete" style="margin-left: 5%; width: 90%; color: black; font-family: Times New Roman">RESSOURCES HUMAINES</a>
            <div class="row">
                <div class="col-md-4">
                    <a class="menulink" href="<%= session.getValue("lien")%>?but=rh/analyse-personnel.jsp&type=Permanent&colGroupe1=categorie"><button class="menubtn" >Personnel permanent(<%=nbPermanent%>)</button></a>
                </div>
                <div class="col-md-4 col-md-offset-4">
                    <a class="menulink" href="<%= session.getValue("lien")%>?but=rh/analyse-personnel.jsp&type=Autres&colGroupe1=categorie"><button class="menubtn" >Autres(<%=nbAutre%>)</button></a>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-md-offset-0">
                    <a class="menulink" href="#<%= session.getValue("lien")%>"><button class="menubtn">Prestataires(<%=nbPrestataire%>)</button></a>
                </div>
                <div class="col-md-4 col-md-offset-4">
                    <a class="menulink" href="<%= session.getValue("lien")%>?but=formation/formation-analyse.jsp"><button class="menubtn" >Formations</button></a>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-md-offset-0">
                    <a class="menulink" href="<%= session.getValue("lien")%>?but=rh/analyse-personnel.jsp&type=Temporaire&colGroupe1=categorie"><button class="menubtn" >Temporaires(<%=nbTemp%>)</button></a>
                </div>
                <div class="col-md-4 col-md-offset-4">
                    <a class="menulink" href="<%= session.getValue("lien")%>?but=rh/analyse-effectif-syndicat.jsp&colGroupe1=syndicat"><button class="menubtn" >Syndicats</button></a>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <a class="menulink" href="#"><button class="menubtn" >Total :<%=total%></button></a>
                </div>
            </div>
        </div>
    </div>
</div>
<%} catch (Exception ex) {
        ex.printStackTrace();
    }%>