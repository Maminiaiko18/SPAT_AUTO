<%-- 
    Document   : prevision-fiche
    Created on : 18 nov. 2019, 09:06:23
    Author     : john
--%>

<%@page import="mg.spat.OccupationMaterielNaval"%>
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
    OccupationMaterielNaval prevision = new OccupationMaterielNaval();
    prevision.setNomTable("occupmaterielnavallib");
    PageConsulte pc = pc = new PageConsulte(prevision, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    
    pc.getChampByName("positionlib").setLibelle("Position");
    pc.getChampByName("duree").setLibelle("Duree (en minutes)");
//    pc.getChampByName("idpilote").setLibelle("Pilote");
    pc.getChampByName("idcommandant").setLibelle("Commandant");
    pc.getChampByName("idmateriel_naval").setLibelle("Matériel Naval");
    pc.getChampByName("idnatureoperation").setLibelle("Nature Opération");
    pc.getChampByName("idmanoeuvrebord").setLibelle("Manoeuvre de bord");
    pc.getChampByName("Idnavire").setLibelle("Navire");
    pc.getChampByName("idarriveelib").setLibelle("Arrivée");
    pc.getChampByName("heuredebut").setLibelle("Heure début");
    pc.getChampByName("heurefin").setLibelle("Heure fin");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("datefin").setLibelle("Date fin");
    pc.getChampByName("idarrivee").setVisible(false);
    pc.getChampByName("idnavire").setVisible(false);
    pc.getChampByName("idpilote").setVisible(false);
    pc.getChampByName("position").setVisible(false);
    pc.getChampByName("etatlib").setVisible(false);
   
    pc.setTitre("Fiche prestation");
    
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="occupationMaterielNaval";
    prevision = (OccupationMaterielNaval)pc.getBase();
    pc.getChampByName("idarriveelib").setLien((String) session.getValue("lien") + "?but=capitainerie/mouvement-fiche.jsp&id="+prevision.getIdarrivee(), "idarriveelib=");

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
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
                            <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresPrestation.jsp&acte=valider&bute=exploitants/activites-fiche.jsp&classe=mg.spat.OccupationMaterielNaval&id=" + prevision.getId()%>" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/occupationMaterielNaval-modif.jsp&id=" + prevision.getId()%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + prevision.getId()%>&acte=delete&bute=capitainerie/occupationMaterielNaval-fiche.jsp&classe=mg.spat.OccupationMaterielNaval"><button class="btn btn-danger">Supprimer</button></a>
                            <a href="<%=(String) session.getValue("lien") + "?but=exploitants/activites-saisie.jsp&idPrestation=" + prevision.getId()%>"><button class="btn btn-primary">Saisir activité</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + prevision.getId() + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=capitainerie/occupationMaterielNaval-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                            
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
