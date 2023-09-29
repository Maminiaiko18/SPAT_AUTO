<%-- 
    Document   : prioritaire-fiche.jsp
    Created on : 7 d�c. 2020, 14:37:25
    Author     : Lenovo
--%>
<%@page import="utilisateur.Prioritaire"%>
<%@page import="mg.allosakafo.produits.Produits" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Prioritaire dma;
    double total = 0.0;
%>
<%
    try {
        dma = new Prioritaire();
        dma.setNomTable("prioritairelib");
        //dma.setNomTable("as_bondecommande_libelle");
        PageConsulte pc = new PageConsulte(dma, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

        pc.getChampByName("id").setLibelle("id");
        pc.getChampByName("utilisateur").setLibelle("Nom de l'Utilisateur");
        pc.getChampByName("roles").setLibelle("Roles");
        pc.getChampByName("etat").setLibelle("Etat");
        pc.getChampByName("rang").setLibelle("Rang");
        pc.getChampByName("refuser").setVisible(false);
        pc.getChampByName("idrole").setVisible(false);

        Prioritaire prio = (Prioritaire) pc.getBase();
//    pc.getChampByName("produit").setLien((String) session.getValue("lien") + "?but=travaux/tiers-fiche.jsp&id="+produit.getIdfournisseur(), "nom=");
        //pc.getChampByName("modepaiement").setLibelle("Mode de paiement");
        pc.setTitre("Fiche Prioritaire");


%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=prioritaire/prioritaire-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                    </div>
                    <br/>
                    <div class="box-footer">
                        <%out.println(pc.getBasPage());%>
                        <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=prioritaire/prioritaire-modif.jsp&id=" + prio.getId()%>" style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&bute=prioritaire/prioritaire-fiche.jsp&classe=utilisateur.Prioritaire&id=" + prio.getId()%>" style="margin-right: 10px">Viser</a>
                        <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&bute=prioritaire/prioritaire-fiche.jsp&classe=utilisateur.Prioritaire&id=" + prio.getId()%>" style="margin-right: 10px">Annuler Visa</a>
                    </div>  
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