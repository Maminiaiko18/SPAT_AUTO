<%-- 
    Document   : placement-banquecaisse-fiche
    Created on : 26 janv. 2024, 13:49:32
    Author     : Valiah Karen
--%>

<%@page import="mg.spat.placement.PlacementBanqueCaisse"%>
<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    PlacementBanqueCaisse plb=new PlacementBanqueCaisse();
    plb.setNomTable("PLACEMENT_BANQUE_CAISSELIB");
    
    PageConsulte pc = pc = new PageConsulte(plb, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche liaison caisse et banque");
    pc.getChampByName("Id").setLibelle("Identifiant");
    pc.getChampByName("val").setVisible(false);
    pc.getChampByName("desce").setVisible(false);
    pc.getChampByName("banquelib").setLibelle("Banque");
    pc.getChampByName("caisselib").setLibelle("Caisse");
 //   AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="liaisonplacement";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=placement/placement-banquecaisse-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=placement/placement-banquecaisse-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=placement/placement-banquecaisse-liste.jsp&classe=mg.spat.placement.PlacementBanqueCaisse"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
                                   
    </div>
</div>