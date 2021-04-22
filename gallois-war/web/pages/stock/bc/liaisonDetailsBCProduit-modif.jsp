<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.allosakafo.produits.LiaisonDetailsBCProduitLibelle" %>

<%
    UserEJB u;
    LiaisonDetailsBCProduitLibelle liaison;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    liaison = new LiaisonDetailsBCProduitLibelle();

    PageUpdate pi = new PageUpdate(liaison, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idfournisseur").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("idfournisseur").setAutre("readonly");
    pi.getFormu().getChamp("idproduit").setPageAppel("choix/produitChoix.jsp");
    pi.getFormu().getChamp("idproduit").setAutre("readonly");
    pi.getFormu().getChamp("idfournisseur").setLibelle("Fournisseur");
    pi.getFormu().getChamp("idDetailsBC").setLibelle("Bon de commande");
    pi.getFormu().getChamp("idProduit").setLibelle("Produit");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("fournisseur").setVisible(false);
    pi.getFormu().getChamp("iddetailslib").setVisible(false);
    pi.getFormu().getChamp("produit").setVisible(false);


    liaison=(LiaisonDetailsBCProduitLibelle)pi.getBase();
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification info liaison bon de commande</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formabsence">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="stock/bc/liaisonDetailsBCProduit-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.allosakafo.produits.LiaisonDetailsBCProduit">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="LiaisonDetailsBCProduit">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("idfournisseurlibelle").value='<%=liaison.getFournisseur()%>';
</script>