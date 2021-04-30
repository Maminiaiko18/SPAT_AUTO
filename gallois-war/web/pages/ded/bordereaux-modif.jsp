
<%@page import="bordereau.BordereauFille"%>
<%@page import="bordereau.Bordereau"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Bordereau mere = new Bordereau();
    BordereauFille fille = new BordereauFille();
    fille.setIdbordereau(request.getParameter("id"));
    BordereauFille[] liste = (BordereauFille[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idbordereau"), "readonly");
//    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idop"), "readonly");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idop"), "choix/listeOrdonnerPayementChoix.jsp","idop;",true);
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("Etat").setAutre("readonly");
    pi.getFormu().getChamp("Daty").setLibelle("Date");
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
    pi.getFormufle().getChamp("Idop_0").setLibelle("Ordre de paiement");     
    pi.getFormufle().getChamp("Idbordereau_0").setLibelle("Bordereau");     
    pi.getFormufle().getChamp("id_0").setLibelle("ID");
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
            <h1>Modification bordereau OP</h1>
            <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    pi.getFormufle().makeHtmlInsertTableauIndex();
                    out.println(pi.getFormu().getHtmlInsert());
                %>
                   <center style="margin-bottom: 10px;"> <a class="btn btn-success button-margin"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=ded/bordereaux-fiche.jsp&classe=bordereau.Bordereau">Viser</a> </center>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <%
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                    </div>
                </div>

                <input name="acte" type="hidden" id="nature" value="updateInsert">
                <input name="bute" type="hidden" id="bute" value="ded/bordereaux-modif.jsp?id=<%=request.getParameter("id")%>">
                <input name="classe" type="hidden" id="classe" value="bordereau.Bordereau">
                <input name="classefille" type="hidden" id="classefille" value="bordereau.BordereauFille">
                <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                <input name="colonneMere" type="hidden" id="colonneMere" value="idbordereau">

            </form>
        </div>
    </div>
</div>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>