<%@page import="facture.FactureClientDetails"%>
<%@page import="facture.FactureClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{
    String titrePage = "Modification Facture Client" ,
            classeMere = "facture.FactureClient" ,
            classeFille = "facture.FactureClientDetails",
            buteLien = "facture/factureclient-modif.jsp" ,
            colonneMereDansFille = "idmere",
            buteApresVisa = "facture/factureclient-fiche-vaovao.jsp";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureClient mere = new FactureClient();
        mere.setNomTable("FACTURECLIENTMSUM_LIB");
    FactureClientDetails fille = new FactureClientDetails();;
    fille.setIdmere(request.getParameter("id"));
    FactureClientDetails[] liste = (FactureClientDetails[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    
    
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setLibelle("User");
    pi.getFormu().getChamp("date_echeance").setLibelle("date d'Echeance");
    pi.getFormu().getChamp("daty").setLibelle("date");
    pi.getFormu().getChamp("type").setVisible(false);
    //pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("etat").setAutre("readonly");
     pi.getFormu().getChamp("iduser").setAutre("readonly");
    pi.getFormu().getChamp("montant").setVisible(false);
    pi.getFormu().getChamp("montanttva").setVisible(false);
    pi.getFormu().getChamp("montantttc").setVisible(false);
    pi.getFormu().getChamp("tierslib").setVisible(false);
    
    
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");
     
    affichage.Liste[] listed = new affichage.Liste[1];
        TypeObjet o = new TypeObjet();
        o.setNomTable("devise");
        listed[0] = new Liste("devise", o, "VAL", "id");
    pi.getFormufle().changerEnChamp(listed);
    
    pi.getFormufle().getChamp("Id_0").setLibelle("Id"); 
    pi.getFormufle().getChamp("designation_0").setLibelle("Désignation"); 
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("pu_0").setLibelle("pu");
    pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
    pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
    pi.getFormufle().getChamp("Devise_0").setLibelle("Devise");
    pi.getFormufle().getChamp("Taux_0").setLibelle("Taux");
    
    mere = (FactureClient) pi.getBase();
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
                <input name="bute" type="hidden" id="bute" value="<%= buteLien %>?id=<%=request.getParameter("id")%>">
                <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille %>">

            </form>
    </div>
</div>
<script>
    document.getElementById("tierslibelle").value = "<%= mere.getTierslib() %>";
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>