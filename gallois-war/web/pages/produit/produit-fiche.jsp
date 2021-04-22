<%-- 
    Document   : produit-fiche.jsp
    Created on : 7 déc. 2020, 14:37:25
    Author     : Lenovo
--%>
<%@page import="mg.allosakafo.produits.Produits" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    Produits dma;
    double total = 0.0;
%>
<%
    try {
        dma = new Produits();
        //dma.setNomTable("as_bondecommande_libelle");
        PageConsulte pc = new PageConsulte(dma, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin

        pc.getChampByName("nom").setLibelle("nom");
        pc.getChampByName("designation").setVisible(false);
        pc.getChampByName("poids").setVisible(false);
        pc.getChampByName("pa").setLibelle("Prix");
        pc.getChampByName("prixl").setVisible(false);
        pc.getChampByName("categorieingredient").setVisible(false);
        pc.getChampByName("photo").setVisible(false);
        pc.getChampByName("poids").setVisible(false);
        pc.getChampByName("idIngredient").setVisible(false);
        pc.getChampByName("poidsprecuit").setVisible(false);
        pc.getChampByName("categorieingredient").setVisible(false);
        pc.getChampByName("cdg").setVisible(false);
        pc.getChampByName("ccg").setVisible(false);
        pc.getChampByName("cda").setVisible(false);
        pc.getChampByName("cca").setVisible(false);
        pc.getChampByName("calorie").setVisible(false);

        Produits produit = (Produits) pc.getBase();
//    pc.getChampByName("produit").setLien((String) session.getValue("lien") + "?but=travaux/tiers-fiche.jsp&id="+produit.getIdfournisseur(), "nom=");
        //pc.getChampByName("modepaiement").setLibelle("Mode de paiement");
        pc.setTitre("Fiche produit");


%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=produit/produit-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                    </div>
                                            <br/>
                        <div class="box-footer">
                            <%out.println(pc.getBasPage());%>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=produit/produit-modif.jsp&id=" + produit.getId()%>" style="margin-right: 10px">Modifier</a>
                            
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