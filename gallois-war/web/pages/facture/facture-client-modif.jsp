<%@page import="factureclient.FactureClientDetail"%>
<%@page import="factureclient.FactureClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{
    String titrePage = "Modification facture client" ,
            classeMere = "factureclient.FactureClient" ,
            classeFille = "factureclient.FactureClientDetail",
            buteLien = "facture/facture-client-modif.jsp" ,
            colonneMereDansFille = "idfacture",
            buteApresVisa = "facture/facture-client-fiche.jsp";
    
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureClient mere = new FactureClient();
    FactureClientDetail fille = new FactureClientDetail();
    fille.setNomTable("FACTURE_CLIENT_DETAIL");
    fille.setIdfacture(request.getParameter("id"));
    FactureClientDetail[] liste = (FactureClientDetail[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("montant").setVisible(false);
    pi.getFormu().getChamp("tva").setVisible(false);
//    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("montanttva").setVisible(false);
    pi.getFormu().getChamp("devise").setVisible(false);
    pi.getFormu().getChamp("coursdevise").setVisible(false);
    pi.getFormu().getChamp("Antenne").setVisible(false);
    pi.getFormu().getChamp("compte").setVisible(false);  
    pi.getFormu().getChamp("Idjournal").setVisible(false);  
    pi.getFormu().getChamp("entite").setVisible(false);
    affichage.Liste[] listed = new affichage.Liste[1];
    TypeObjet operateur = new TypeObjet();
    operateur.setNomTable("type_facture_client");
    listed[0]=new Liste("typee",operateur,"val","id");
    pi.getFormu().changerEnChamp(listed);
    pi.getFormu().getChamp("Daty").setLibelle("Date");
    pi.getFormu().getChamp("typee").setLibelle("Type FC");
    pi.getFormu().getChamp("tiers").setLibelle("Client");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/clientCategorieChoix.jsp");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("etat").setAutre("readonly");
    pi.getFormu().getChamp("remarque").setLibelle("R&eacute;f&eacute;rence facture");
    pi.getFormu().getChamp("remarque").setAutre("readonly");
    
    pi.getFormufle().getChamp("designation_0").setLibelle("Designation");     
    pi.getFormufle().getChamp("medicament_0").setLibelle("Medicament");     
    pi.getFormufle().getChamp("idacte_0").setLibelle("Acte");     
    pi.getFormufle().getChamp("montant_0").setLibelle("Prix Unitaire");     
    pi.getFormufle().getChamp("montantremise_0").setLibelle("Montant Remise");     
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantité");     
    pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
    pi.getFormufle().getChamp("montantT_0").setLibelle("Montant");
    pi.getFormufle().getChamp("Id_0").setLibelle("ID");
    pi.getFormufle().getChamp("Idfacture_0").setLibelle("Facture");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idacte"),"readonly"); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("compteDebit"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("analDebit"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("montantremise"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("compteCredit"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("analCredit"),false);
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idFacture"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("quantite"), " onchange='calculMontant(this)' " );
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montant"), " onchange='calculMontant(this)' ");
//    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montantT"), " onchange='calculMontant(this)' ");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("montantT"), "readonly");
//    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("medicament"), "choix/listeMedFC.jsp", "medicament;designation;medicamentlibelle;montant;quantite");
     String[] colOrdreF={"id","idfacture","medicament","idacte","Designation","quantite","montant","montantT","remarque"};
   pi.getFormufle().setColOrdre(colOrdreF);
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
                %>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                    <%    
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    </div>
                </div>
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
    function calculMontant(elem){ 
        let i = elem.id.split("_")[1];
        console.log("elem",elem);
        console.log("i",i);
        document.getElementById("montantt_"+i).value = document.getElementById("quantite_"+i).value * document.getElementById("montant_"+i).value ;
    }                     
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>