<%-- 
    Document   : patrimoine-fiche
    Created on : 4 déc. 2019, 10:55:40
    Author     : Tin
--%>

<%@page import="mg.spat.DetailsPatrimoineLib"%>
<%@page import="mg.spat.DetailsPatrimoine"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        DetailsPatrimoineLib p = new DetailsPatrimoineLib();

        PageConsulte pc = new PageConsulte(p, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

        pc.setTitre("Fiche détails patrimoine");
        pc.getChampByName("id").setVisible(false);
        pc.getChampByName("utilisation").setVisible(false);
        pc.getChampByName("cours_change").setVisible(false);
        pc.getChampByName("date_change").setVisible(false);
        pc.getChampByName("PUISSANCE").setVisible(false);
        pc.getChampByName("DETENTEUR").setVisible(false);
        pc.getChampByName("MAINTENANCE").setVisible(false);
        pc.getChampByName("IDTYPE_MATERIEL").setVisible(false);
        //pc.getChampByName("IMMATRICULATION").setVisible(false);
        pc.getChampByName("ETAT").setVisible(false);
        pc.getChampByName("VALMARQUE").setVisible(false);
        pc.getChampByName("DESCEMARQUE").setVisible(false);
        pc.getChampByName("VALTYPEMATERIEL").setVisible(false);
        pc.getChampByName("DESCETYPEMATERIEL").setVisible(false);
        pc.getChampByName("IDOBJET").setVisible(false);
        pc.getChampByName("IDTYPEPATRIMOINE").setVisible(false);
        pc.getChampByName("REMARQUE").setVisible(false);
        pc.getChampByName("ETATPATRIMOINE").setVisible(false);
        //pc.getChampByName("LIBELLE").setVisible(false);
        //pc.getChampByName("VALTYPEPATRIMOINE").setVisible(false);
        pc.getChampByName("DESCETYPEPATRIMOINE").setVisible(false);
        pc.getChampByName("VALETATPATRIMOINE").setVisible(false);
        pc.getChampByName("DESCEETATPATRIMOINE").setVisible(false);
        pc.getChampByName("IDDEVISE").setVisible(false);
        pc.getChampByName("VALDEVISE").setVisible(false);
        pc.getChampByName("DESCEDEVISE").setVisible(false);
        pc.getChampByName("CDCLT").setVisible(false);
        pc.getChampByName("CDCAT").setVisible(false);
        pc.getChampByName("NOMCLT").setVisible(false);
        pc.getChampByName("ADRCLT").setVisible(false);
        pc.getChampByName("NMSTTCLT").setVisible(false);
        pc.getChampByName("TELCLT").setVisible(false);
        pc.getChampByName("FAXCLT").setVisible(false);
        pc.getChampByName("NMCIN").setVisible(false);
        pc.getChampByName("NIF").setVisible(false);
        pc.getChampByName("RC").setVisible(false);
        pc.getChampByName("CATEGORIE").setVisible(false);
        pc.getChampByName("DENOMINATION").setVisible(false);
        pc.getChampByName("DATE_AQUISITION").setVisible(false);
        pc.getChampByName("IDMARQUE").setVisible(false);
        pc.getChampByName("OCCUPANT").setVisible(false);


        pc.getChampByName("idPatrimoine").setLibelle("Libell&eacute; du patrimoine");
        pc.getChampByName("natureObjet").setLibelle("Nature");
        pc.getChampByName("surfaceOccupe").setLibelle("Surface occupée");
        pc.getChampByName("surfaceDisponible").setLibelle("Surface disponible");
        pc.getChampByName("VALTYPEPATRIMOINE").setLibelle("Type patrimoine");
        pc.getChampByName("Debut_contrat").setLibelle("D&eacute;but contrat");
        pc.getChampByName("Fin_contrat").setLibelle("Fin contrat");
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "detailspatrimoine";

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=patrimoine/detailspatrimoine-fiche.jsp"><i class=""></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=patrimoine/detailspatrimoine-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=patrimoine/detailspatrimoine-liste.jsp&classe=mg.spat.DetailsPatrimoine"><button class="btn btn-danger">Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=patrimoine/detailspatrimoine-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
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
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>


