<%-- 
    Document   : tiers-fiche
    Created on : 4 déc. 2019, 09:26:22
    Author     : Tin
--%>

<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.Tiers"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Tiers t = new Tiers();
    t.setNomTable("union_client_fournisseur");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche Tiers");
    pc.getChampByName("id").setVisible(false);
    pc.getChampByName("compteAuxClient").setLibelle("Compte client");
    pc.getChampByName("compteAuxFournisseur").setLibelle("Compte fournisseur");
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="travaux";
    
    Tiers tVise = (Tiers) pc.getBase();
    
    String but = "", buteVisa = "";
    
    if(request.getParameter("param") != null && request.getParameter("param").compareToIgnoreCase("1") == 0){
        but = "apresTiers.jsp";
        buteVisa = "choix/listeTiersBEDChoix.jsp&champReturn=tiers;tierslibelle&apresLienPageAppel=";
    }
    else{
        buteVisa = "travaux/tiers-liste.jsp"; 
        but = "apresTarif.jsp";
    }
    
   
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=travaux/tiers-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/tiers-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                           
                             <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=travaux/tiers-liste.jsp&classe=mg.spat.Tiers"><button class="btn btn-danger">Supprimer</button></a>
                            
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=travaux/tiers-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                            <%if (tVise.getEtat() != ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but="+but+"&id=" + request.getParameter("id") + "&acte=valider&bute="+buteVisa%>&classe=mg.spat.Tiers" style="margin-right: 10px">Viser</a>
                            <%}%>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
                        
             <div class="col-md-12">
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
                                   <%if(fichiers==null || fichiers.length==0){%>
                                   <tr>
                                        <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                                    </tr>
                                  <%} else{
                                        for(AttacherFichier fichier : fichiers){%> 
                                    <tr class="treegrid-1 treegrid-expanded">
                                        <td><span class="treegrid-expander glyphicon glyphicon-minus"></span></td>
                                        <td><%=fichier.getChemin() %></td>
                                        <td><%=Utilitaire.champNull(fichier.getLibelle())%></td>
                                        <td><a href="#" class="btn btn-primary" onclick="javascript:pagePopUp('<%=cdn + dossier +"/"+ fichier.getChemin()%>')">Voir</a></td>
                                        <td></td>
                                    </tr>
                                    <%}}%>
                                    
					
                                    </tbody>
                        </table>
				</div>
				</div>
            </div>
    </div>
</div>

