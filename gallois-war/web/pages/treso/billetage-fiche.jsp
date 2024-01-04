<%-- 
    Document   : caisse-fiche
    Created on : 6 nov. 2019, 10:03:14
    Author     : Tin
--%>


<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.BilletageService"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.Billetage"%>
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
    b.setNomTable("BILLETAGELIBCOMPLET");
    PageConsulte pc = new PageConsulte(b, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche Billetage");
    Billetage bi = (Billetage)pc.getBase();
    pc.getChampByName("idcaisse").setVisible(false);
    pc.getChampByName("idtransfert").setLien((String) session.getValue("lien") + "?but=treso/transfert-caisse-fiche.jsp&id=" + bi.getIdtransfert(), "");
    pc.getChampByName("idtransfert").setLibelle("Transfert");  
    
    JournalCaisseLibComplet jc = new JournalCaisseLibComplet();
    jc.setNomTable("JOURNALCAISSELIBCOMPLET");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","folio","valcaisse","numPiece","libelle","remarque","dateSaisie","dateEffet","debit","credit"};
    PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setAWhere(" and caisse like '%"+bi.getIdcaisse()+"%' and dateEffet = to_date('"+bi.getDaty()+"','YYYY-MM-DD')");
    String bute = "treso/billetage-fiche.jsp";
    pr.setApres(bute);
  
    
    String colSomme[] = null;
    pr.creerObjetPage(libEntete, colSomme);
    
    ArrayList<Object> test=BilletageService.testConformite((JournalCaisse[])pr.getListe(), (Billetage)pc.getBase());
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="billetage";
    
    Map<String, String> map = new HashMap();
    map.put("detailsbilletage","");
    map.put("liste-jc","");
    
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "detailsbilletage";
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
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/billetage-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche Billetage</h1>
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
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=treso/billetage-fiche.jsp&classe=mg.spat.Billetage">Viser</a> 
                                <%} else { %>
                                    <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=imprimerTransfertCaisse&idtransfert=<%=bi.getId()%>&id=<%=bi.getIdtransfert()%>" style="margin-right: 10px">Imprimer</a>
                                <% } %>
                                <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/billetage-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
                                
    <div class="row">
        <div class="col-md-12">
        
            <% if(!(Boolean)test.get(0)){
                if(bi.getEtat()!=11) {%>
            <div class="alert alert-danger" role="alert">
                Attention! Le montant du billetage n'est pas conforme à la somme dans le journal caisse. Montant billetage: <b><%=Utilitaire.formaterAr((Double)test.get(1))%>Ar</b> et Solde journal caisse: <b><%=Utilitaire.formaterAr((Double)test.get(2))%>Ar</b>
            </div>
            <% } }%>
            <section class="content-header">

            </section>

        </div>
    </div> 
                                    
    <div class="row">
        <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("liste-jc")%>"><a href="module.jsp?but=<%=bute%>&id=<%=request.getParameter("id")%>&idcaisse=<%=bi.getIdcaisse()%>&daty=<%=bi.getDaty()%>&tab=liste-jc">Liste journal caisse</a></li>
                    <li class="<%= map.get("detailsbilletage")%>"><a href="module.jsp?but=<%=bute%>&id=<%=request.getParameter("id")%>&tab=detailsbilletage">D&eacute;tails Billetage</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-content">       
                        <jsp:include page="<%=tab%>">
                            <jsp:param name="idmere" value="<%=bi.getId()%>" />


                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>        
    </div>
    
     <div class="row">
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
                                        <th style="background-color:#bed1dd;">Libell�</th>
                                        <th style="background-color:#bed1dd;">Fichier</th>
                                        <th style="background-color:#bed1dd;">Voir</th>
                                        <th style="background-color:#bed1dd;">#</th>
                                    </tr>
                                </thead>
                               <tbody>
                                   <%if(fichiers==null || fichiers.length==0){%>
                                   <tr>
                                        <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
    }
%>