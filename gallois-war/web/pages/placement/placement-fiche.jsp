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

<% try {
        SpatService serv = new SpatService();
        PlacementLibComplet b = new PlacementLibComplet();
        b.setNomTable("placementlib");
        PageConsulte pc = new PageConsulte(b, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.setTitre("Fiche Placement");
         pc.getChampByName("date_placement").setLibelle("Date placement");
        pc.getChampByName("date_echeance").setLibelle("Date echeance");
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

        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "placement";

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
                                <a href="<%=(String) session.getValue("lien") + "?but=placement/remboursement-placement-saisie.jsp&idplacement=" + bi.getId()%>" style="margin-right: 5px"><button class="btn btn-danger" >Echu</button></a>
                                <%}%>
                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=placement/placement-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              

                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/journalcaisse-saisie.jsp&idplacement="+ bi.getId() +"&param=sortie"+"&auto=1"%>" style="margin-right: 10px">Rendre effectif</a>   
                                  <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=placement/remboursement-placement-saisie.jsp&idplacement="+ bi.getId()%>" style="margin-right: 10px">Remboursement anticipé</a> 
                                   <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=placement/placement-saisie.jsp&idplacement="+ bi.getId()%>" style="margin-right: 10px">Replacer </a> 
                                   <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresPlacement.jsp&acte=viserEtRendreEffectif&id="+ bi.getId()%>" style="margin-right: 10px">Viser et rendre effectif</a> 
                            
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">    

        <section class="content-header">

        </section>
        <section class="content">
            <div class="row col-md-12">
                <div class="box box-solid">
                    <div style="background:#ffb401; color:white;" class="box-header">
                        <h3 class="box-title" align="center">LISTE</h3>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <div id="selectnonee">
                            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                                <thead><tr class="head">
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Id</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Mois</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Montant terme</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Interet recevoir</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Interet net</a>
                                        </th>
                                        <th width="10%" align="center" valign="top" style="background-color:#103a8e">
                                            <a href="#" style="color:white;">Modifier</a>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%

                                        DetailsPlacements[] temp = serv.getDetailsPlacements(null, bi.getId());
                                        System.out.println(temp + " DETAILSPLACEMENTTABLES");
                                        /*String libEnteteAffiche[] = {"id", "idMere", "mois", "montant_terme", "Interet_recevoir", "Interet_net", "Modifier"};
                                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                                        out.println(pr.getTableau().getHtml());*/

                                        for (int i = 0; i < temp.length; i++) {
                                    %>
                                    <tr onmouseover="this.style.backgroundColor = '#EAEAEA'" onmouseout="this.style.backgroundColor = ''">
                                        <td width="10%" align="left"><%= temp[i].getId()%> </td>
                                        <td width="10%" align="left"><%=temp[i].getMois()%> </td>
                                        <td width="10%" align="left"><%= Utilitaire.formaterAr(temp[i].getMontant_terme())%> </td>
                                        <td width="10%" align="left"><%=Utilitaire.formaterAr(temp[i].getInteret_recevoir())%> </td>
                                        <td width="10%" align="left"><%=Utilitaire.formaterAr(temp[i].getInteret_net())%> </td>
                                        <td width="10%" align="left"> <a href="<%=(String) session.getValue("lien") + "?but=placement/detailsPlacement-modif.jsp&id=" + temp[i].getId()%>">Modifier</a> </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </section>  

    </div> 

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




