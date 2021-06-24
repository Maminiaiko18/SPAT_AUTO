<%-- 
    Document   : prevision-fiche
    Created on : 18 nov. 2019, 09:06:23
    Author     : john
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.PrevisionLibComplet"%>
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
    
    try {
        String tab = null;
        Map<String, String> map = new HashMap<String, String>();
        map.put("liste-mouvement", "");
        map.put("liste-utilisation-materiels", "");
        String id = request.getParameter("id");
        tab = request.getParameter("tab");
        if (tab == null) {
            tab = "liste-mouvement";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
        
        PrevisionLibComplet prevision = new PrevisionLibComplet();
        prevision.setNomTable("previsionfiche");
        PageConsulte pc = pc = new PageConsulte(prevision, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

        pc.getChampByName("heure_arrivee").setLibelle("Heure d'arrivée");
        pc.getChampByName("heure_depart").setLibelle("Heure de départ");
        pc.getChampByName("nomnavire").setLibelle("Navire");
        pc.getChampByName("valconsignataire").setLibelle("Consignataire");
        pc.getChampByName("valcargaison").setLibelle("Cargaison");
        pc.getChampByName("valpilote").setLibelle("Commandant");
        pc.getChampByName("valquaisprovenance").setLibelle("Quai de provenance");
        pc.getChampByName("valquaisdestination").setLibelle("Quai de destination");
        pc.getChampByName("date_arrivee").setLibelle("Date d'arrivée");
        pc.getChampByName("date_depart").setLibelle("Date de départ");
        pc.getChampByName("valpaysprovenance").setLibelle("Pays de provenance");
        pc.getChampByName("valpaysdestination").setLibelle("Pays de destination");
        pc.getChampByName("type").setLibelle("type navire");
        pc.getChampByName("noVoyage").setLibelle("No voyage");

        pc.setTitre("Fiche prevision");

        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "prevision";

        PrevisionLibComplet base = (PrevisionLibComplet) pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=capitainerie/prevision-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="box-footer">
                        <p>
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/quais/quais-prevision-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + base.getId()%>&acte=valider&bute=capitainerie/quais/quais-prevision-fiche.jsp&id=<%=base.getId()%>&classe=mg.spat.Prevision" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-danger pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + base.getId()%>&acte=annulerVisa&bute=capitainerie/quais/quais-prevision-fiche.jsp&id=<%=base.getId()%>&classe=mg.spat.Prevision" style="margin-right: 10px">Annuler Visa</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=capitainerie/prevision-liste.jsp&classe=mg.spat.Prevision"><button class="btn btn-danger">Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=capitainerie/quais/quais-prevision-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                        </p>
                        <br/>
                        <p>
                            <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/mouvement-saisie.jsp&typemvt=TPMM00004&idPrevision=" + base.getId()%>" style="margin-right: 10px">Arrivée</a>   
                            <a class="btn btn-info pull-left"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/occupationMaterielNaval-saisie.jsp&idPrevision=" + base.getId()%>" style="margin-right: 10px">Saisir prestation</a>   
                            <a class="btn btn-default pull-left"  href="<%=(String) session.getValue("lien") + "?but=exploitants/activites-saisie.jsp&idPrevision=" + base.getId()%>" style="margin-right: 10px">Saisir activite </a>   
                        <p>
                    </div>
                    <br/>

                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("liste-mouvement")%>"><a href="module.jsp?but=capitainerie/quais/quais-prevision-fiche.jsp&id=<%=base.getId()%>&tab=liste-mouvement&idprevision=<%=base.getId()%>">Liste mouvements</a></li>
                    <li class="<%= map.get("liste-utilisation-materiels")%>"><a href="module.jsp?but=capitainerie/quais/quais-prevision-fiche.jsp&id=<%=base.getId()%>&tab=liste-utilisation-materiels&idprevision=<%=base.getId()%>">Liste prestations</a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%=tab%>" />  
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
<%} catch (Exception e) {
        e.printStackTrace();
    }%>