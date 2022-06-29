<%-- 
    Document   : factureclient-fiche-vaovao
    Created on : 12 mai 2021, 13:56:24
    Author     : nyamp
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="facture.BonProvisoire"%>
<%@page import="data.FactureData"%>
<%@page import="utilitaire.Constante"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.Constante"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        UserEJB u = (user.UserEJB) session.getValue("u");
        String user = ""+u.getUser().getRefuser();
        
        BonProvisoire e = new BonProvisoire();
        e.setNomTable("bon_provisoire_final_lib");
        PageConsulte pc = new PageConsulte(e, request, u);
        pc.setTitre("Fiche Bon provisoire");
        String lien = (String)session.getValue("lien");

        pc.getChampByName("id").setLibelle("Identifiant");
        pc.getChampByName("tierslib").setLibelle("Tiers");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("caisselib").setLibelle("Caisse");
        pc.getChampByName("montant").setLibelle("Montant");
        pc.getChampByName("etat").setLibelle("Etat");
        pc.getChampByName("caisse").setVisible(false);
        pc.getChampByName("tiers").setVisible(false);
       
        String bute = "facture/bon-provisoire-fiche.jsp";
        String modifPage = "facture/bon-provisoire-modif.jsp";
        String redirect = lien + "?but=" + modifPage + "&id=" + request.getParameter("id");
        e = (BonProvisoire) pc.getBase();
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "facture";
        String id = e.getId();
        String vue = e.getRemarque() != null && e.getRemarque().startsWith("--") ? "ANALYSEGLOBALEFACTURE_VAOVAO" : "ANALYSEGLOBALEANTSIKA";
		
        Map<String, String> map = new HashMap<String, String>();
        map.put("factureProvision", "");
        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "factureProvision";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
%>

<style type="text/css">
    #div-password {
        position: fixed;
        z-index: 10;
        background-color: #f1f1f1;
        border: 1px solid #d3d3d3;
        text-align: center;
        top: 150px;
        left: 50vw;
        width: 300px;
        height: 180px;
        display: none;
        box-shadow: 3px 6px 47px 3px rgb(0 0 0);
    }

    #div-password-header {
        padding: 10px;
        cursor: move;
        z-index: 10;
        background-color: #2196F3;
        color: #fff;
    }
    .skin-blue .wrapper, .skin-blue .main-sidebar, .skin-blue .left-side {
        background-color: #ecf0f5;
    }
    .main-footer{
        margin-left: 0px;
    }
</style>

<script>
    function annulation() {
        document.getElementById("mdp").value = "";
        var elmnt = document.getElementById("div-password");
        elmnt.style.display = "none";
    }

    function envoyer() {
        document.getElementById("form-avoir-interne").submit();
    }

    function avoirInterne() {
        document.getElementById("mdp").value = "";
        var elmnt = document.getElementById("div-password");
        elmnt.style.display = "block";
    }
</script>
<style>
    .col-md-center .box-fiche{
        min-width:100%;
    }
</style>
<div class="content-wrapper">
    
    <div class="row">
        <div class="col-md-7 col-md-offset-2">

            <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> <%=pc.getTitre()%> 
                </h1>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
				
                </div>				
                <div class="box-footer">
                    <p>
                        <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id")%>&bute=facture/bon-provisoire-fiche.jsp&classe=facture.BonProvisoire" style="margin-right: 10px">Viser</a>
            
                    <hr>
                    <hr>
                    <p>
                        <a class="btn btn-default"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + e.getId() + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=" + bute + "&id=" + e.getId()%>" style="margin-right: 10px">Attacher Fichier</a>
                    </p>
                    <hr>
                   
                    </hr>
                    <p>
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but=" + modifPage + "&id=" + e.getId()%>" style="margin-right: 10px">Modifier</a>
                    </p>
                    <hr>
                    <hr>
                </div>				
            </div>
        </div>
    </div>
					<div class="row">
						<div class="col-md-10 col-md-offset-1 ">
							<div class="nav-tabs-custom">
								<ul class="nav nav-tabs nav-center">
									<li class="<%= map.get("factureProvision")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=factureProvision">Factures de provisions</a></li>
								</ul>
							</div>
							<div class="tab-content">       
								<jsp:include page="<%=tab%>" >
									<jsp:param name="bonprovisoire" value="<%=e.getId()%>" />
								</jsp:include>
							</div>
						</div>
					</div>	

    <div class="row">

        <!--    fin detail      -->
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="box-title with-border">
                    <h2 class="box-title" style="margin-left: 10px;">Les fichiers attachés</h2>
                </div>
                <div class="box-body">
                    <table class="table table-striped table-bordered table-condensed table-responsive tree">
                        <thead>
                            <tr>
                                <th style="background-color:#bed1dd;"></th>
                                <th style="background-color:#bed1dd;">Libellé</th>
                                <th style="background-color:#bed1dd;">Fichier</th>
                                <th style="background-color:#bed1dd;">Voir</th>
                                <th style="background-color:#bed1dd;">#</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%if (fichiers == null || fichiers.length == 0) {%>
                            <tr>
                                <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                            </tr>
                            <%} else {
                                 for (AttacherFichier fichier : fichiers) {%> 
                            <tr class="treegrid-1 treegrid-expanded">
                                <td><span class="treegrid-expander glyphicon glyphicon-minus"></span></td>
                                <td><%=fichier.getChemin()%></td>
                                <td><%=Utilitaire.champNull(fichier.getLibelle())%></td>
                                <td><a href="#" class="btn btn-primary" onclick="javascript:pagePopUp('<%=cdn + dossier + "/" + fichier.getChemin()%>')">Voir</a></td>
                                <td></td>
                            </tr>
                            <%}
                                   }%>
                        </tbody>  
                    </table>
                </div>
            </div>
        </div>
    </div>
<script>
    $('#fiche .row .col-md-6').removeClass('col-md-6').removeClass('col-md-center').addClass('col-md-8').addClass('col-md-offset-2');
</script>	
<%
    } catch (Exception e) {
    e.printStackTrace();
%>
    <script language="JavaScript"> alert('<%=e.getMessage()%>');
        history.back();</script>
<% }%>

