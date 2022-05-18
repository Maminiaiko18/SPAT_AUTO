<%@page import="avoir.AvoirFCFilleLib"%>
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
            buteLien = "avoir/avoirFC-fiche.jsp" ,
            colonneMereDansFille = "idmere",
            buteApresVisa = "avoir/avoirFC-fiche.jsp";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    AvoirFC mere = new AvoirFC();
//    mere.setNomTable("AVOIRFC_designation_fc");
    AvoirFCFilleLib fille = new AvoirFCFilleLib();
//    fille.setNomTable("AVOIRFCFILLE_MONTANTFACTURE");
    fille.setIdmere(request.getParameter("id"));
    AvoirFCFilleLib[] liste = (AvoirFCFilleLib[])CGenUtil.rechercher(fille, null, null, "");
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
    //pi.getFormu().getChamp("code").setVisible(false);

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
    
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("iddetailfacture"), "choix/listeFactureClientDetailsChoix.jsp", "iddetailfacture;iddetailfacturelibelle;montant;montantdf;devise");
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
    
        for( int i = 0 ; i < pi.getNombreLigne() ; i++ ){
            pi.getFormufle().getChamp("qte_"+i).setAutre("oninput='calcMontant(" + i + ")'");
            pi.getFormufle().getChamp("red_"+i).setAutre("oninput='calcMontant(" + i + ")'");
            pi.getFormufle().getChamp("pu_"+i).setAutre("oninput='calcMontant(" + i + ")'");
            pi.getFormufle().getChamp("maj_"+i).setAutre("oninput='calcMontant(" + i + ")'");
            pi.getFormufle().getChamp("duree_"+i).setAutre("oninput='calcMontant(" + i + ")'");
        }


    pi.getFormufle().getChamp("iddetailfacture_0").setLibelle("Id Détail Facture");
    pi.getFormufle().getChamp("Id_0").setLibelle("Id");
    pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("Compte_0").setVisible(false);
//    pi.getFormufle().getChamp("montantdftaux_0").setLibelle("Montant FD Taux");
    pi.getFormufle().getChamp("Devise_0").setLibelle("Devise");    
    
    pi.getFormufle().getChamp("qte_0").setLibelle("qte");
    pi.getFormufle().getChamp("pu_0").setLibelle("pu");
    pi.getFormufle().getChamp("duree_0").setLibelle("duree");
    pi.getFormufle().getChamp("maj_0").setLibelle("maj");
    pi.getFormufle().getChamp("red_0").setLibelle("red");

    pi.getFormufle().getChamp("tva_0").setLibelle("TVA Avoir");
    pi.getFormufle().getChamp("tvaDf_0").setLibelle("TVA detail facture");
    
    
    pi.getFormufle().getChamp("Montantdf_0").setLibelle("Montant detail facture");
    pi.getFormufle().getChamp("Designation_0").setLibelle("Designation");
    pi.getFormufle().getChamp("remise_0").setLibelle("Remise %");
    
   
    pi.getFormufle().getChamp("Montantdf_0").setLibelle("Montant detail facture");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("tvaAv"), false);
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("iddetailfacture"), "readonly");
    
    
    String[] ordreFille ={"iddetailfacture","designation","devise","qte","pu","duree","maj","red","montant","tva","montantdf","tvadf","remise"};
    pi.getFormufle().setColOrdre(ordreFille);
    
    mere = (AvoirFC) pi.getBase();
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
    function parseNumberOrDefault(value, defaultValue = 0) {
        value = parseFloat(value);
        if(isNaN(value)) return defaultValue;
        return value;
    }
    function calcMontant(index) {
        const qte = parseFloat(document.getElementById('qte_'+index).value);
        const pu = parseFloat(document.getElementById('pu_'+index).value);
        const maj = document.getElementById('maj_'+index).value;
        const duree = document.getElementById('duree_'+index).value;
        const red = document.getElementById('red_'+index).value;
        
        if(!isNaN(qte) && !isNaN(pu)) {
            let montant = qte * pu * parseNumberOrDefault(duree, 1);
            montant = montant * (1 + (parseNumberOrDefault(maj)/100) - (parseNumberOrDefault(red)/100));
            document.getElementById('montant_'+index).value = montant.toFixed(3);
        }
    }
</script>
<script>
    <%  for(int i=0; liste!=null && i<liste.length; i++){%>
        document.getElementById("iddetailfacturelibelle_<%=i%>").value = "<%=liste[i].getDesignation() %>";
    <%}%>
    document.getElementById("idfacturelibelle").value = "<%=mere.getDesignationFacture()!=null && !mere.getDesignationFacture().equals("") ? mere.getDesignationFacture() : mere.getIdfacture() %>";
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>