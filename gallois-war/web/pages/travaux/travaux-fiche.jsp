<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.TravauxTiersLibComplet"%>
<%@page import="service.SpatService"%>
<%@page import="mg.spat.Travaux_tiers"%>
<%-- 
    Document   : travaux-fiche
    Created on : 4 déc. 2019, 09:44:30
    Author     : Tin
--%>

<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.Travaux"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Travaux t = new Travaux();
    t.setNomTable("travauxlib");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    t = (Travaux) pc.getBase();

    pc.setTitre("Fiche Projet");
    pc.getChampByName("id").setVisible(false);
    pc.getChampByName("avancement").setVisible(false);
    pc.getChampByName("datedebut").setLibelle("date debut");
    pc.getChampByName("PROJETLIB").setVisible(false);
    pc.getChampByName("CODEETABLISSEMENTLIB").setVisible(false);
    pc.getChampByName("datefin").setLibelle("date fin");
    pc.getChampByName("iddevise").setLibelle("Devise");
    pc.getChampByName("patrimoinelib").setLibelle("Patrimoine");
    pc.getChampByName("idtypetravaux").setLibelle("type projet");
    pc.getChampByName("projet").setVisible(false);
    pc.getChampByName("codeetablissement").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("idpatrimoine").setVisible(false);
    pc.getChampByName("patrimoinedesce").setVisible(false);
    pc.getChampByName("patrimoinelib").setLien((String) session.getValue("lien") + "?but=patrimoine/patrimoine-fiche.jsp","id="+ t.getIdpatrimoine()+"&id=");
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier = "travaux";

    Travaux tVise = (Travaux) pc.getBase();

    /*Onglets*/
    String tab = null;
    Map<String, String> map = new HashMap<String, String>();
    map.put("chantier-travaux", "");
    map.put("facture-fournisseur-travaux", "");
    map.put("contrat-travaux", "");

    String id = request.getParameter("id");
    tab = request.getParameter("tab");
    if (tab == null) {
        tab = "chantier-travaux";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=travaux/travaux-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());

                    %>
                    <!--                    <div class="row">
                                            <div class="col-md-3">
                                            </div>
                                            <div class="col-md-6">
                                                <table class="table table-bordered">
                                                    <tbody>
                                                        <tr>
                                                            <td><b>Moyenne d'avancement (%)</b></td>
                                                            <td> <%// out.println(t.getValueAvancement(tVise.getId(), null));%></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <br/>-->
                    <div class="box-footer">
                        <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/travaux-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=travaux/travaux-liste.jsp&classe=mg.spat.Travaux"><button class="btn btn-danger">Supprimer</button></a>
                        <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=travaux/travaux-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                        <%if (tVise.getEtat() != ConstanteEtat.getEtatValider()) {%>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=travaux/travaux-fiche.jsp&classe=mg.spat.Travaux" style="margin-right: 10px">Viser</a>
                        <%}%>
                        <!-- <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/travaux-tiers-saisie.jsp&idtravaux=" + request.getParameter("id")%>&typetiers=partenaire" style="margin-right: 10px">Partenaire</a>
                         <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/travaux-tiers-saisie.jsp&idtravaux=" + request.getParameter("id")%>&typetiers=prestataire" style="margin-right: 10px">Prestataire</a> -->
                        <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/chantier-saisie.jsp&idtravaux=" + request.getParameter("id") + "&nom=" + tVise.getNom() + "&idpatrimoine=" + tVise.getIdpatrimoine() + "&patrimoine=" + tVise.getPatrimoinelib()%>" style="margin-right: 10px">Saisir Chantier</a>

                    </div>
                    <br/>

                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%= map.get("chantier-travaux")%>"><a href="globalnegoce.jsp?but=travaux/travaux-fiche.jsp&id=<%=request.getParameter("id")%>&tab=chantier-travaux">Chantiers</a></li>
                    <li class="<%= map.get("facture-fournisseur-travaux")%>"><a href="globalnegoce.jsp?but=travaux/travaux-fiche.jsp&id=<%=request.getParameter("id")%>&remarque=<%=request.getParameter("remarque")%>&tab=facture-fournisseur-travaux">Facture fournisseurs</a></li>
                    <li class="<%= map.get("contrat-travaux")%>"><a href="globalnegoce.jsp?but=travaux/travaux-fiche.jsp&id=<%=request.getParameter("id")%>&tab=contrat-travaux&idtravaux=<%=request.getParameter("id")%>">Contrats</a></li>
                </ul>

                <div class="tab-content">       
                    <jsp:include page="<%=tab%>" />  
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
</div>


