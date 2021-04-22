<%-- 
    Document   : prevision-fiche
    Created on : 18 nov. 2019, 09:06:23
    Author     : john
--%>

<%@page import="mg.spat.PrevisionMaterielNaval"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@page import="mg.spat.Navire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    
    
    PrevisionMaterielNaval prevision = new PrevisionMaterielNaval();
    prevision.setNomTable("PREVISIONMATERIELNAVALLIB3");
    PageConsulte pc = pc = new PageConsulte(prevision, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.getChampByName("duree").setLibelle("Duree (en minutes)");
    pc.getChampByName("idmateriel_naval").setLibelle("Mat&eacute;riel Naval");
    pc.getChampByName("idcommandant").setLibelle("Commandant");
    pc.getChampByName("idnatureoperation").setLibelle("Nature Op&eacute;ration");
    pc.getChampByName("idarrivee").setVisible(false);
    pc.getChampByName("idclient").setVisible(false);
    pc.getChampByName("idnavire").setVisible(false);
    pc.getChampByName("date_depart").setLibelle("Date fin");
    pc.getChampByName("heure_depart").setLibelle("Heure fin");
    pc.getChampByName("date_arrivee").setLibelle("Date d&eacute;but");
    pc.getChampByName("heure_arrivee").setLibelle("Heure d&eacute;but");
    pc.getChampByName("idarriveelib").setLibelle("Arriv&eacute;e");

    pc.setTitre("Fiche prevision materiel naval");
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="previsionMaterielNaval";

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=capitainerie/previsionMaterielNaval-liste.jsp"><i class=""></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="box-footer">
                        <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/previsionMaterielNaval-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=capitainerie/previsionMaterielNaval-liste.jsp&classe=mg.spat.Navire"><button class="btn btn-danger">Supprimer</button></a>
                        <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=capitainerie/previsionMaterielNaval-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                        <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id") + "&acte=valider&bute=capitainerie/occupationMaterielNaval-saisie.jsp&classe=mg.spat.PrevisionMaterielNaval"%>" style="margin-right: 10px">Occupation</a>   
                    </div>
                    <br/>

                </div>
            </div>
        </div>
                        
        <div class="col-md-12">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="box-title with-border">
                    <h2 class="box-title" style="margin-left: 10px;">Les fichiers attach&eacute;s</h2>
                </div>
                <div class="box-body">
                    <table class="table table-striped table-bordered table-condensed table-responsive tree">
                        <thead>
                            <tr>
                                <th style="background-color:#bed1dd;"></th>
                                <th style="background-color:#bed1dd;">Libell&eacute;</th>
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
