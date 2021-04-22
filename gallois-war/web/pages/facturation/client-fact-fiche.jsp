<%-- 
    Document   : client-fact-fiche
    Created on : 24 janv. 2020, 12:07:57
    Author     : john
--%>

<%@page import="mg.spat.ClientFactureCategorieClient"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="mg.spat.Statistique"%>
<%
    ClientFactureCategorieClient s = new ClientFactureCategorieClient();
    s.setNomTable("cltfactclientlib");
    PageConsulte pc = new PageConsulte( s , request, (user.UserEJB) session.getValue("u"));
    pc.setTitre("Fiche type facture");
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idClient").setLibelle("Client");
    pc.getChampByName("idtype_fact_cat_client").setLibelle("Type facture");
    pc.getChampByName("statut").setLibelle("Statut");
%>


<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facturation/client-fact-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche report</h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="pull-right">
                            <p>
                                <a href="<%=(String) session.getValue("lien") + "?but=facturation/client-fact-modif.jsp&id=" + request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
                                <a href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=facturation/client-fact-liste.jsp&classe=mg.spat.ClientFactureCategorieClient"><button class="btn btn-danger">Supprimer</button></a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>