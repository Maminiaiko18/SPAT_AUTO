<%-- 
    Document   : bon-commande-fiche
    Created on : 10 déc. 2019, 16:58:21
    Author     : HP
--%>

<%@page import="mg.spat.ContratFournisseur"%>
<%@page import="affichage.PageConsulte"%>
<%

    ContratFournisseur m = new ContratFournisseur();
    PageConsulte pc = new PageConsulte(m, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setTitre("Fiche contrat fournisseur");
    
    pc.getChampByName("condition_reglement").setLibelle("Condition reglement");
    pc.getChampByName("mode_reglement").setLibelle("Mode de reglement");
    pc.getChampByName("ref_fournisseur").setLibelle("Ref fournisseur");
    pc.getChampByName("cp").setLibelle("Code postal");
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=capitainerie/bon-commande/contrat-fournisseur-list.jsp"><i class="fa fa-arrow-circle-left"></i></a> <%= pc.getTitre() %></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        </br>
                        <div class="pull-right">
                            <a href="<%=(String) session.getValue("lien") + "?but=capitainerie/bon-commande/contract-fournisseur-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                            <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=capitainerie/bon-commande/contrat-fournisseur-list.jsp&classe=mg.spat.ContratFournisseur"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
