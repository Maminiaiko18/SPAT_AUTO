<%-- 
    Document   : transfert-caisse-modif
    Created on : 16 janv. 2021, 01:09:34
    Author     : andya
--%>
<%@page import="lc.Direction"%>
<%@page import="mg.spat.Caisse"%>
<%@page import="mg.spat.MvttIntraCaisse"%>
<%@page import="mg.spat.MvtIntraCaisseFille"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String titrePage = "Modification transfert caisse",
                classeMere = "mg.spat.MvttIntraCaisse",
                classeFille = "mg.spat.MvtIntraCaisseFille",
                buteLien = "treso/ transfert-caisse-fiche.jsp",
                colonneMereDansFille = "idmere",
                buteApresVisa = "treso/transfert-caisse-fiche.jsp";
        String autreparsley = "data-parsley-range='[8, 40]' required";
        MvttIntraCaisse mere = new MvttIntraCaisse();

        MvtIntraCaisseFille fille = new MvtIntraCaisseFille();
        fille.setNomTable("mvtintracaisse_fille");
        fille.setIdmere(request.getParameter("id"));
        MvtIntraCaisseFille[] liste = (MvtIntraCaisseFille[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
        pi.setLien((String) session.getValue("lien"));

          affichage.Champ[] list = new affichage.Champ[3];
            Caisse liste1 = new Caisse();
            liste1.setNomTable("caisse");
            list[0] = new Liste("caissedepart", liste1, "val", "id");
            list[1] = new Liste("caissearrivee", liste1, "val", "id");
            TypeObjet liste2 = new TypeObjet();
            liste2.setNomTable("MODEPAIEMENT");
            list[2] = new Liste("modepaiement", liste2, "val", "id");
            pi.getFormu().changerEnChamp(list);

            pi.getFormu().getChamp("etat").setVisible(false);
            pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
            pi.getFormu().getChamp("daty").setLibelle("Date");
            pi.getFormu().getChamp("caissedepart").setLibelle("D&eacute;part");
            pi.getFormu().getChamp("caissearrivee").setLibelle("Arriv&eacute;e");
            pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
            pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");

           pi.getFormufle().getChamp("Reference_0").setLibelle("R&eacute;ference");
           pi.getFormufle().getChamp("Remarque_0").setLibelle("Remarque");

        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("idmere"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"),false);


        pi.getFormufle().getChamp("Id_0").setLibelle("Id");


        mere = (MvttIntraCaisse) pi.getBase();
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="box">
        <h1><%= titrePage%></h1>
        <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
            <%
                pi.getFormu().makeHtmlInsertTabIndex();
                pi.getFormufle().makeHtmlInsertTableauIndex();
                out.println(pi.getFormu().getHtmlInsert());
            %>
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <%
                        out.println(pi.getFormufle().getHtmlTableauInsert());
                    %>
                </div>
            </div>

            <input name="acte" type="hidden" id="nature" value="updateInsert">
            <input name="bute" type="hidden" id="bute" value="<%= buteLien%>?id=<%=request.getParameter("id")%>">
            <input name="classe" type="hidden" id="classe" value="<%= classeMere%>">
            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille%>">
            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille%>">

        </form>
    </div>
</div>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>


