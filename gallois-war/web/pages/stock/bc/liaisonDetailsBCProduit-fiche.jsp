<%-- 
    Document   : liaisonDetailsBCProduit-fiche
    Created on : 7 déc. 2020, 09:12:13
    Author     : nyamp
--%>
<%@ page import=" mg.allosakafo.produits.LiaisonDetailsBCProduitLibelle" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    LiaisonDetailsBCProduitLibelle dma;
    double total = 0.0;
%>
<%
    dma = new LiaisonDetailsBCProduitLibelle();
    //dma.setNomTable("as_bondecommande_libelle");
    PageConsulte pc = new PageConsulte(dma, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("iddetailslib").setLibelle("Designation");
    pc.getChampByName("idDetailsBC").setLibelle("Detail bon de commande");
//    pc.getChampByName("produit").setLibelle("Detail bon de commande");
    pc.getChampByName("idProduit").setVisible(false);
    pc.getChampByName("idfournisseur").setVisible(false);
    LiaisonDetailsBCProduitLibelle produit = (LiaisonDetailsBCProduitLibelle) pc.getBase();
    pc.getChampByName("fournisseur").setLien((String) session.getValue("lien") + "?but=travaux/tiers-fiche.jsp&id="+produit.getIdfournisseur(), "nom=");
//    pc.getChampByName("produit").setLien((String) session.getValue("lien") + "?but=travaux/tiers-fiche.jsp&id="+produit.getIdfournisseur(), "nom=");
    //pc.getChampByName("modepaiement").setLibelle("Mode de paiement");
    pc.setTitre("Fiche liaison detail Bon de commande produit");
 

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=stock/bc/liaisonDetailsBCProduit-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <%out.println(pc.getBasPage());%>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=stock/bc/liaisonDetailsBCProduit-modif.jsp&id=" + produit.getId()%>" style="margin-right: 10px">Modifier</a>
                            
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>
