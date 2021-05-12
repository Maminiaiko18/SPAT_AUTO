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
//    mere.setNomTable("st_inventaire_ordre");
    AvoirFCFille fille = new AvoirFCFille();
//    InventaireDetails fille = new InventaireDetails();
//    fille.setNomTable("INVENTAIREDETAILS_VUE");
    fille.setIdmere(request.getParameter("id"));
//    InventaireDetails[] liste = (InventaireDetails[])CGenUtil.rechercher(fille, null, null, "");
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
    
//    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
//    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idmere"), "readonly");
//    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idop"), "readonly");
//    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idop"), "choix/listeOrdonnerPayementChoix.jsp","idop;",true);
//    pi.getFormu().getChamp("daty").setLibelle("Date");
//    pi.getFormu().getChamp("designation").setType("textarea");
//    pi.getFormu().getChamp("designation").setLibelle("Observation");
//    pi.getFormu().getChamp("remarque").setType("textarea");
//    affichage.Liste[] listed = new affichage.Liste[4];
//    TypeObjet o = new TypeObjet();
//    o.setNomTable("st_type_inventaire");
//    listed[0] = new Liste("typeinventaire", o, "VAL", "id");
//    StMagasin mag = new StMagasin();
//    mag.setNomTable("ST_MAGASIN");
//    listed[1] = new Liste("magasin", mag, "desce", "id");    
//    TypeObjet o2 = new TypeObjet();
//    o2.setNomTable("ST_GROUPE_ARTICLE");
//    listed[2] = new Liste("idcategorieingredient", o2, "VAL", "id");    
//    Centre o3 = new Centre();
//    o3.setNomTable("CENTRE_INTERNE");
//    listed[3] = new Liste("point", o3, "val", "id");    
//    listed[3].setDeroulanteDependante(listed[1],"point","onblur");    
//    pi.getFormu().changerEnChamp(listed);
//    pi.getFormu().getChamp("etat").setVisible(false);
//    pi.getFormu().getChamp("point").setVisible(false);
//    pi.getFormu().getChamp("tiers").setAutre("readonly");
//    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
//    pi.getFormu().getChamp("Etat").setVisible(false);
//    pi.getFormu().getChamp("Daty").setLibelle("Date");
//    pi.getFormu().getChamp("Compte").setVisible(false);
//    pi.getFormu().getChamp("Remarque").setVisible(false);
//    pi.getFormu().getChamp("tiers").setPageAppel("choix/stTiersChoixClient.jsp");
//    pi.getFormu().getChamp("tiers").setPageAppel("choix/ClientChoix.jsp");
//    pi.getFormu().getChamp("tiers").setAutre("readonly");
//    affichage.Champ[] listed = new affichage.Champ[1];
//    TypeObjet tp = new TypeObjet();
//    tp.setNomTable("devise");
//    listed[0] = new Liste("devise", tp, "val", "id");
//    pi.getFormu().changerEnChamp(listed);
//    pi.getFormu().getChamp("devise").setAutre("onchange=\"dependanteChamp(this.value, 'coursdevise', 'cours_devise', 'mg.cnaps.compta.CoursDevise', 'devise_id', 'devise_id', 'valeur_devise');\"");
//    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");     
//    pi.getFormufle().getChamp("Idop_0").setLibelle("Ordre de paiement");     
//    pi.getFormufle().getChamp("Idbordereau_0").setLibelle("Bordereau");     
//    pi.getFormufle().getChamp("id_0").setLibelle("ID");
//    pi.getFormufle().getChamp("Prixunitaire_0").setLibelle("Prix unitaire");
//    pi.getFormufle().getChampMulitple("Montant").setVisible(false);
//    pi.getFormufle().getChampMulitple("Typee").setVisible(false);
//    pi.getFormufle().getChampMulitple("Compte").setVisible(false);
//    pi.getFormufle().getChampMulitple("Remarque").setVisible(false);
//    String[] colOrdreF={"id","idmere","Designation","quantite","Prixunitaire"};
//    pi.getFormufle().setColOrdre(colOrdreF);
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