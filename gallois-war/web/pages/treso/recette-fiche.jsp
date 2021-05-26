
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.compta.JournalBanque"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    JournalCaisse journal = new JournalCaisse();
    journal.setNomTable("JOURNALCAISSELIBCOMPLET");
    PageConsulte pc = new PageConsulte(journal, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("Datesaisie").setLibelle("Date de saisie");
    pc.getChampByName("Dateeffet").setLibelle("Date d'effet");
    //pc.getChampByName("caisse").setLibelle("Banque");

    pc.getChampByName("Numpiece").setLibelle("Numéro de pièce");
    /*if(request.getParameter("type") != null && request.getParameter("type").equals("debit")){
        pc.getChampByName("credit").setVisible(false);
        pc.getChampByName("debit").setLibelle("Montant");
    }else if(request.getParameter("type") != null && request.getParameter("type").equals("credit")){
        pc.getChampByName("debit").setVisible(false);
        pc.getChampByName("credit").setLibelle("Montant");
    }*/
    pc.getChampByName("valTypeCheque").setLibelle("Type chèque");
    pc.getChampByName("typemvt").setLibelle("type mouvement");
    pc.getChampByName("credit").setLibelle("Sortie");
    pc.getChampByName("credit").setLibelle("Entree");
    pc.getChampByName("debit").setLibelle("Sortie");
    pc.getChampByName("caisse").setVisible(false);
    pc.getChampByName("idmode").setVisible(false);
    pc.getChampByName("idTypeCheque").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    pc.getChampByName("tierslib").setLibelle("tiers");
    pc.getChampByName("idDevise").setLibelle("devise");
    pc.getChampByName("valCaisse").setLibelle("caisse");
    pc.getChampByName("DESCETYPECHEQUE").setLibelle("mode de paiement");
    pc.getChampByName("idordre").setLibelle("OP");
    pc.getChampByName("idplacement ").setLibelle("Source");
    
    pc.setTitre("Fiche journal");
    pc.getChampByName("id").setVisible(false);
    //private String id, folio, caisse, numPiece, libelle, remarque, tiers, idTypeCheque, idplacement,valCaisse,valTypeCheque,tiersLib;
    //private String designation, iddevise, idmode, numcheque, typemvt, idordre;
    //private Date dateSaisie, dateEffet;
//    private double debit, credit, montant;

    String[] ord={"Datesaisie","Dateeffet","libelle","tierslib","debit","credit","iddevise","valCaisse","DESCETYPECHEQUE","ValTypeCheque","numCheque"};
    pc.setOrdre(ord);
    AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
    configuration.CynthiaConf.load();
    String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
    String dossier="banque";
    
    JournalCaisse sVise = (JournalCaisse) pc.getBase();
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=treso/recette-fiche.jsp&type=<%=request.getParameter("type")%>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=treso/recette-modif.jsp&id=" + request.getParameter("id") + "&type="+request.getParameter("type")%>" style="margin-right: 10px">Modifier</a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=treso/recette-liste.jsp?type=<%=request.getParameter("type")%>&classe=mg.spat.JournalCaisse"><button class="btn btn-danger">Supprimer</button></a>
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier="+dossier+"&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=treso/recette-fiche.jsp&type="+request.getParameter("type")%>" style="margin-right: 10px">Attacher Fichier</a>              
                            <%if (sVise.getEtat() != ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=treso/recette-fiche.jsp?type=<%=request.getParameter("type")%>&classe=mg.spat.JournalCaisse" style="margin-right: 10px">Viser</a>
                            <%}%>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=treso/cloture-saisie.jsp&caisse=" + sVise.getCaisse() %>" style="margin-right: 10px">cloturer</a> 
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


