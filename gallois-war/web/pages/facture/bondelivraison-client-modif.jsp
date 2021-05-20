<%@page import="mg.spat.stock.BonDeLivraisonClientFille"%>
<%@page import="mg.spat.stock.BonDeLivraisonClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{
    String titrePage = "Modification Bon de Livraison Client" ,
            classeMere = "mg.spat.stock.BonDeLivraisonClient" ,
            classeFille = "mg.spat.stock.BonDeLivraisonClientFille",
            buteLien = "facture/bondelivraison-client-modif.jsp" ,
            colonneMereDansFille = "numbl",
            buteApresVisa = "facture/bondelivraison-client-fiche.jsp";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BonDeLivraisonClient mere = new BonDeLivraisonClient();
    mere.setNomTable("as_bondelivraison_cl_libelle");
    BonDeLivraisonClientFille fille = new BonDeLivraisonClientFille();
    fille.setNomTable("as_bondelivraison_cl_Fille_lib");
    fille.setNumbl(request.getParameter("id"));
    BonDeLivraisonClientFille[] liste = (BonDeLivraisonClientFille[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("etatlib").setLibelle("Etat");
    pi.getFormu().getChamp("idbc").setLibelle("Facture");
    pi.getFormu().getChamp("point").setVisible(false);
    pi.getFormu().getChamp("designationFacture").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("etatlib").setAutre("readonly");
    pi.getFormu().getChamp("idbc").setAutre("readonly");
    
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    pi.getFormu().getChamp("idbc").setPageAppel("choix/listeFactureClientChoix.jsp");
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("produit"), "choix/produitChoix.jsp", "produit;produitlibelle");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("produit"), "readonly");
    
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("produitlib"), false);
    
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("produit"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("numbl"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailsfacturefournisseur"), "readonly");
    
    pi.getFormufle().getChamp("id_0").setLibelle("Id");
    pi.getFormufle().getChamp("produit_0").setLibelle("Produit");
    pi.getFormufle().getChamp("Numbl_0").setLibelle("Num BL");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantité");
    pi.getFormufle().getChamp("iddetailsfacturefournisseur_0").setLibelle("idDetail FF");
    
    mere = (BonDeLivraisonClient) pi.getBase();
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
        <div class="box">
            <h1><%= titrePage %></h1>
            <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    pi.getFormufle().makeHtmlInsertTableauIndex();
                    out.println(pi.getFormu().getHtmlInsert());
                %>
                   <center style="margin-bottom: 10px;"> <a class="btn btn-success button-margin"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=<%= buteApresVisa %>&classe=<%= classeMere %>">Viser</a> </center>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <%
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                    </div>
                </div>

                <input name="acte" type="hidden" id="nature" value="updateInsert">
                <input name="bute" type="hidden" id="bute" value="<%= buteLien %>?id=<%=mere.getId()%>">
                <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille %>">

            </form>
    </div>
</div>
<script>
    <%for(int i=0; liste!=null && i<liste.length; i++){%>
        document.getElementById("produitlibelle_<%=i%>").value = "<%= Utilitaire.champNull(liste[i].getProduitLib())%>";
    <%}%>
    document.getElementById("idbclibelle").value = "<%= Utilitaire.champNull(mere.getDesignationFacture())%>";
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>