<%-- 
    Document   : caisse-fiche
    Created on : 6 nov. 2019, 10:03:14
    Author     : Tin
--%>


<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.BilletageService"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try{

    Billetage b = new Billetage();
    b.setNomTable("TRANSFERT_BILLET");
    PageConsulte pc = new PageConsulte(b, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche de transfert");
    Billetage bi = (Billetage)pc.getBase();
    pc.getChampByName("idcaisse").setVisible(false);
    pc.getChampByName("idtransfert").setLien((String) session.getValue("lien") + "?but=treso/transfert-caisse-fiche.jsp&id=" + bi.getIdtransfert(), "");
    pc.getChampByName("idtransfert").setLibelle("Transfert");  
    pc.getChampByName("caissedepart").setLibelle("Caisse départ");  
    pc.getChampByName("caisse").setLibelle("Caisse arrivée");  
    
    DetailsBilletage jc = new DetailsBilletage();
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","billet","nombre","montant"};
    PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setAWhere(" and idmere='"+bi.getId()+"'");
    pr.setApres("treso/transfert-principal-fiche.jsp");
  
    
    String colSomme[] = null;
    pr.creerObjetPage(libEntete, colSomme);
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="billetage";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="#"><i class="fa fa-arrow-circle-left"></i></a>Fiche de transfert</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>

                        <div class="pull-right">
                            <p>
                                <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=treso/billetage-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                                <%if (bi.getEtat() != ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=treso/transfert-principal-fiche.jsp&classe=mg.spat.Billetage">Viser</a> 
                                <%} else { %>
                                    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerTransfertCaisse&id=<%=bi.getIdtransfert()%>" style="margin-right: 10px">Imprimer</a>
                                <%} %>
                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/transfert-principal-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
                                
    <div class="row">
        <div class="col-md-12">
        
           
            <section class="content-header">

            </section>
            <section class="content">

                <%
                    String libEnteteAffiche[] ={"id","billets","nombres","montant"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                    String html = pr.getTableau().getHtml();
                    if(html!=null)
                        out.println(html);
                    else{%>
                        <center><h4>Aucun details </h4></center>
                <%      } %>
            </section>  
        </div>
    </div> 
                              
</div> 
        
                            


<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>