<%-- 
    Document   : facture-client-fiche
    Created on : 5 oct. 2017, 16:20:14
    Author     : BillySycher
--%>

<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@ page import="factureclient.PaiementFactureRemise" %>
<%@ page import="factureclient.FactureClientDetail" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        PaiementFactureRemise res;
        String idFacture = request.getParameter("id");
        UserEJB u = (UserEJB) session.getAttribute("u");
        res = new PaiementFactureRemise();
        res.setNomTable("PAIEMENT_FACTURECLIENT_REMISE");
        String[] libellePaiementFiche = {"id", "Date","tiers", "Designation","type", "tva","Etat","Devise" ,"compte","Consultation","cours devise", "Montant","Montant TVA", "Avoir", "Montant total","Montant payer","Reste à payer","Remise","Reste avoir"};
        PageConsulte pc = new PageConsulte(res, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pc.getChampByName("typee").setVisible(false);
        pc.getChampByName("tva").setVisible(false);
        pc.getChampByName("devise").setVisible(false);
        pc.getChampByName("compte").setVisible(false);
        pc.getChampByName("montant").setLibelle("Montant total");
        pc.getChampByName("coursdevise").setVisible(false);
        pc.getChampByName("montanttva").setLibelle("Montant TVA");
        pc.getChampByName("avoir").setLibelle("Montant avoir");
        pc.getChampByName("montanttotal").setVisible(false);
        pc.getChampByName("montantpayer").setLibelle("Montant payé");
        pc.getChampByName("resteapayer").setLibelle("Reste à payer");
        pc.getChampByName("resteavoir").setVisible(false);
        pc.getChampByName("montanttotaleremise").setLibelle("Montant total remise");
        res=(PaiementFactureRemise)pc.getBase();
        idFacture=res.getId();


//        pc.getChampByName("resteavoir").setVisible(false);
//      
        
        pc.setTitre("Fiche Facture Client");
        String lien = (String) session.getValue("lien");
        pc.getChampByName("remarque").setLien((String) session.getValue("lien")+"?but=cms/consultation/consultation-fiche.jsp" , "id=");


        PaiementFactureRemise pf = (PaiementFactureRemise) pc.getBase();
        idFacture = pf.getId();
        
         String redirect = lien + "?but=facture/facture-client-modif.jsp&id=" + idFacture;
        if(pf.getEtat() < ConstanteEtat.getEtatValider()) out.println("<script language='JavaScript'> document.location.replace('"+redirect+"'); </script>");


       
        AttacherFichier[] fichiers = UploadService.getUploadFile(idFacture);
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "factureclient";
        int taille = 1;
//        FactureClientDetailLibelle[] listeFCdetails = data.getListeFCdetails();

        FactureClientDetail listeFCdetail = new FactureClientDetail();
        listeFCdetail.setNomTable("FACTURE_CLIENT_DETAIL");
        String listeCrt[] = {"designation", "idfacture"};
        String listeInt[] = null;
        String libEntete[] = {"id", "designation", "remarque", "quantite", "montant",  "montantT", "montantremise"};
        PageRechercheUpdate pr = new PageRechercheUpdate(listeFCdetail, request, listeCrt, listeInt, 3, libEntete, "id");
        pr.setAWhere(" AND IDFACTURE = '" + idFacture + "'");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/facture-client-fiche.jsp");
        pr.getFormu().getChamp("idfacture").setAutre("readonly");
        String[] colSomme = null;
        pr.setNpp(300);
        pr.creerObjetPage(libEntete, colSomme);
        int nombreLigne = pr.getTableau().getData().length;
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/facture-client-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-default"  href="${pageContext.request.contextPath}/Paie?action=fiche_facture&id=<%=idFacture%>" style="margin-right: 10px">Imprimer Facture </a>                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=facture/facture-client-modif.jsp&id=" + pf.getId()%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=avoir/avoir-saisie.jsp&idfacture=" + pf.getId()+"&designation="+pf.getDesignation()%>&montant=<%= pf.getResteapayer() %>" style="margin-right: 10px">Ajouter Avoir</a>
                            <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + pf.getId()%>&acte=delete&bute=facture/facture-client-liste.jsp&classe=mg.amadia.facture.PayementFacture" style="margin-right: 10px">Supprimer</a>

                            <!--<a style="margin-right : 20px" class="btn btn-success pull-right"  onclick="testVisa()" href="<%=(String) session.getValue("lien") + "?but=remboursement/remboursement-saisie.jsp&idFacture=" + pf.getId()%>" style="margin-right: 10px">Remboursement</a>-->
                            
                            <% if (pf.getEtat() < 11) {%>
                            <form  action="<%=session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="ded_op" id="ded_op">
                                <input name="id" type="hidden" id="id" value="<%=request.getParameter("id")%>">
                                <input name="acte" type="hidden" id="nature" value="valider">
                                <input name="bute" type="hidden" id="bute" value="facture/facture-client-fiche.jsp">
                                <input name="nomtable" type="hidden" id="nomtable" value="facture_client">
                                <input name="classe" type="hidden" id="nomtable" value="factureclient.FactureClient">
                                <input style="margin-right : 20px" class="btn btn-success pull-right"  type="submit" value="Viser"/>

                            </form>
                            <% } else {%>
                                <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") + "?but=ded/ordonnerpayement-saisie.jsp&ded_id=" + pf.getId()%>" style="margin-right: 10px">Payer</a>
                                <a style="margin-right : 20px" class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=annulerVisa&bute=facture/facture-client-fiche.jsp&classe=factureclient.FactureClient" style="margin-right: 10px">Annuler VISA</a>
                            <% }%>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h2 class="box-title" style="margin-left: 10px;">Liste détails facture client</h2>
                    </div>
                    <div class="box-body">
                        <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" id='modif-form' method="post" data-parsley-validate>
                            <%
                                String libEnteteAffiche[] = {"Id", "Designation", "Remarque", "Quantite", "Montant", "Montant total", "Montant remise"};
                                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                                out.println(pr.getTableau().getHtml());
                            %>                            
                            <input name="acte" type="hidden" id="acte" value="updateMultiple">
                            <input name="bute" type="hidden" id="bute" value="facture/facture-client-fiche.jsp&id=<%= idFacture%>">
                            <input name="classe" type="hidden" id="classe" value="factureclient.FactureClientDetail">
                            <input name="nombreLigne" type="hidden" id="nomtable" value="<%=nombreLigne%>">                        
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!--ajout attacher fichier -->
        <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="">
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
                            <td colspan="5" style="text-align: center;"><strong>Aucun fichier</strong></td>
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
    <!--fin ajout attache fihier--> 
</div>
<script>
    function addLine() {
    <% taille++;%>
        var content = '<div class="form-group">'
                + '<div class="col-xs-7" style="margin-right: -15px;">'
                + '<input type="text" name="libelle<%=taille%>" class="form-control" multiple="true">'
                + '</div>'
                + '<div class="col-xs-5" style="margin-left: -15px;">'
                + '<div class="input-group">'
                + '<input type="file" name="fichiers<%=taille%>" class="form-control" multiple="true">'
                + '<div class="input-group-addon" onclick="removeLine(this)"><i class="fa fa-remove"></i></div>'
                + '</div>'
                + '</div>'
                + '</div>';
        $('#uploadapj').append(content);

    }
    function removeLine(obj) {
        $(obj).parent().parent().parent().remove();
    <% taille--;%>
    }
</script>
<script>
    $(function () {
        $("#suppression").click(function () {
            var confirmation = confirm("Etes-vous sure de vouloir supprimer le facture?");
            if (confirmation) {
                var lien = "<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=facture/facture-client-liste.jsp&classe=factureclient.FactureClient";
                window.location.href = lien;
            }
        });
    });

</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>