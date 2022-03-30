<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="facture.ProformaFilleData"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="facture.ProformaMere"%>
<%@page import="facture.ProformaFille"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ProformaFille cht = new ProformaFille();
//    cht.setNomTable("facture_client_fille_lib_reste");
    cht.setNomTable("proforma_fille_lib");
    //String libEntete[] = {"id", "designation", "pu", "quantite","duree", "devise", "compte", "taux", "montanttaux", "tva", "montantTva", "montantHTEuro", "montantTVAEuro", "activitelib", "heureDebut", "heureFin", "reduction", "majoration"};
    String libEntete[] = {"id", "designation", "pu", "quantite","duree", "devise", "compte", "taux", "montanttaux", "tva", "montantTva", "activitelib","daty", "heureDebut", "heureFin", "reduction", "majoration"};
    String listeCrt[] = {"idmere"};
    String listeInt[] = {};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    //pr.setApres("facture/inc/avoir-liste.jsp");
    String[] colSomme = {"montant"};
    pr.setOrdre(" order by rang asc, daty asc");
    pr.creerObjetPage(libEntete, colSomme);

    ProformaFille[] liste = (ProformaFille[]) pr.getTableau().getData();

    /*
    FactureClient fm=(FactureClient) liste[0].findMere(null,null);
    ProformaFille[] lcdf=(ProformaFille[])fm.getFille(null, null,"");
    FactureClient dfm=(FactureClient)fm.dupliquer(pr.getUtilisateur().getUser().getTuppleID(), null);
     */
    //if(liste == null) liste = new  ProformaFille[0]; 
    pr.getTableau().transformerDataString();

    //String libEnteteAffiche[] = {"id", "designation", "pu", "quantité","duree", "devise", "compte", "taux", "montant", "tva", "montant Tva", "HT Euro", "TVA Euro", "Activite", "Heure début", "Heure fin", "RED.%", "MAJ.%"};
    String libEnteteAffiche[] = {"id", "designation", "pu", "quantité","duree", "devise", "compte", "taux", "montant", "tva", "montant Tva", "Activite","Date", "Heure début", "Heure fin", "RED.%", "MAJ.%"};
//    String lienTableau[] = {pr.getLien() + "?but=avoir/avoir-fiche.jsp"};
//    String colonneLien[] = {"id"};
//    pr.getTableau().setLien(lienTableau);
//    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);

    if (liste.length > 0 && pr.getTableau().getHtml() != null) {
        ProformaFilleData dataF = new ProformaFilleData(liste[0].getIdmere(), liste, null);
        ProformaMere facture = dataF.getProforma();

        out.println(pr.getTableau().getHtml());
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
