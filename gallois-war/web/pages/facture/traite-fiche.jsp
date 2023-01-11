<%-- 
    Document   : regularisation-fiche
    Created on : 4 janv. 2022, 23:41:49
    Author     : Mucas
--%>

<%@ page import="affichage.PageConsulte" %>
<%@ page import="facture.tr.Traite" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%
    String lien = (String) session.getValue("lien"),
           titre = "Traite Fiche",
           mapping = "facture.tr.Traite",
           apres = "facture/traite-fiche.jsp";
    try {
        Traite traite = new Traite();
        PageConsulte pc = new PageConsulte(traite, request, (user.UserEJB) session.getValue("u"));
        pc.getChampByName("id").setVisible(false);
        pc.getChampByName("tiers").setLibelle("Tiers");
        pc.getChampByName("banque").setLibelle("Banque");
        pc.getChampByName("reference").setLibelle("R&eacute;f&eacute;rence");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("dateEcheance").setLibelle("Date echeance");
        pc.getChampByName("montant").setLibelle("Montant");
        pc.setTitre(titre);
        traite = (Traite) pc.getBase();

        String tab = request.getParameter("tab");
        Map<String, String> map = new HashMap<String, String>();
        map.put("escompte-liste", "");
        map.put("fftraite-liste", "");
        if(tab == null) {
            tab = "escompte-liste";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
%>

<style>
    .col-md-center .box-fiche{
        min-width:100%;
    }
</style>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box" id="fiche">
                <div class="box-title with-border">
                    <h1 class="box-title"><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%out.println(pc.getHtml());%>
                </div>
                
                <div class="box-footer">
                    <a class="btn btn-primary"  href="<%=lien%>?but=facture/traite-modif.jsp&id=<%=request.getParameter("id")%>"  style="margin-right: 10px">Modifier</a>
             
                    <a class="btn btn-success"  href="<%=lien + "?but=apresTarif.jsp&acte=valider&classe="+mapping+"&bute="+apres+"&id=" + traite.getId() %>"  style="margin-right: 10px">Viser</a>
                    <a class="btn btn-primary"  href="<%=lien + "?but=treso/journalcaisse-saisie.jsp&credit="+traite.getMontant()+"&idmode=modetraite&caisse=caissetraite"%>"  style="margin-right: 10px">Encaisser</a>
                    <a class="btn btn-primary"  href="<%=lien + "?but=facture/escompte-saisie.jsp&idTraite="+traite.getId()%>"  style="margin-right: 10px">Escompter</a>
                    <a class="btn btn-primary"  href="<%=lien + "?but=treso/transfert-caisse.jsp&montant="+traite.getMontant()+"&caissedepart=caissetraite"%>"  style="margin-right: 10px">Verser</a>
                </div>
                
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%= map.get("escompte-liste")%>"><a href="<%=lien+"?but=facture/traite-fiche.jsp&id="+traite.getId()%>&tab=escompte-liste">Escomptes</a></li>
                    <li class="<%= map.get("fftraite-liste")%>"><a href="<%=lien+"?but=facture/traite-fiche.jsp&id="+traite.getId()%>&tab=fftraite-liste">Facture rattachees</a></li>
                </ul>
                <div class="tab-content">       
                   <jsp:include page="<%=tab%>" >  
                        <jsp:param name="idTraite" value="<%=traite.getId()%>" />
                    </jsp:include> 
                </div>
            </div>
        </div>
    </div>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>
