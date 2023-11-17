<%-- 
    Document   : chantier-fiche
    Created on : 4 d�c. 2019, 09:25:52
    Author     : Tin
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.Chantier"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Chantier c = new Chantier();
    c.setNomTable("chantierlibelle");
    PageConsulte pc = new PageConsulte(c, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche Chantier");
    pc.getChampByName("id").setVisible(false);
    pc.getChampByName("idtiers").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("codeetablissement").setVisible(false);
    pc.getChampByName("projet").setVisible(false);
    pc.getChampByName("travaux").setVisible(false);
    pc.getChampByName("idpatrimoine").setVisible(false);
    pc.getChampByName("patrimoinedesce").setVisible(false);

    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("idtravaux").setLibelle("travaux");
    pc.getChampByName("datydebut").setLibelle("Date d&eacute;but");
    pc.getChampByName("datyfin").setLibelle("Date fin");
    pc.getChampByName("patrimoinelib").setLibelle("Patrimoine");
    pc.getChampByName("avancement").setLibelle("Avancement %");
    pc.getChampByName("dirtravaux").setLibelle("Direction");
    pc.getChampByName("codeetablissementlib").setLibelle("Code &eacute;tablissement");
    pc.getChampByName("projetlib").setLibelle("Projet");
    c = (Chantier) pc.getBase();
    pc.getChampByName("idtravaux").setLien((String) session.getValue("lien") + "?but=travaux/travaux-fiche.jsp","id="+ c.getTravaux()+"&id=");
    pc.getChampByName("patrimoinelib").setLien((String) session.getValue("lien") + "?but=patrimoine/patrimoine-fiche.jsp","id="+ c.getIdpatrimoine()+"&id=");
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier = "travaux";

    Chantier cVise = (Chantier) pc.getBase();

    /*Onglets*/
    String tab = null;
    Map<String, String> map = new HashMap<String, String>();
    map.put("avancement", "");
    map.put("engagement", "");
    map.put("facturefournisseur", "");

    String id = cVise.getId();
    tab = request.getParameter("tab");
    if (tab == null) {
        tab = "avancement";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=travaux/chantier-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="box-footer">
                        <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=depense/engagement-saisie.jsp&idchantier="+cVise.getId()%>" style="margin-right: 10px">Saisir contrat</a>
                        <a class="btn btn-info pull-left"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=travaux/chantier-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                        <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/chantier-modif.jsp&id=" + cVise.getId()%>" style="margin-right: 10px">Modifier</a>
                        <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" +cVise.getId()%>&acte=delete&bute=travaux/chantier-liste.jsp&classe=mg.spat.Chantier"><button class="btn btn-danger">Supprimer</button></a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + cVise.getId()%>&acte=valider&bute=travaux/chantier-fiche.jsp&id=<%=cVise.getId()%>&classe=mg.spat.Chantier" style="margin-right: 10px">Viser</a>
                    </div>
                    <br/>

                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%= map.get("avancement")%>"><a href="globalnegoce.jsp?but=travaux/chantier-fiche.jsp&id=<%=id%>&tab=avancement">Avancement</a></li>
                    <li class="<%= map.get("engagement")%>"><a href="globalnegoce.jsp?but=travaux/chantier-fiche.jsp&id=<%=id%>&tab=engagement">Contrat</a></li>
                    <li class="<%= map.get("facturefournisseur")%>"><a href="globalnegoce.jsp?but=travaux/chantier-fiche.jsp&id=<%=id%>&tab=facturefournisseur">Facture Fournisseur</a></li>
                </ul>
                
                <div class="tab-content">       
                   <jsp:include page="<%=tab%>" />  
               </div>
               

                <div class="col-md-12">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="box-title with-border">

                            <h2 class="box-title" style="margin-left: 10px;">Les fichiers attach�s</h2>
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
        </div>
    </div>
</div>

