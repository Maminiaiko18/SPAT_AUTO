<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="facture.FactureClientFilleData"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="facture.FactureClient"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    FactureClientDetails cht = new FactureClientDetails();
//    cht.setNomTable("facture_client_fille_lib_reste");
    cht.setNomTable("FACT_CLT_FILL_LIB_REST_TAXE");
    //String libEntete[] = {"id", "designation", "pu", "quantite","duree", "devise", "compte", "taux", "montanttaux", "tva", "montantTva", "montantHTEuro", "montantTVAEuro", "activitelib", "heureDebut", "heureFin", "reduction", "majoration"};
    String libEntete[] = {"id", "designation", "pu", "quantite","duree", "devise", "compte", "taux", "montanttaux", "tva", "montantTva", "activitelib","daty", "heureDebut", "heureFin", "reduction", "majoration"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};
    String id= request.getParameter("idmere");
    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"montant"};
    pr.setOrdre(" order by rang asc, daty asc");
    pr.creerObjetPage(libEntete, colSomme);

//    FactureClientDetails[] liste = (FactureClientDetails[]) pr.getTableau().getData();

    /*
    FactureClient fm=(FactureClient) liste[0].findMere(null,null);
    FactureClientDetails[] lcdf=(FactureClientDetails[])fm.getFille(null, null,"");
    FactureClient dfm=(FactureClient)fm.dupliquer(pr.getUtilisateur().getUser().getTuppleID(), null);
     */
    //if(liste == null) liste = new  FactureClientDetails[0]; 
    pr.getTableau().transformerDataString();

    //String libEnteteAffiche[] = {"id", "designation", "pu", "quantité","duree", "devise", "compte", "taux", "montant", "tva", "montant Tva", "HT Euro", "TVA Euro", "Activite", "Heure début", "Heure fin", "RED.%", "MAJ.%"};
    String libEnteteAffiche[] = {"id", "designation", "pu", "quantité","duree", "devise", "compte", "taux", "montant", "tva", "montant Tva", "Activite","Date", "Heure début", "Heure fin", "RED.%", "MAJ.%"};
//    String lienTableau[] = {pr.getLien() + "?but=avoir/avoir-fiche.jsp"};
//    String colonneLien[] = {"id"};
//    pr.getTableau().setLien(lienTableau);
//    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);

    if (pr.getTableau().getHtml() != null) {
        FactureClientFilleData dataF = new FactureClientFilleData(id, null, null);
        FactureClient facture = dataF.getFacture();
        FactureClientDetails[] liste = facture.getListeDetails();

//        out.println(pr.getTableau().getHtml());
//        double total=0;
//        total=AdminGen.calculSommeDouble(liste,"montanttaux");

        double hTEuro = facture.getMontantHTEuro();
        double tvaEuro = facture.getMontantTVAEuro();
        double ttcEuro = facture.getMontantHTEuro() + facture.getMontantTVAEuro();

        double hTDollar = facture.getMontantHTVADollar();
        double tvaDollar = facture.getMontantTVADollar();
        double ttcDollar = facture.getMontantTTCDollar();

        double ttcAr = facture.getMontantttc();
        double htAr = facture.getMontant();
        double tvaAr = facture.getMontanttva();

        double deviseEur = facture.getDeviseEuro();
        double deviseDollar = facture.getDeviseDollar();
        String dateFacture = liste[0].getDatefact() != null ? Utilitaire.datetostring(liste[0].getDatefact()) : Utilitaire.datetostring(facture.getDaty());
%>
<div class="row">
    <div class="row col-md-12">
        <div class="box box-solid">
            <div style="background:#ffb401; color:white;" class="box-header">
                <h3 class="box-title" align="center">LISTE</h3>
            </div>
            <div class="box-body table-responsive no-padding">
                <div id="selectnonee">
                    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
                            <thead>
                                    <tr class="head" style="color:white;">
                                            <th width="15%" align="center" valign="top" style="background-color:#103a8e"></th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">id</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">designation</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">pu</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">quantité</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">duree</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">devise</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">compte</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">taux</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">montant</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">tva</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">montant Tva</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">Activite</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">Date</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">Heure début</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">Heure fin</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">RED.%</th>
                                            <th width="5%" align="center" valign="top" style="background-color:#103a8e">MAJ.%</th>
                                    </tr>
                            </thead>
                            <tbody>
                                    <% for(int i=0;i<liste.length;i++){%>
                                    <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''" style="">
                                        <td width="15%" align="center">
                                            <a href="<%=pr.getLien()%>?but=facture/factureclient-fiche-vaovao.jsp&id=<%=id%>&idFille=<%=Utilitaire.champNull(liste[i].getId())%>&sens=1">
                                                <i class="fa fa-arrow-circle-up"></i>
                                            </a>
                                            <a href="<%=pr.getLien()%>?but=facture/factureclient-fiche-vaovao.jsp&id=<%=id%>&idFille=<%=Utilitaire.champNull(liste[i].getId())%>&sens=0">
                                                <i class="fa fa-arrow-circle-down"></i>
                                            </a>
                                        </td>
                                        <td width="5%" align="left"><%=Utilitaire.champNull(liste[i].getId())%>  </td>
                                        <td width="5%" align="left"><%=Utilitaire.champNull(liste[i].getDesignation())%></td>
                                        <td width="5%" align="right"><%=Utilitaire.formaterAr(liste[i].getPu())%>  </td>
                                        <td width="5%" align="right"><%=Utilitaire.formaterAr(liste[i].getQuantite())%>  </td>
                                        <td width="5%" align="right"><%=Utilitaire.formaterAr(liste[i].getDuree())%>   </td>
                                        <td width="5%" align="left"><%=Utilitaire.champNull(liste[i].getDevise())%>    </td>
                                        <td width="5%" align="left"><%=Utilitaire.champNull(liste[i].getCompte())%>    </td>
                                        <td width="5%" align="right"><%=Utilitaire.formaterAr(liste[i].getTaux())%>    </td>
                                        <td width="5%" align="right"><%=Utilitaire.formaterAr(liste[i].getMontant())%>    </td>
                                        <td width="5%" align="right"><%=Utilitaire.formaterAr(liste[i].getTva())%>  </td>
                                        <td width="5%" align="right"><%=Utilitaire.formaterAr(liste[i].getMontantTva())%>   </td>
                                        <td width="5%" align="left"><%=Utilitaire.champNull(liste[i].getActivitelib())%>   </td>
                                        <td width="5%" align="left"><%=liste[i].getDaty()%></td>
                                        <td width="5%" align="left"><%=Utilitaire.champNull(liste[i].getHeureDebut())%>   </td>
                                        <td width="5%" align="left"><%=Utilitaire.champNull(liste[i].getHeureFin())%>   </td>
                                        <td width="5%" align="left"><%=Utilitaire.formaterAr(liste[i].getReduction())%>   </td>
                                        <td width="5%" align="left"><%=Utilitaire.formaterAr(liste[i].getMajoration())%>    </td>
                                    </tr>
                                    <%}%>
                            </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-3">
        <table class="table table-striped table-bordered table-condensed table-responsive tree">
            <tr>
                <th>Cours de change du : <%= dateFacture%></th>
                <th></th>
            </tr>
            <tr>
                <th>Devise Euro</th>
                <td align="right"><%=Utilitaire.formaterAr(deviseEur)%></td>
            </tr>
            <tr>
                <th>Devise Dollar</th>
                <td align="right"><%=Utilitaire.formaterAr(deviseDollar)%></td>
            </tr>
        </table>
    </div>
    <div class="col-md-3">
        <table class="table table-striped table-bordered table-condensed table-responsive tree">
            <tr>
                <th>Montant en euro</th>
                <th></th>
            </tr>
            <tr>
                <th>HT</th>
                <td align="right"><%=Utilitaire.formaterAr(hTEuro)%></td>
            </tr>
            <tr>
                <th>TVA</th>
                <td align="right"><%=Utilitaire.formaterAr(tvaEuro)%></td>
            </tr>
            <tr>
                <th>TTC</th>
                <td align="right"><%=Utilitaire.formaterAr(ttcEuro)%></td>
            </tr>
        </table>
    </div>
    <div class="col-md-3">
        <table class="table table-striped table-bordered table-condensed table-responsive tree">
            <tr>
                <th>Montant en dollar</th>
                <th></th>
            </tr>
            <tr>
                <th>HT</th>
                <td align="right"><%=Utilitaire.formaterAr(hTDollar)%></td>
            </tr>
            <tr>
                <th>TVA</th>
                <td align="right"><%=Utilitaire.formaterAr(tvaDollar)%></td>
            </tr>
            <tr>
                <th>TTC</th>
                <td align="right"><%=Utilitaire.formaterAr(ttcDollar)%></td>
            </tr>
        </table>
    </div>
    <div class="col-md-3">
        <table class="table table-striped table-bordered table-condensed table-responsive tree">
            <tr>
                <th>Montant en Ar</th>
                <th></th>
            </tr>
            <tr>
                <th>HT</th>
                <td align="right"><%=Utilitaire.formaterAr(htAr)%></td>
            </tr>
            <tr>
                <th>TVA</th>
                <td align="right"><%=Utilitaire.formaterAr(tvaAr)%></td>
            </tr>
            <tr>
                <th>TTC</th>
                <td align="right"><%=Utilitaire.formaterAr(ttcAr)%></td>
            </tr>
        </table>
    </div>
</div>

<% } else {
%><center><h4>Aucun details </h4></center><%
    }
    %>
