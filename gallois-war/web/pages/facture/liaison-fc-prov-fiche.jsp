<%-- 
    Document   : factureclient-fiche.jsp
    Created on : 14 janv. 2021, 15:37:16
    Author     : nyamp
--%>
<%@page import="mg.spat.FcDefPr"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    FcDefPr facture = new FcDefPr();
    facture.setNomTable("FcDefPr");
    PageConsulte pc = new PageConsulte(facture, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("FICHE LIAISON PROV FACTURE DEF");
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("id1").setLibelle("Facture d&eacute;finitive");
    pc.getChampByName("id1").setLien((String) session.getValue("lien") + "?but=facture/factureclient-fiche-vaovao.jsp", "id=");
    pc.getChampByName("id2").setLibelle("Facture de provision");
    pc.getChampByName("id2").setLien((String) session.getValue("lien") + "?but=facture/factureclient-fiche-vaovao.jsp", "id=");
    pc.getChampByName("etat").setVisible(true);
    
    facture=(FcDefPr)pc.getBase();
    String id=facture.getId();
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/journalcaisse-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a>FICHE Liaison FD et Provision</h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="pull-right">
                        <p>
                            <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=mg.spat.FcDefPr&bute=facture/liaison-fc-prov-fiche.jsp&id="+id %>"  style="margin-right: 10px">Viser</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
                           
    </div>
                              
</div> 
        
         