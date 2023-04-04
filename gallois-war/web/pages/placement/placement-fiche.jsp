<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.placement.Placement"%>
<%@page import="service.SpatService"%>
<%@page import="mg.spat.placement.DetailsPlacements"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="java.util.HashMap"%>

<% try {
        SpatService serv = new SpatService();
        PlacementLibComplet b = new PlacementLibComplet();
        b.setNomTable("placementlib");
        PageConsulte pc = new PageConsulte(b, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.setTitre("Fiche Placement");
         pc.getChampByName("date_placement").setLibelle("Date placement");
        pc.getChampByName("date_echeance").setLibelle("Date echeance");
        pc.getChampByName("iddevise").setLibelle("Devise");
        pc.getChampByName("montantdevise").setLibelle("Montant devise");
        pc.getChampByName("ancienplacement").setLibelle("Ancien placement");
        pc.getChampByName("ancienPlacement").setLien((String) session.getValue("lien") + "?but=placement/placement-fiche.jsp", "id=");
        /*pc.getChampByName("entite").setVisible(false);
        pc.getChampByName("identite").setVisible(false);
        pc.getChampByName("idbanque").setVisible(false);
        pc.getChampByName("desceentite").setVisible(false);
        pc.getChampByName("descebanque").setVisible(false);
        pc.getChampByName("identite").setVisible(false);
        pc.getChampByName("identite").setLibelle("Entite");
        pc.getChampByName("valbanque").setLibelle("Banque");
       
        pc.getChampByName("iddetails").setLibelle("Details");
        pc.getChampByName("idmeredetails").setLibelle("Mere Details");
        pc.getChampByName("interet_recevoir").setLibelle("Interet recevoir");
        pc.getChampByName("interet_net").setLibelle("Interet net");
        pc.getChampByName("valentite").setLibelle("Entite");*/
        PlacementLibComplet bi = (PlacementLibComplet) pc.getBase();
        String bute = "placement/placement-fiche.jsp";
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "placement";
        
        /* 04-04-2023 */
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("detail_placement", "");
        map.put("Journal_Caisse", "");
        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "DetailPlacement";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=placement/placement-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche Placement</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="pull-right">
                            <p>

                                <%if (bi.getEtat() < ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=placement/placement-fiche.jsp&classe=mg.spat.placement.Placement">Viser</a> 
                                <a href="<%=(String) session.getValue("lien") + "?but=placement/placement-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                                <%}%>
                                <%if (bi.getEtat() < ConstanteEtat.getEtatEchu()) {%>
                                <a href="<%=(String) session.getValue("lien") + "?but=placement/remboursement-placement-saisie.jsp&disable&idplacement=" + bi.getId()%>" style="margin-right: 5px"><button class="btn btn-danger" >Echu</button></a>
                                <%}%>
                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=placement/placement-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              

                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/journalcaisse-saisie.jsp&idplacement="+ bi.getId() +"&param=sortie"+"&auto=1"%>" style="margin-right: 10px">Rendre effectif</a>   
                                  <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=placement/remboursement-placement-saisie.jsp&idplacement="+ bi.getId()%>" style="margin-right: 10px">Remboursement anticip�</a> 
                                   <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=placement/placement-saisie.jsp&idplacement="+ bi.getId()%>" style="margin-right: 10px">Replacer </a> 
                                   <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresPlacement.jsp&acte=viserEtRendreEffectif&id="+ bi.getId()%>" style="margin-right: 10px">Viser et rendre effectif</a> 
                            
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
       

            <div class="col-md-10 col-md-offset-1 ">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs nav-center">
                        <li class="<%= map.get("detail_placement")%>"><a href="module.jsp?but=<%=bute%>&id=<%=bi.getId()%>&tab=DetailPlacement">Details Placements</a></li>
                        <li class="<%= map.get("Journal_Caisse")%>"><a href="module.jsp?but=<%=bute%>&idPlacement=<%=bi.getId()%>&tab=journalCaisse-liste">Journal Caisse</a></li>
                    </ul>
                    <div class="tab-content">       

                        <div class="tab-content">
                            <jsp:include page="<%=tab%>" >
                                <jsp:param name="idmvt" value="<%=bi.getId()%>" />
                            </jsp:include>
                        </div>
                    </div>
                </div>
            </div>  
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="box-title with-border">

                <h2 class="box-title" style="margin-left: 10px;">Les fichiers attach�s</h2>
            </div>
            <div class="box-body">
                <table class="table table-striped table-bordered table-condensed table-responsive tree">
                    <thead>
                        <tr>
                            <th style="background-color:#bed1dd;"></th>
                            <th style="background-color:#bed1dd;">Libell�</th>
                            <th style="background-color:#bed1dd;">Fichier</th>
                            <th style="background-color:#bed1dd;">Voir</th>
                            <th style="background-color:#bed1dd;">#</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%if (fichiers == null || fichiers.length == 0) {%>
                        <tr>
                            <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
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
<%} catch (Exception e) {
    e.printStackTrace();
    }%>




