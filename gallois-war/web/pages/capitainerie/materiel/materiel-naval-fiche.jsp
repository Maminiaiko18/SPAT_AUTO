<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.MaterielNaval"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    MaterielNaval materielNaval = new MaterielNaval();
    materielNaval.setNomTable("materielnavallib");
    PageConsulte pc = pc = new PageConsulte(materielNaval, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche Materiel Naval");
    pc.getChampByName("Date_aquisition").setLibelle("Date d'aquisition");
    pc.getChampByName("IdMarque").setLibelle("Marque");
    pc.getChampByName("idCategorielib").setLibelle("Categorie");
    pc.getChampByName("idCategorie").setVisible(false);
    pc.getChampByName("IdType_materiel").setLibelle("Type de Matériel");
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="materiel";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=capitainerie/materiel/materiel-naval-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/materiel/materiel-naval-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=capitainerie/materiel/materiel-naval-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
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

