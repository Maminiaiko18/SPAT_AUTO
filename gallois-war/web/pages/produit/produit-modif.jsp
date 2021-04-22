<%-- 
    Document   : produit-modif
    Created on : 7 déc. 2020, 15:18:45
    Author     : nyamp
--%>

<%@page import="mg.allosakafo.produits.Produits"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="user.UserEJB"%>
<%
    try{
    UserEJB u;
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Produits  produit = new Produits();

    PageUpdate pi = new PageUpdate(produit, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("cdg").setLibelle("Compte débit général");
    pi.getFormu().getChamp("ccg").setLibelle("Compte crédit général");
    pi.getFormu().getChamp("cda").setLibelle("Compte débit auxiliaire");
    pi.getFormu().getChamp("cca").setLibelle("Compte crédit auxiliaire");
    pi.getFormu().getChamp("cdg").setAutre("readonly");
    pi.getFormu().getChamp("ccg").setAutre("readonly");
    pi.getFormu().getChamp("cda").setAutre("readonly");
    pi.getFormu().getChamp("cca").setAutre("readonly");
    pi.getFormu().getChamp("cdg").setVisible(false);
    pi.getFormu().getChamp("ccg").setVisible(false);
    pi.getFormu().getChamp("cda").setVisible(false);
    pi.getFormu().getChamp("cca").setVisible(false);
    pi.getFormu().getChamp("photo").setVisible(false);
    pi.getFormu().getChamp("calorie").setVisible(false);
    pi.getFormu().getChamp("Categorieingredient").setVisible(false);
    pi.getFormu().getChamp("Designation").setVisible(false);
    pi.getFormu().getChamp("Poids").setVisible(false);
//    pi.getFormu().getChamp("pa").setLibelleAffiche("Prix");
    pi.getFormu().getChamp("pa").setLibelle("Prix");
    pi.getFormu().getChamp("idingredient").setVisible(false);
    pi.getFormu().getChamp("prixL").setVisible(false);
    pi.getFormu().getChamp("poidsprecuit").setVisible(false);
    pi.getFormu().getChamp("poidsprecuit").setLibelle("Kg");
    produit=(Produits)pi.getBase();
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <!--<div class="box-fiche">-->
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
                        <input name="bute" type="hidden" id="bute" value="produit/produit-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.allosakafo.produits.Produits">
                        <input name="nomtable" type="hidden" id="nomtable" value="as_produits">
                    </form>
                </div>
            <!--</div>-->
        </div>
    </div>
</div>
<%}
    catch(Exception e){
    e.printStackTrace();
}%>