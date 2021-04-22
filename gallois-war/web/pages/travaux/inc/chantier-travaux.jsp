<%-- 
    Document   : chantier-travaux
    Created on : 14 déc. 2020, 10:04:47
    Author     : ASUS
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="mg.spat.Travaux"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.Chantier"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Chantier cht = new Chantier();
    cht.setNomTable("chantierlibelle");
    String listeCrt[] = {"id", "nom", "datydebut", "datyfin"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nom", "datydebut", "datyfin", "idtiers", "avancement","montant"};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    /*pr.getFormu().getChamp("datydebut1").setLibelle("Date début min");
    pr.getFormu().getChamp("datydebut2").setLibelle("Date début max");
    pr.getFormu().getChamp("datyfin1").setLibelle("Date fin min");
    pr.getFormu().getChamp("datyfin2").setLibelle("Date fin max");*/

    //pr.getFormu().getChamp("id").setLien((String)session.getValue("lien")+"?but=travaux/details-chantier-fiche.jsp", "id=");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String id = "";
    Chantier[] liste = null;
    if (request.getParameter("id") != null) {
        id = request.getParameter("id");
        Travaux tr = new Travaux(id);
        liste = tr.getChantierProjet(id, null);
    }
    pr.setApres("travaux/inc/chantier-travaux.jsp");
    String[] colSomme = {"montant"};
    double total=0;
        pr.creerObjetPage(libEntete, colSomme);
//    pr.getTableauRecap().getFormu().getChamp("montant").setLibelle("Motant Total");
    if (liste != null) {
        pr.setTableau(new TableauRecherche(liste, libEntete));
        total=AdminGen.calculSommeDouble(liste,"montant");
    }
    String libEnteteAffiche[] = {"id", "Désignation chantier", "Date début", "Date fin", "Tiers", "Avancement (%)","Montant"};
    String lienTableau[] = {pr.getLien() + "?but=travaux/chantier-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibeEntete(libEnteteAffiche);
    String html=pr.getTableau().getHtml();
    if(html!=null){
        out.println(html);
    }
%>
<table class="table table-striped table-bordered table-condensed table-responsive tree" >
    <tr>
        <td colspan="5"></td>
        <th width="14%" align="right">Montant total</th>
        <td width="14%" align="right"><%=Utilitaire.formaterAr(total)%></td>
    </tr>
</table>