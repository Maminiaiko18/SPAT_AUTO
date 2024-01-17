
<%@page import="mg.spat.Avenant"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try{
        Avenant c = new Avenant();
        c.setNomTable("AVENANTLIBCPLT");
        PageConsulte pc = new PageConsulte(c, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.setTitre("Fiche Avenant");
        pc.getChampByName("id").setVisible(false);
        pc.getChampByName("idTiers").setVisible(false);
        pc.getChampByName("pipeline").setVisible(false);
        pc.getChampByName("typeDuree").setVisible(false);
        pc.getChampByName("Typedroitport").setVisible(false);
        pc.getChampByName("etatlib").setVisible(false);
        pc.getChampByName("droit_entree").setVisible(false);
        pc.getChampByName("devise").setVisible(false);
        pc.getChampByName("redevance_variable").setVisible(false);
        pc.getChampByName("redevance_fixe").setVisible(false);
        pc.getChampByName("redevance_domaniale").setVisible(false);
        pc.getChampByName("redevance_locative").setVisible(false);
        pc.getChampByName("droit_port").setVisible(false);
        pc.getChampByName("unite").setVisible(false);
        pc.getChampByName("idContrat").setVisible(false);
        pc.getChampByName("idengagement").setVisible(false);
        pc.getChampByName("rang").setVisible(false);

        pc.getChampByName("date_signature").setLibelle("Date de signature");
        pc.getChampByName("objet").setLibelle("Objet");
        pc.getChampByName("debut_avenant").setLibelle("Date d&eacute;but");
        pc.getChampByName("fin_avenant").setLibelle("Date fin");
        pc.getChampByName("duree").setLibelle("Dur&eacute;e");
        pc.getChampByName("unitelib").setVisible(false);
        pc.getChampByName("montant").setLibelle("Montant");
        pc.getChampByName("contratlib").setLibelle("Contrat");
        pc.getChampByName("tierslib").setLibelle("Tiers");
        pc.getChampByName("designationengagement").setVisible(false);

        c = (Avenant) pc.getBase();
        pc.getChampByName("contratlib").setLien((String) session.getValue("lien") + "?but=travaux/contrat-fiche-nouveau.jsp","id="+ c.getIdContrat()+"&id=");
        pc.getChampByName("designationengagement").setLien((String) session.getValue("lien") + "?but=depense/engagement-fiche.jsp","id="+ c.getIdengagement()+"&id=");
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "travaux";

        Avenant cVise = (Avenant) pc.getBase();

        /*Onglets*/
        String id = cVise.getId();
    
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
                        <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + cVise.getId()%>&acte=valider&bute=travaux/avenant-fiche.jsp&id=<%=cVise.getId()%>&classe=mg.spat.Avenant" style="margin-right: 10px">Viser</a>
                        <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/avenant-modif.jsp&id=" + cVise.getId()%>" style="margin-right: 10px">Modifier</a>
                    </div>
                    <br/>

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
