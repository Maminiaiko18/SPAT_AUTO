<%-- 
    Document   : syndicat-fiche
    Created on : 4 déc. 2019, 09:46:35
    Author     : Tin
--%>

<%@page import="mg.spat.relationhumaine.Personnel"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.Syndicat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Syndicat s = new Syndicat();
    PageConsulte pc = new PageConsulte(s, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche Syndicat");
    pc.getChampByName("id").setVisible(false);
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="syndicat";
    
    Syndicat sVise = (Syndicat) pc.getBase();
    Personnel p=new Personnel();
    p.setNomTable("personneletsyndicat");
    Personnel[] liste = (Personnel[]) CGenUtil.rechercher(p, null, null, " and IDSYNDICAT = '" + sVise.getId() + "'");

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=syndicat/syndicat-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien")%>?but=syndicat/historique-syndicat-saisie.jsp&param=1" style="margin-right: 10px">Attacher membre</a>                            <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien")%>?but=syndicat/historique-syndicat-saisie.jsp&param=2" style="margin-right: 10px">Ajouter bureau</a>
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=syndicat/syndicat-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=syndicat/syndicat-liste.jsp&classe=mg.spat.Syndicat"><button class="btn btn-danger">Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=syndicat/syndicat-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                            <%if (sVise.getEtat() != ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=syndicat/syndicat-liste.jsp&classe=mg.spat.Syndicat" style="margin-right: 10px">Viser</a>
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

                            <h2 class="box-title" style="margin-left: 10px;">Liste personnel</h2>
                        </div>
                        <div class="box-body">
			<table class="table table-striped table-bordered table-condensed table-responsive tree">
                                <thead>
                                    <tr>
                                        <th style="background-color:#bed1dd;">ID</th>
                                        <th style="background-color:#bed1dd;">Nom et prenom</th>
                                        <th style="background-color:#bed1dd;">Numero Matricule</th>                                                        <th style="background-color:#bed1dd;">Poste</th>
                                        <th style="background-color:#bed1dd;">Genre</th>
                                        <th style="background-color:#bed1dd;">Adresse</th>
                                    </tr>
                                </thead>
                               <tbody>
                                   <%if(liste==null || liste.length==0){%>
                                   <tr>
                                        <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                                    </tr>
                                  <%} else{
                                        for(Personnel item : liste){%> 
                                    <tr class="treegrid-1 treegrid-expanded">
                                        <td><%=item.getId()%></td>
                                        <td><%=item.getNom()+" "+item.getPrenom()%></td>
                                        <td><%=item.getNumeromatricule()%></td>                                                                            <td><%=item.getPoste()%></td>
                                        <td><%=item.getGenre()%></td>
                                        <td><%=item.getAdresse()%></td>
                                    </tr>
                                    <%}}%>
                                    
					
                                    </tbody>
                        </table>
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


