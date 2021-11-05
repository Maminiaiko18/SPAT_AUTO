<%@page import="facture.FactureFournisseur"%>
@@ -0,0 +1,100 @@
<%-- 
    Document   : bordereaux-saisie
    Created on : 21 janv. 2021, 09:41:08
    Author     : Sanda
--%>

<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="bordereau.BordereauFF"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="bean.CGenUtil"%>
<%@page import="bordereau.Bordereau"%>
<%@page import="bordereau.BordereauFilleFFLibComplet"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 

<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "bordereau.BordereauFF",
                classeFille = "bordereau.BordereauFilleFF",
                titre = "Saisie Bordereau Facture fournisseur",
                redirection = "ded/bordereauxFF-fiche.jsp",
                colonneMere = "idbordereau",
                nomSaisie = "Bordereau",
                nomFonctionSequence = "get_seqnumerobordereauFF";
        int taille = 10;
        String[] lesOp = new String[]{};
        FactureFournisseur[] factures = new FactureFournisseur[0];
        if (request.getParameter("idsOP") != null) {
//            lesOp = request.getParameter("idsOP").split(";");
            lesOp = Utilitaire.stringToTab(request.getParameter("idsOP"), ";");
            String afterW = " and id in ( " + Utilitaire.tabToString(lesOp, "'", ",") + ")";
            
            FactureFournisseur facture = new FactureFournisseur();
            facture.setNomTable("FACTFOURN_MSUM_LIB");
            
            factures = (FactureFournisseur[]) u.getData(facture, null, null, null, afterW);
            if (factures.length > 0) {
                taille = factures.length;
            }
        }

        BordereauFF mere = new BordereauFF();
        BordereauFilleFFLibComplet fille = new BordereauFilleFFLibComplet();
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("Etat").setVisible(false);
        pi.getFormu().getChamp("numero").setVisible(false);
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("daty").setLibelle("Date");

//        for( int i = 0 ; i < taille ; i++ ){
//            pi.getFormufle().getChamp("idop_"+i).setAutre("readonly");
//            pi.getFormufle().getChamp("idop_"+i).setPageAppel("choix/listeOrdonnerPayementChoix.jsp","idop;idoplibelle");
//        }
            for (int i = 0; i < taille; i++) {
                pi.getFormufle().getChamp("montant_" + i).setAutre("readonly");
                
                pi.getFormufle().getChamp("idop_" + i).setPageAppel("choix/listeFactureFournisseurChoix.jsp");
                pi.getFormufle().getChamp("idop_" + i).setAutre("readonly");
                
                if(i < lesOp.length) {
                    pi.getFormufle().getChamp("idop_" + i).setDefaut(lesOp[i]);
                    pi.getFormufle().getChamp("idop_" + i).setValeurLibelle(lesOp[i]);
                }
                if (i < factures.length) {
                    pi.getFormufle().getChamp("montant_" + i).setDefaut(factures[i].getMontantttc() + "");
                    pi.getFormufle().getChamp("idop_" + i).setDefaut(factures[i].getId());
                    pi.getFormufle().getChamp("idop_" + i).setValeurLibelle(factures[i].getId());
                }
            }
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idbordereau"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("remarque"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idfacture"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idbordereaulib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("code_etablissement"), false);
        pi.getFormufle().getChamp("idop_0").setLibelle("Facture");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");

        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="<%=nomSaisie%>" id="<%=nomSaisie%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
        <input name="nomFonctionSequence" type="hidden" id="colonneMere" value="<%=nomFonctionSequence%>">
    </form>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();
</script>
<% }%>