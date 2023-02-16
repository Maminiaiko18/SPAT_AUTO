<%-- 
    Document   : regularisation-fiche
    Created on : 4 janv. 2022, 23:41:49
    Author     : Mucas
--%>

<%@page import="java.text.DecimalFormat"%>
<%@ page import="affichage.PageConsulte" %>
<%@ page import="facture.tr.Traite" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.net.URLEncoder" %>
<%
    String lien = (String) session.getValue("lien"),
           titre = "Traite Fiche",
           mapping = "facture.tr.Traite",
           apres = "facture/traite-fiche.jsp",
           nomTable = "TRAITEMTTRESTE";
    try {
        Traite traite = new Traite();
        traite.setNomTable(nomTable);
        PageConsulte pc = new PageConsulte(traite, request, (user.UserEJB) session.getValue("u"));
        pc.getChampByName("id").setVisible(false);
        pc.getChampByName("tiers").setLibelle("Tiers");
        pc.getChampByName("banque").setLibelle("Banque");
        //pc.getChampByName("reference").setLibelle("R&eacute;f&eacute;rence");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("dateEcheance").setLibelle("Date echeance");
        pc.getChampByName("montant").setLibelle("Montant");
         pc.getChampByName("escompte").setLibelle("Escompte");
        pc.getChampByName("total").setLibelle("Total");
        pc.getChampByName("cdclt").setVisible(false);
        pc.getChampByName("idbanque").setVisible(false);
        pc.getChampByName("montantreste").setLibelle("Montant disponible");
        pc.getChampByName("idtypepiece").setVisible(false);
        pc.getChampByName("typepiece").setLibelle("Type pièce");
        pc.setTitre(titre);
        traite = (Traite) pc.getBase();
        String tab = request.getParameter("tab");
        Map<String, String> map = new HashMap<String, String>();
        map.put("escompte-liste", "");
        map.put("fftraite-liste", "");
        map.put("jc-liste", "");
        if(tab == null) {
            tab = "escompte-liste";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
        String montant = java.net.URLEncoder.encode(new DecimalFormat("###.##").format(traite.getTotal()), "UTF-8");
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
                        <a class="btn btn-primary"  href="<%=lien%>?but=facture/traite-modif.jsp&id=<%=request.getParameter("id")%>&tiers=<%=traite.getTiers()%>&banque=<%=traite.getIdbanque()%>&piece=<%=traite.getIdtypepiece()%>"  style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-success"  href="<%=lien + "?but=apresTarif.jsp&acte=valider&classe="+mapping+"&bute="+apres+"&id=" + traite.getId() %>"  style="margin-right: 10px">Viser</a>
                        <!---<a class="btn btn-primary"  href="<%=lien + "?but=treso/journalcaisse-saisie.jsp&credit="+traite.getMontant()+"&idmode=modetraite&caisse=caissetraite"%>"  style="margin-right: 10px">Encaisser</a>--->
                        <a class="btn btn-primary"  href="<%=lien + "?but=facture/escompte-saisie.jsp&idTraite="+traite.getId()%>"  style="margin-right: 10px">Escompter</a>
                        <a class="btn btn-primary"  href="<%=lien + "?but=facture/verser-traite.jsp&montant="+montant+"&caissedepart=caissetraite&idTraite=" + traite.getId()+"&banque="+traite.getBanque()%>"  style="margin-right: 10px">Verser</a>
                        <!--<a class="btn btn-primary"  href="#"  style="margin-right: 10px">Retourner</a>-->
                        <a style="float:right" class="btn btn-primary"  href="<%=lien + "?but=facture/attacher-traite-facture.jsp&idTraite="+traite.getId()%>"  style="margin-right: 10px">Attacher Facture</a>
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
                    <li class="<%= map.get("jc-liste")%>"><a href="<%=lien+"?but=facture/traite-fiche.jsp&id="+traite.getId()%>&tab=jc-liste">Journal caisse</a></li>
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
