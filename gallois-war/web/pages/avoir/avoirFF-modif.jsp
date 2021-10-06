<%@page import="avoir.AvoirFF"%>
<%@page import="avoir.AvoirFFFille"%>
<%@page import="avoir.AvoirFCFilleLib"%>
<%@page import="avoir.AvoirFC"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{
    String titrePage = "Modification Avoir FF" ,
            classeMere = "avoir.AvoirFF" ,
            classeFille = "avoir.AvoirFFFille",
            buteLien = "avoir/avoirFF-modif.jsp" ,
            colonneMereDansFille = "idmere",
            buteApresVisa = "avoir/avoirFF-fiche.jsp";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    AvoirFF mere = new AvoirFF();
    mere.setNomTable("avoirFF");
    AvoirFFFille fille = new AvoirFFFille();
    fille.setNomTable("AVOIRFFFILLE_MONTANTFACTURE");
    fille.setIdmere(request.getParameter("id"));
    AvoirFFFille[] liste = (AvoirFFFille[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    
    
    pi.getFormu().getChamp("idfacture").setPageAppel("choix/listeFactureClientViseeChoix.jsp");
    pi.getFormu().getChamp("idfacture").setAutre("readonly");
    pi.getFormu().getChamp("idfacture").setLibelle("Facture");
    pi.getFormu().getChamp("daty").setLibelle("date");
    pi.getFormu().getChamp("etat").setVisible(false);
//    pi.getFormu().getChamp("designationFacture").setVisible(false);
//    pi.getFormu().getChamp("designationFacture").setVisible(false);
    pi.getFormu().getChamp("designation").setLibelle("Note explicative");
    pi.getFormu().getChamp("code").setVisible(false);

    affichage.Champ[] listeMere = new affichage.Champ[3];
    TypeObjet categorie = new TypeObjet();
    categorie.setNomTable("categorieAvoirFC");
    
    TypeObjet motif = new TypeObjet();
    motif.setNomTable("motifAvoirFC");
    
    Liste li = new Liste("type");
    String [] val = {"1", "2"};
    String [] aff = {"Interne", "Externe"};
    li.ajouterValeur( val, aff );
    
    listeMere[0] = new Liste("categorie",categorie, "val", "id");
    listeMere[1] = new Liste("motif",motif, "val", "id");
    listeMere[2] = li;
    pi.getFormu().changerEnChamp(listeMere);
    
//    affichage.Champ[] listeFille = new affichage.Champ[1];
//    TypeObjet devise = new TypeObjet();
//    devise.setNomTable("devise");
//    listeFille[0] = new Liste("devise",devise, "val", "id");
//    pi.getFormufle().changerEnChamp(listeFille);
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("iddetailfacture"), "choix/listeFactureClientDetailsChoix.jsp", "iddetailfacture;iddetailfacturelibelle;montant;montantDFTaux;devise");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailfacture"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idMere"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("devise"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("designation"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montantdf"), "readonly");
//    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montantdftaux"), "readonly");
//    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
//    affichage.Champ.setVisible(pi.getFormufle().getChampFille("montantdf"), false);
//    affichage.Champ.setVisible(pi.getFormufle().getChampFille("designation"), false);
    
    pi.getFormufle().getChamp("iddetailfacture_0").setLibelle("Id Détail Facture");
    pi.getFormufle().getChamp("Id_0").setLibelle("Id");
    pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
//    pi.getFormufle().getChamp("montantdftaux_0").setLibelle("Montant FD Taux");
    pi.getFormufle().getChamp("Devise_0").setLibelle("Devise");
    
    
    
    //pi.getFormufle().getChamp("Montantdf_0").setLibelle("Montant detail facture");
    //pi.getFormufle().getChamp("Designation_0").setLibelle("Designation");
    //pi.getFormufle().getChamp("remise_0").setLibelle("Remise %");
    
    pi.getFormufle().getChamp("iddetailfacture_0").setLibelle("Id Détail Facture");
    pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
    pi.getFormufle().getChamp("Montantdf_0").setLibelle("Montant detail facture");
    //pi.getFormufle().getChamp("Devise_0").setLibelle("Devise");
    pi.getFormufle().getChamp("Designation_0").setLibelle("Designation");
    //pi.getFormufle().getChamp("remise_0").setLibelle("Remise %");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("montantdftaux"), false);
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailfacture"), "readonly");
    
    
    
    mere = (AvoirFF) pi.getBase();
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
      
<script>
    <%  for(int i=0; liste!=null && i<liste.length; i++){%>
        document.getElementById("iddetailfacturelibelle_<%=i%>").value = "<%=liste[i].getDesignation() %>";
    <%}%>
    document.getElementById("idfacturelibelle").value = "<%=mere.getDesignationFacture()!=null && !mere.getDesignationFacture().equals("") ? mere.getDesignationFacture() : mere.getIdfacture() %>";
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>