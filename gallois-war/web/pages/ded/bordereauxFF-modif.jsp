
<%@page import="bordereau.BordereauLibComplet"%>
<%@page import="bordereau.BordereauFilleFF"%>
<%@page import="bordereau.BordereauFF"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    BordereauLibComplet mere = new BordereauLibComplet();
    mere.setNomTable("bordereauFF_libcomplet");
    BordereauFilleFF fille = new BordereauFilleFF();
    
    
    fille.setIdbordereau(request.getParameter("id"));
    BordereauFilleFF[] liste = (BordereauFilleFF[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idbordereau"), "readonly");

    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idop"), "choix/listeFactureFournisseurChoix.jsp","idop;idoplibelle;idoplibelle");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("Etat").setAutre("readonly");
    pi.getFormu().getChamp("numero").setAutre("readonly");
    pi.getFormu().getChamp("Daty").setLibelle("Date");
    
    pi.getFormu().getChamp("tierslib").setVisible(false);
    
        for(int i=0; i < pi.getNombreLigne(); i++) {
            pi.getFormufle().getChamp("idop_" + i).setAutre("readonly");
            
            if(i < liste.length) pi.getFormufle().getChamp("idop_" + i).setDefaut(liste[i].getIdop());
        }
    
    pi.getFormufle().getChamp("Idop_0").setLibelle("Facture fournisseur");     
    pi.getFormufle().getChamp("Idbordereau_0").setLibelle("Bordereau");     
    pi.getFormufle().getChamp("id_0").setLibelle("ID");

    pi.preparerDataFormu();
    
// Initialisation valeurs champs défaut
    mere = (BordereauLibComplet) pi.getBase();
    pi.getFormu().getChamp("tiers").setValeurLibelle(mere.getTierslib());
%>
<div class="content-wrapper">
    <div class="row">
        <div class="box">

            <h1>Modification bordereau facture fournisseur</h1>

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
                <input name="bute" type="hidden" id="bute" value="ded/bordereauxFF-fiche.jsp?id=<%=request.getParameter("id")%>">
                <input name="classe" type="hidden" id="classe" value="bordereau.BordereauFF">
                <input name="classefille" type="hidden" id="classefille" value="bordereau.BordereauFilleFF">
                <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                <input name="colonneMere" type="hidden" id="colonneMere" value="idbordereau">
                
                
            </form>
        </div>
    </div>
</div>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>