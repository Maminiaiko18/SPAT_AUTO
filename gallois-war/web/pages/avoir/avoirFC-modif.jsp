<%@page import="avoir.AvoirFCFille"%>
<%@page import="avoir.AvoirFC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{
    String titrePage = "Modification Avoir FC" ,
            classeMere = "avoir.AvoirFC" ,
            classeFille = "avoir.AvoirFCFille",
            buteLien = "avoir/avoirFC-modif.jsp" ,
            colonneMereDansFille = "idmere",
            buteApresVisa = "avoir/avoirFC-fiche.jsp";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    AvoirFC mere = new AvoirFC();
    AvoirFCFille fille = new AvoirFCFille();
    fille.setIdmere(request.getParameter("id"));
    AvoirFCFille[] liste = (AvoirFCFille[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    
    
    pi.getFormu().getChamp("idfacture").setPageAppel("choix/listeFactureCientChoix.jsp");
    pi.getFormu().getChamp("idfacture").setAutre("readonly");
    pi.getFormu().getChamp("idfacture").setLibelle("Facture");
    pi.getFormu().getChamp("daty").setLibelle("date");
    pi.getFormu().getChamp("etat").setVisible(false);
    
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("iddetailfacture"), "choix/listeFactureCientDetailsChoix.jsp", "iddetailfacture;iddetailfacturelibelle");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailfacture"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idMere"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
    
     pi.getFormufle().getChamp("iddetailfacture_0").setLibelle("Id Détail Facture");
     pi.getFormufle().getChamp("Id_0").setLibelle("Id");
     pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
     pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
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
</div>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>