
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="mg.spat.Mouvement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    

    String tab = null;
    Map<String, String> map = new HashMap<String, String>();
    map.put("liste-mouvement", "");
    map.put("liste-utilisation-materiels", "");
    String id = request.getParameter("id");

    try {
        tab = request.getParameter("tab");
        if (tab == null) {
            tab = "liste-mouvement";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";

        MouvementLibComplet m = new MouvementLibComplet();
        m.setNomTable("mouvementlibcomplet");
        PageConsulte pc = new PageConsulte(m, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.setTitre("Fiche mouvement");
        
        MouvementLibComplet mouvementVise = (MouvementLibComplet) pc.getBase();
        
        pc.getChampByName("escalelib").setLibelle("Escale");
//        pc.getChampByName("escale").setVisible(false);
//        pc.getChampByName("escalelib").setLien((String) session.getValue("lien") + "?but=capitainerie/quais/quais-prevision-fiche.jsp&id="+mouvementVise.getEscale(), "escale=");
        pc.getChampByName("navire").setVisible(false);
        pc.getChampByName("consignataire").setVisible(false);
        pc.getChampByName("daty").setVisible(false);
        pc.getChampByName("provenance").setVisible(false);
        pc.getChampByName("destination").setVisible(false);
        pc.getChampByName("valconsignataire").setVisible(false);
        pc.getChampByName("referencenavire").setVisible(false);
        pc.getChampByName("pavillonnavire").setVisible(false);
        pc.getChampByName("jntnavire").setVisible(false);
        pc.getChampByName("jbtnavire").setVisible(false);
        pc.getChampByName("pltnavire").setVisible(false);
        pc.getChampByName("lhtnavire").setVisible(false);
        pc.getChampByName("lmnavire").setVisible(false);
        pc.getChampByName("tenavire").setVisible(false);
        pc.getChampByName("volumenavire").setVisible(false);
        pc.getChampByName("remarquenavire").setVisible(false);
        pc.getChampByName("interneprovenance").setVisible(false);
        pc.getChampByName("longueurprovenance").setVisible(false);
        pc.getChampByName("profondeurprovenance").setVisible(false);
        pc.getChampByName("tirantprovenance").setVisible(false);
        pc.getChampByName("internedestination").setVisible(false);
        pc.getChampByName("longueurdestination").setVisible(false);
        pc.getChampByName("profondeurdestination").setVisible(false);
        pc.getChampByName("tirantdestination").setVisible(false);
        pc.getChampByName("cargaison").setVisible(false);
        pc.getChampByName("datearrivee").setLibelle("Date d'arriv&eacute;e");
        pc.getChampByName("typemvt").setVisible(false);
        pc.getChampByName("desceconsignataire").setLibelle("Consignataire");
        pc.getChampByName("nomnavire").setLibelle("Navire");
        pc.getChampByName("quaiprovenance").setVisible(false);
        pc.getChampByName("valpaysprovenance").setLibelle("Pays provenance");
        pc.getChampByName("descepaysprovenance").setVisible(false);
        pc.getChampByName("typequaisprovenance").setVisible(false);
        pc.getChampByName("paysprovenance").setVisible(false);
        pc.getChampByName("paysdestination").setVisible(false);
        pc.getChampByName("date_depart").setLibelle("Date de d&eacute;part");
        pc.getChampByName("heure_depart").setLibelle("Heure de d&eacute;part");
        pc.getChampByName("duree").setLibelle("Dur&eacute;e (en j)");
        pc.getChampByName("descemvt").setVisible(false);
        pc.getChampByName("descecargaison").setVisible(false);
        pc.getChampByName("valcargaison").setLibelle("Cargaison");
        pc.getChampByName("descequaisprovenance").setVisible(false);
        pc.getChampByName("valquaisprovenance").setLibelle("Quais provenance");
        pc.getChampByName("quaisdestination").setVisible(false);
        pc.getChampByName("valquaisdestination").setLibelle("Quais destination");
        pc.getChampByName("descequaisdestination").setVisible(false);
        pc.getChampByName("typequaisdestianantion").setVisible(false);
        pc.getChampByName("valpaysdestination").setLibelle("Pays destination");
        pc.getChampByName("descepaysdestination").setVisible(false);
        pc.getChampByName("valtypequaisdestination").setLibelle("Type de quais destination");
        pc.getChampByName("valtypequaisdestination").setVisible(false);
        pc.getChampByName("descetypequaisdestination").setVisible(false);
        pc.getChampByName("valtypequaisprovenance").setLibelle("Type de quais provenance");
        pc.getChampByName("valtypequaisprovenance").setVisible(false);
        pc.getChampByName("descetypequaisprovenance").setVisible(false);
        pc.getChampByName("etatnavire").setVisible(false);
        pc.getChampByName("valmvt").setLibelle("Type de mouvement");
        pc.getChampByName("Etatlib").setVisible(false);
        pc.getChampByName("escale").setLibelle("Prévision");
        pc.getChampByName("noVoyage").setLibelle("No voyage");
        pc.getChampByName("escale").setLien((String) session.getValue("lien") + "?but=capitainerie/quais/quais-prevision-fiche.jsp&tab=liste-mouvement", "id=");
        
        
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "mouvement";

        
        id=mouvementVise.getId();
        MouvementLibComplet mouvementLibelleComplet = new MouvementLibComplet();

        String[] champ = {"id", "escale", "valpaysprovenance", "valquaisprovenance", "valpaysdestination", "valquaisdestination", "datearrivee", "date_depart", "navire", "consignataire", "heure", "provenance", "destination", "remarque", "typemvt", "valconsignataire", "desceconsignataire", "referencenavire", "nomnavire", "pavillonnavire", "remarquenavire", "quaiprovenance", "interneprovenance", "paysprovenance", "internedestination", "paysdestination", "cargaison", "heure_depart", "daty", "datearrivee", "date_depart", "duree", "jntnavire", "jbtnavire", "pltnavire", "lhtnavire", "lmnavire", "tenavire", "volumenavire", "longueurdestination", "profondeurdestination", "tirantdestination", "longueurprovenance", "profondeurprovenance", "tirantprovenance"};
        String[] libelle_comp = {"Id", "Escale", "Pays provenance", "Quais provenance", "Pays destination", "Quais destination", "Date arrivee", "Date d&eacute;part", "Navire", "Consignataire", "Heure", "Provenance", "Destination", "Remarque", "Type mvt", "Consignataire", "Consignataire", "Reference navire", "Navire", "Pavillon navire", "Remarque navire", "Quai provenance", "Interne provenance", "Pays provenance", "Interne destination", "Pays destination", "cargaison", "Heure d&eacute;part", "Date", "Date arrivee", "Date d&eacute;part", "Duree", "JNT", "JBT", "PLT", "LHT", "LM", "TE", "Volume", "Long. quai dest.", "Prof. quai dest.", "Tirant", "Long. quai prov.", "Prof. quai prov.", "Tirant"};

        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id", "escale", "nomnavire", "valconsignataire", "valpaysprovenance", "valquaisprovenance", "valpaysdestination", "valquaisdestination", "datearrivee", "heure", "date_depart", "heure_depart"};
        PageRecherche pr = new PageRecherche(mouvementLibelleComplet, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("capitainerie/mouvement-fiche.jsp");
        pr.setAWhere(" and escale ='" + mouvementVise.getEscale() + "'");
        String colSomme[] = null;
        pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><!--<a href="<%=(String) session.getValue("lien")%>?but=mouvement/mouvement-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a>--> Fiche mouvement</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="pull-right">
                            <p>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=capitainerie/mouvement-fiche.jsp&classe=mg.spat.Mouvement" style="margin-right: 10px">Viser</a>
                                <a href="<%=(String) session.getValue("lien") + "?but=capitainerie/mouvement-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px"><button class="btn btn-warning">Modifier</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=capitainerie/mouvement-liste.jsp&classe=mg.spat.Mouvement" style="margin-right: 10px"><button class="btn btn-danger">Supprimer</button></a>
                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=capitainerie/mouvement-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a> 
                                <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/mouvement-saisie.jsp&typemvt=" + Constante.tpmvtarrive + "&id=" + request.getParameter("id")%>" style="margin-right: 10px">Arrivee</a>
                                <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/mouvement-saisie.jsp&typemvt=" + Constante.tpmvtdepart + "&id=" + request.getParameter("id")%>" style="margin-right: 10px">Depart</a>
                                <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=capitainerie/occupationMaterielNaval-saisie.jsp&idmvt=" + id %>" style="margin-right: 10px">Saisir Prestation</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Onglets -->
    <div class="row">
        <div class="col-md-12">
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs nav-center">
                <li class="<%= map.get("liste-mouvement")%>"><a href="module.jsp?but=capitainerie/mouvement-fiche.jsp&id=<%=id%>&tab=liste-mouvement">Liste des mouvements</a></li>
                <li class="<%= map.get("liste-utilisation-materiels")%>"><a href="module.jsp?but=capitainerie/mouvement-fiche.jsp&id=<%=id%>&idarrivee=<%=id%>&tab=liste-utilisation-materiels">Liste des prestations</a></li>
            </ul>
            <div class="tab-content">       
                <jsp:include page="<%=tab%>" />  
            </div>
        </div>
        </div>
    </div>    
    <div class="row">
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

