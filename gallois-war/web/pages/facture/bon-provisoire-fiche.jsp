<%@page import="facture.BonProvisoire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    BonProvisoire bonprovisoire;
    bonprovisoire = new BonProvisoire();
    bonprovisoire.setNomTable("bon_provisoire_final_lib");
    PageConsulte pc = new PageConsulte(bonprovisoire, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("id").setLibelle("Identifiant");
    pc.getChampByName("tierslib").setLibelle("Tiers");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("caisselib").setLibelle("Caisse");
    pc.getChampByName("montant").setLibelle("Montant");
    pc.getChampByName("etat").setLibelle("Etat");
    pc.getChampByName("caisse").setVisible(false);
    pc.getChampByName("tiers").setVisible(false);
    BonProvisoire produit = (BonProvisoire) pc.getBase();
    pc.setTitre("Fiche Bon provisoire");
 

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facture/bon-provisoire-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <%out.println(pc.getBasPage());%>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=facture/bon-provisoire-modif.jsp&id=" + produit.getId()%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=facture/bon-provisoire-fiche.jsp&classe=facture.BonProvisoire">Viser</a>
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>

