<%-- 
    Document   : navire-fiche
    Created on : 5 nov. 2019, 16:45:46
    Author     : john
--%>

<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.Navire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Navire navire = new Navire();
    navire.setNomTable("navirelib");
    //if(request.getParameter("id")!=null && request.getParameter("id").compareToIgnoreCase("")!=0)navire.setId(request.getParameter("id"));
    PageConsulte pc = pc = new PageConsulte(navire, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche navire");
    pc.getChampByName("Reference").setVisible(false);
    pc.getChampByName("armateurlib").setLibelle("armateur");
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="navire";
    Navire base = (Navire) pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=capitainerie/navire-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/navire-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + base.getId()%>&acte=valider&bute=capitainerie/navire-fiche.jsp&id=<%=base.getId()%>&classe=mg.spat.Navire" style="margin-right: 10px">Viser</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=capitainerie/navire-liste.jsp&classe=mg.spat.Navire"><button class="btn btn-danger">Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=capitainerie/navire-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
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