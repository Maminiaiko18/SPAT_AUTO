<%-- 
    Document   : bon-commande-fiche
    Created on : 10 déc. 2019, 16:58:21
    Author     : HP
--%>

<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="mg.spat.ContratEngagementBonCommande"%>
<%

    ContratEngagementBonCommande m = new ContratEngagementBonCommande();
    m.setNomTable("contrat_engagement_boncmdlib");
    PageConsulte pc = new PageConsulte(m, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche mouvement");
    pc.getChampByName("daty").setLibelle("Date");
    ContratEngagementBonCommande cebc = (ContratEngagementBonCommande)pc.getBase();
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=capitainerie/bon-commande/bon-commande-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche mouvement</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        </br>
                        <div class="pull-right">
                            <%if(cebc.getEtat() != ConstanteEtat.getEtatValider()){%>
                                <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=capitainerie/bon-commande/bon-commande-liste.jsp&classe=mg.spat.ContratEngagementBonCommande">Viser</a>
                            <%}%>
                            <a href="<%=(String) session.getValue("lien") + "?but=capitainerie/bon-commande/bon-commande-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=capitainerie/bon-commande/bon-commande-liste.jsp&classe=mg.spat.ContratEngagementBonCommande"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
