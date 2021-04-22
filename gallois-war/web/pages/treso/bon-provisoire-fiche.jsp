<%-- 
    Document   : bon-provisoire
    Created on : 30 nov. 2019, 14:55:20
    Author     : Tin
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.BonProvisoireData"%>
<%@page import="mg.spat.RegulBonProvisoire"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.BonProvisoireComplet"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    BonProvisoireComplet bp = new BonProvisoireComplet();
    PageConsulte pc = new PageConsulte(bp, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

    pc.setTitre("Fiche Bon Provisoire");
    pc.getChampByName("id").setVisible(false);

    pc.getChampByName("datesaisie").setLibelle("date saisie");
    pc.getChampByName("dateeffet").setLibelle("date effet");
    pc.getChampByName("caisse").setVisible(false);
    pc.getChampByName("credit").setVisible(false);
    pc.getChampByName("descecaisse").setVisible(false);
    pc.getChampByName("beneficiaire").setVisible(false);
    pc.getChampByName("debit").setLibelle("Montant");
    pc.getChampByName("beneficiairelib").setLibelle("Bénéficiaire");
    pc.getChampByName("valcaisse").setLibelle("Caisse de retrait");
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="treso";
    
    BonProvisoireComplet bonprovisoireVise = (BonProvisoireComplet) pc.getBase();
    BonProvisoireData data=new BonProvisoireData(bonprovisoireVise);
    RegulBonProvisoire[] listeReg=data.getListeRegul();
    RegulBonProvisoire[] listeRet=data.getListeRetour();
    
        BonProvisoireComplet base = (BonProvisoireComplet) pc.getBase();

        /*Onglets*/
        String tab = null;
        Map<String, String> map = new HashMap<String, String>();
        map.put("facture-fournisseur-liste", "");
        map.put("regularisation", "");

        String id = request.getParameter("id");
        tab = request.getParameter("tab");
        if (tab == null) {
            tab = "facture-fournisseur-liste";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerBon&id=<%=base.getId()%>" style="margin-right: 10px">Imprimer Bon</a>
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=treso/bon-provisoire-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=treso/bon-provisoire-liste.jsp&classe=mg.spat.BonProvisoire"><button class="btn btn-danger">Supprimer</button></a>
                            
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/regulBP-saisie.jsp&idbon="+bonprovisoireVise.getId()+"&action=regule"%>" style="margin-right: 10px">Régulariser</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=treso/bon-provisoire-fiche.jsp&classe=mg.spat.BonProvisoire" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/bon-provisoire-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="margin:0;">
        <div class="col-md-12">       

            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%= map.get("facture-fournisseur-liste")%>"><a href="globalnegoce.jsp?but=treso/bon-provisoire-fiche.jsp&id=<%=request.getParameter("id")%>&tab=facture-fournisseur-liste">Facture fournisseur</a></li>
                    <li class="<%= map.get("regularisation")%>"><a href="globalnegoce.jsp?but=treso/bon-provisoire-fiche.jsp&id=<%=request.getParameter("id")%>&tab=regularisation">Régularisation </a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%=tab%>">
                        <jsp:param name="id" value="<%=base.getId()%>" />
                    </jsp:include>
                </div>
            </div>           

        </div>  
    </div>                
<!--        <div class="col-md-12">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <div class="box-title with-border">
                        <h2 class="box-title" style="margin-left: 10px;">Liste des régularisations</h2>
                    </div>
                    <div class="box-body">
                        <table class="table table-striped table-bordered table-condensed table-responsive tree">
                            <thead>
                                <tr>
                                    <th style="background-color:#bed1dd;">ID</th>
                                    <th style="background-color:#bed1dd;">Date</th>
                                    <th style="background-color:#bed1dd;">Remarque</th>
                                    <th style="background-color:#bed1dd;">Montant</th>
                                </tr>
                            </thead>
                           <tbody>
                               <% for (RegulBonProvisoire regul:listeReg){%>
                                <tr class="treegrid-1 treegrid-expanded">
                                    <td><%=regul.getId() %></td>
                                    <td><%=regul.getDaty() %></td>
                                    <td><%=regul.getRemarque() %></td>
                                    <td><%=regul.getMontant() %></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
        </div> -->
<!--        <div class="col-md-12">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <div class="box-title with-border">
                        <h2 class="box-title" style="margin-left: 10px;">Liste des retours</h2>
                    </div>
                    <div class="box-body">
                        <table class="table table-striped table-bordered table-condensed table-responsive tree">
                            <thead>
                                <tr>
                                    <th style="background-color:#bed1dd;">ID</th>
                                    <th style="background-color:#bed1dd;">Date</th>
                                    <th style="background-color:#bed1dd;">Remarque</th>
                                    <th style="background-color:#bed1dd;">Montant</th>
                                </tr>
                            </thead>
                           <tbody>
                               <% for (RegulBonProvisoire regul:listeRet){%>
                                <tr class="treegrid-1 treegrid-expanded">
                                    <td><%=regul.getId() %></td>
                                    <td><%=regul.getDaty() %></td>
                                    <td><%=regul.getRemarque() %></td>
                                    <td><%=(-1)*regul.getMontant() %></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
        </div> -->
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
</div>

