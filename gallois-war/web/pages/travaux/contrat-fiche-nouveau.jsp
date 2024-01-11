
<%@page import="mg.spat.Contrat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    try{
    //Information sur les navigations via la page
    String lien = (String) session.getValue("lien");
    String pageModif = "travaux/contrat-modif-nouveau.jsp";
    String classe = "mg.spat.Contrat";
    String pageActuel = "travaux/contrat-fiche-nouveau.jsp";

    //Information sur la fiche
    Contrat t = new Contrat();
    t.setNomTable("CONTRATLIBCPLT");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    t = (Contrat) pc.getBase();
    pc.getChampByName("chantierlib").setLien((String) session.getValue("lien") + "?but=travaux/chantier-fiche.jsp","id="+ t.getIdchantier() +"&id=");
    String id = request.getParameter("id");
    pc.getChampByName("idtiers").setVisible(false);
    pc.getChampByName("unite").setVisible(false);
    pc.getChampByName("projet").setVisible(false);
    pc.getChampByName("codeetablissement").setVisible(false);
    pc.getChampByName("idlc").setVisible(false);
    pc.getChampByName("idchantier").setVisible(false);
    pc.getChampByName("typeduree").setVisible(false);
    pc.getChampByName("idavenant").setVisible(false);
    pc.getChampByName("fin_contrat").setVisible(false);
    pc.getChampByName("nom").setLibelle("Tiers");
    pc.getChampByName("date_signature").setLibelle("Date de signature");
    pc.getChampByName("objet").setLibelle("Objet");
    pc.getChampByName("debut_contrat").setLibelle("Date d&eacute;but");
    pc.getChampByName("fin_avenant").setLibelle("Date fin");
    pc.getChampByName("duree").setLibelle("Dur&eacute;e");
    pc.getChampByName("valunite").setLibelle("Unit&eacute;");
    pc.getChampByName("codeetablissementlib").setLibelle("Code Etablissement");
    pc.getChampByName("codeprojetlib").setLibelle("Projet");
    pc.getChampByName("chantierlib").setLibelle("Chantier");
    pc.getChampByName("lclib").setLibelle("Budget");
    pc.getChampByName("montantpaye").setLibelle("Montant Pay&eacute;");
    pc.getChampByName("annee").setLibelle("Ann&eacute;e");
    pc.setTitre("Fiche contrat");


    Map<String, String> map = new HashMap();
    map.put("avenant","");
    map.put("engagement-contrat","");   
    map.put("facture-fournisseur-vaovao","");

    
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "avenant";
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
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=travaux/contrat-fiche-nouveau.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-primary pull-left"  href="<%= lien + "?but=travaux/avenant-saisie.jsp&idcontrat=" + id + "&nomcontrat=" + t.getObjet() %>" style="margin-right: 10px">Saisir avenant</a>
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-warning pull-left"  href="<%= lien + "?but=travaux/avenant-modif.jsp&id=" + t.getIdavenant() + "&redirection=travaux/contrat-fiche-nouveau.jsp?id="+t.getId()%>" style="margin-right: 10px">Modifier montant</a>
                            <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + id%>&acte=valider&bute=travaux/contrat-fiche-nouveau.jsp&id=<%=id%>&classe=mg.spat.Contrat" style="margin-right: 10px">Viser</a>
                             <a id="imprimer" href="<%=(String) session.getValue("lien") + "/../../Paie?action=imprimerSuiviContrat&id=" + id%>"><button class="btn btn-primary pull-right" >Imprimer suivi contrat</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <!-- a modifier -->
                    <li class="<%=map.get("avenant")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=avenant">Avenants</a></li>
                    <li class="<%=map.get("engagement-contrat")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=engagement-contrat">Engagements</a></li>
                    <li class="<%=map.get("facture-fournisseur-vaovao")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=facture-fournisseur-vaovao">Facture fournisseur</a></li>

                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idmere" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
}
%>
