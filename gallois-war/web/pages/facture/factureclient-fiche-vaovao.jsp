<%-- 
    Document   : factureclient-fiche-vaovao
    Created on : 12 mai 2021, 13:56:24
    Author     : nyamp
--%>

<%@page import="utilitaire.Constante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="facture.FactureClient"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    FactureClient e = new FactureClient();
    e.setNomTable("facture_client_union");
    PageConsulte pc = new PageConsulte(e, request, u);
    pc.setTitre("FICHE FACTURE CLIENT");
    
    pc.getChampByName("iduser").setVisible(false);
    pc.getChampByName("type").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("etatlib").setVisible(false);
    pc.getChampByName("Idcategorie").setVisible(false);
    pc.getChampByName("IdProvision").setVisible(false);
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("montant").setLibelle("Montant HT");
    pc.getChampByName("montanttva").setLibelle("Montant TVA");
    pc.getChampByName("montantavoir").setLibelle("Montant Avoir");
    pc.getChampByName("montantttc").setLibelle("Montant TTC");
    pc.getChampByName("date_echeance").setLibelle("Date echeance");
    pc.getChampByName("montantpaye").setLibelle("Montant payé");
    pc.getChampByName("montantreste").setLibelle("Reste à payer");
    pc.getChampByName("typelib").setLibelle("Type");
    pc.getChampByName("escale").setLibelle("Escale");
    pc.getChampByName("idProvisionlib").setLibelle("Provision");
    e = (FactureClient) pc.getBase();
    pc.getChampByName("idProvisionlib").setLien((String) session.getValue("lien") + "?but=facture/facture-client-fiche.jsp&id="+e.getIdProvision(), "idProvisionlib=");
    String categorie="";
    if(e.getIdcategorie()!=null){
        categorie=e.getIdcategorie();
    }
    if(categorie.equals(Constante.idCategorieFCDefinitive)){ 
         pc.setTitre("Fiche Facture client");
    }
    else if(categorie.equals(Constante.idCategorieFCProforma)){ 
         pc.setTitre("Fiche Facture Proforma");
    }
    else if(categorie.equals(Constante.idCategorieFCProvision)){ 
         pc.setTitre("Fiche Facture de provision");
    }
    pc.getChampByName("categorielib").setLibelle("Categorie");
       
//
//Si categorieFC = proforma alors “Fiche Facture Proforma”
//
//Si categorieFC = provision alors “Fiche Facture de provision”
    pc.getChampByName("escale").setLien((String) session.getValue("lien") + "?but=capitainerie/quais/quais-prevision-fiche.jsp&id="+e.getIdprevision(), "escale=");
    String bute="facture/factureclient-fiche-vaovao.jsp";
    String classe="facture.FactureClient";
    String classefille="facture.FactureClientDetails";
    String modifPage="facture/factureclient-modif.jsp";
    
    String lien = (String) session.getValue("lien");
    String redirect = lien + "?but="+modifPage+"&id=" + request.getParameter("id");
    //if(e.getEtat() < ConstanteEtat.getEtatValider()) out.println("<script language='JavaScript'> document.location.replace('"+redirect+"'); </script>");
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="facture";
    String id= e.getId();
    
    Map<String, String> map = new HashMap<String, String>();
    map.put("facture-client-fille", "");
    map.put("avoir-liste", "");
    map.put("bondelivraison", "");
    map.put("paiement", "");
    map.put("activite", "");
    map.put("groupedetail", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "facture-client-fille";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
    
    //String vue = e.getId().startsWith(Constante.fcPrefix) ? "ANALYSEGLOBALEFACTURE_VAOVAO" : "ANALYSEGLOBALEANTSIKA";
    String vue =e.getRemarque()!=null&&e.getRemarque().startsWith("--") ? "ANALYSEGLOBALEFACTURE_VAOVAO" : "ANALYSEGLOBALEANTSIKA";
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-7 col-md-offset-2">

            <div class="box">
                <h1 class="box-title">
                    <a href="#">
                        <i class="fa fa-arrow-circle-left"></i>
                    </a> <%=pc.getTitre()%> 
                </h1>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                </div>
                <div class="box-footer">
                    <p>
                        <a class="btn btn-default"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=dupliquer&bute=<%=bute%>&classe=<%=classe%>&nomClasseFille=<%=classefille%>&nomColonneMere=idmere" style="margin-right: 10px">Dupliquer</a>
                        <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=facture/recurrent.jsp&id=" + e.getId() %>" style="margin-right: 10px">Récurrent</a>
                        <a class="btn btn-default"  href="<%=(String) session.getValue("lien") + "?but=avoir/avoirFC-saisie.jsp&idfacture=" + e.getId() %>" style="margin-right: 10px">Ajouter Avoir</a>
                        <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=facture/bondelivraison-client-saisie.jsp&idfacture=" + e.getId() %>" style="margin-right: 10px">Livrer</a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/recette-saisie.jsp&idFacture="+id +"&vue=" + vue%>" style="margin-right: 10px">Entrée banque</a>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/journalcaisse-saisie.jsp&idFacture="+id +"&vue=" + vue %>" style="margin-right: 10px">Entrée caisse</a>
                    </p>
                    <hr>
                    <p>
                        <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerFactureClient&id=<%=id%>" style="margin-right: 10px">Imprimer</a>
                        <a class="btn btn-info"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + e.getId() + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute="   +bute+"&id=" + e.getId() %>" style="margin-right: 10px">Attacher Fichier</a> 
                        <a class="btn btn-warning"  href="<%=(String) session.getValue("lien") + "?but="+modifPage+"&id=" + e.getId() %>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-success"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=valider&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Viser</a>
                        <a class="btn btn-danger"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + e.getId() %>&acte=annulerVisa&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Annuler visa</a>
                        <%
                            if(e.getType()!=null &&  e.getType().equals(Constante.idprovision)){%>
                            <a class="btn btn-primary"  href="<%=(String) session.getValue("lien") + "?but=apresFacture.jsp&id=" + e.getId() %>&acte=genererDefinitive&bute=<%=bute%>&classe=<%=classe%>" style="margin-right: 10px">Générer facture définitive</a>

                            <%}
                        %>
                    </p>
                    <hr>
                </div>
            </div>
        </div>
    </div>
                    
    <!--    detail      -->
    
    
        <div class="row">
            <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("facture-client-fille")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=facture-client-fille&idmere=<%=e.getId()%>">Detail facture client</a></li>
                    <li class="<%= map.get("avoir-liste")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&idfacture=<%=e.getId()%>&tab=avoir-liste">Facture avoir</a></li>
                    <li class="<%= map.get("bondelivraison")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=bondelivraison">Bon de livraison</a></li>
                    <li class="<%= map.get("paiement")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=paiement">Paiement</a></li>
                    <li class="<%= map.get("activite")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=activite">Activit&eacute;s</a></li>
                    <li class="<%= map.get("groupedetail")%>"><a href="module.jsp?but=<%=bute%>&id=<%=e.getId()%>&tab=groupedetail">Grouper d&eacute;stails</a></li>
                </ul>
                <div class="tab-content">       
                <div class="tab-content">       
                    <jsp:include page="<%=tab%>" >
                        <jsp:param name="idmere" value="<%=e.getId()%>" />
                        <jsp:param name="idbc" value="<%=e.getId()%>" />
                        <jsp:param name="idplacement" value="<%=e.getId()%>" />
                        <jsp:param name="idfacture" value="<%=e.getId()%>" />
                    </jsp:include>
                </div>
            </div>
            </div>
        </div>  
                
    <!--    fin detail      -->
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
                              <%if(fichiers==null || fichiers.length==0){%>
                              <tr>
                                   <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                               </tr>
                             <%} else{
                                   for(AttacherFichier fichier : fichiers){%> 
                               <tr class="treegrid-1 treegrid-expanded">
                                   <td><span class="treegrid-expander glyphicon glyphicon-minus"></span></td>
                                   <td><%=fichier.getChemin() %></td>
                                   <td><%=Utilitaire.champNull(fichier.getLibelle())%></td>
                                   <td><a href="#" class="btn btn-primary" onclick="javascript:pagePopUp('<%=cdn + dossier +"/"+ fichier.getChemin()%>')">Voir</a></td>
                                   <td></td>
                               </tr>
                               <%}}%>
                        </tbody>  
                   </table>
               </div>
           </div>
       </div>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

