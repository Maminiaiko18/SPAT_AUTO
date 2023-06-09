<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>

<%@page import="ordremission.IndemniteMission"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    IndemniteMission t =new IndemniteMission();
    PageUpdate pi = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    String titre = "Modification d'un indemnité de mission";
    pi.getFormu().getChamp("id").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idcategorieprofessionnel").setLibelle("Catégorie Professionnel");
    pi.getFormu().getChamp("idcategorieprofessionnel").setPageAppel("choix/categorie-professionnel-choix.jsp");
    pi.getFormu().getChamp("idcategorieprofessionnel").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("fraishebergement").setLibelle("Frais d'hébergement");
    pi.getFormu().getChamp("fraisrestauration").setLibelle("Frais de restauration");
    pi.getFormu().getChamp("fraisdeplacement").setLibelle("Frais de déplacement");
    pi.getFormu().getChamp("fraisforfaitaire").setLibelle("Frais forfaitaire");
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
    
    String bute = "ordre-mission/indemnite-mission-fiche.jsp";
    String classe = "ordremission.IndemniteMission";
    String nomtable = "indemnite_mission";
   
%>
<div class="content-wrapper">
    <h1><%= titre %></h1>
    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <div class="row">
            <div class="col-md-11">
                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
            </div>
            <br><br> 
        </div>
        <input name="acte" type="hidden" id="acte" value="update">
        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable %>">
    </form>
</div>