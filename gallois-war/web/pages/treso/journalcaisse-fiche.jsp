<%-- 
    Document   : caisse-fiche
    Created on : 6 nov. 2019, 10:03:14
    Author     : Tin
--%>


<%@page import="mg.spat.JournalCaisseLibComplet"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
    String id = request.getParameter("id");
    JournalCaisseLibComplet jc = new JournalCaisseLibComplet();
    jc.setNomTable("JOURNALCAISSELIBCOMPLET");
    PageConsulte pc = new PageConsulte(jc, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche Journal de Caisse");
    pc.getChampByName("dateSaisie").setLibelle("Date de Saisie");
    pc.getChampByName("idbanque").setVisible(false); 
    pc.getChampByName("idbanque").setVisible(false);
    pc.getChampByName("caisse").setVisible(false);
    pc.getChampByName("idcaisse").setVisible(false);
    pc.getChampByName("idmode").setVisible(false);
    pc.getChampByName("idTypeCheque").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    
    pc.getChampByName("credit").setLibelle("Entree");
    pc.getChampByName("debit").setLibelle("Sortie");
    pc.getChampByName("dateEffet").setLibelle("Date D'effet");
    pc.getChampByName("numPiece").setLibelle("Num&eacute;ro pi&egrave;ce");
    pc.getChampByName("idTypeCheque").setLibelle("Type ch&egrave;que");
    pc.getChampByName("idplacement").setLibelle("Source");
    pc.getChampByName("idbanquelib").setLibelle("Banque");
     pc.getChampByName("valTypeCheque").setLibelle("Type chèque");
     pc.getChampByName("tierslib").setLibelle("tiers");
    pc.getChampByName("idDevise").setLibelle("devise");
    pc.getChampByName("valCaisse").setLibelle("caisse");
    pc.getChampByName("DESCETYPECHEQUE").setLibelle("mode de paiement");
    pc.getChampByName("idordre").setLibelle("OP");
    pc.getChampByName("typelib").setLibelle("Type"); 
    
    JournalCaisse jcaisse = (JournalCaisse)pc.getBase();
    if(jcaisse.getIdplacement()!=null){
        if(jcaisse.getIdplacement().startsWith("FCL")){
            pc.getChampByName("idplacement").setLien((String) session.getValue("lien") + "?but=facture/factureclient-fiche-vaovao.jsp", "id=");
        }
        else if(jcaisse.getIdplacement().startsWith("FAF")){
            pc.getChampByName("idplacement").setLien((String) session.getValue("lien") + "?but=facture/facture-fournisseur-fiche-vaovao.jsp", "id=");
        }
    }

    pc.getChampByName("idordre").setLibelle("Ordre");
    pc.getChampByName("idordre").setLien((String) session.getValue("lien") + "?but=ded/ordonnerpayement-fiche.jsp", "id=");
    
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier = "journal";
//    Caisse[] caisse = (Caisse[])CGenUtil.rechercher(new Caisse(), null, null,null, " and val like '"+jcaisse.getValCaisse()+"'");
    
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","folio","caisse","numPiece","libelle","remarque", "dateSaisie","dateEffet", "debit","credit"};
    PageRecherche pr = new PageRecherche(jc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("treso/journalcaisse-fiche.jsp");
  
    String colSomme[] = null;
    pr.creerObjetPage(libEntete, colSomme);
    
    HashMap<String, String> map = new HashMap<String, String>();
    map.put("ventilation-ff", "");
    map.put("ventilation-fc", "");
    
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "ventilation-fc";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
    String bute = "treso/journalcaisse-fiche.jsp";
    JournalCaisseLibComplet base = (JournalCaisseLibComplet)pc.getBase();

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/journalcaisse-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche Journal de Caisse</h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
                    <br/>
                    <div class="pull-right">
                        <p>
                            <%if(jcaisse.getEtat() != ConstanteEtat.getEtatValider()){%>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id %>&acte=valider&bute=treso/journalcaisse-fiche.jsp&classe=mg.spat.JournalCaisse">Viser</a>
                            <%}%>
                            <%                                
                            if(jcaisse.getCredit()!=0){
                            %>
                                <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=pieceDeCaiseRecette&idFacture=<%=jcaisse.getIdplacement()%>&id=<%=id%>" style="margin-right: 10px">imprimer pièce de caisse</a>
                            <%
                            }
                            else if(jcaisse.getDebit()!=0){
                            %>
                                <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=pieceDeCaiseDepense&idop=<%=jcaisse.getIdordre()%>&id=<%=id%>" style="margin-right: 10px">imprimer pièce de caisse</a>
                            <%
                            }
                            %>
                            <a href="<%=(String) session.getValue("lien") + "?but=treso/journalcaisse-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                            <a href="<%=(String) session.getValue("lien") + "?but=treso/paiementfacture-saisie.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-success">Attacher FC</button></a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=treso/journalcaisse-liste.jsp&classe=mg.spat.JournalCaisse" style="margin-right: 5px"><button class="btn btn-danger" >Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/journalcaisse-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=facture/fctraite-multiple.jsp&id=" + id+"&colonneMere=idJc&bute=treso/journalcaisse-fiche.jsp" %>" style="margin-right: 10px">Attacher Traite</a>
                            <!--<a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/cloture-saisie.jsp&caisse="%>" style="margin-right: 10px">cloture</a>--> 
                        </p>
                    </div>
                </div>
            </div>
        </div>
                        
        <div class="row">
        <div class="col-md-10 col-md-offset-1 ">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs nav-center">
                    <li class="<%= map.get("ventilation-fc")%>"><a href="module.jsp?but=<%=bute%>&id=<%=base.getId()%>&tab=ventilation-fc">Ventilation FC</a></li>
                    <li class="<%= map.get("ventilation-ff")%>"><a href="module.jsp?but=<%=bute%>&id=<%=base.getId()%>&tab=ventilation-ff">Ventilation FF</a></li>
                    
                </ul>
                <div class="tab-content">       

                    <div class="tab-content">       
                        <jsp:include page="<%=tab%>" >
                            <jsp:param name="idmvt" value="<%=base.getId()%>" />
                        </jsp:include>
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
<% } catch(Exception ex) {
        ex.printStackTrace();
}%>
                            

