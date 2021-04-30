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
               titre = "Saisie Bordereau FF",
			   redirection = "ded/bordereauxFF-fiche.jsp",
			   colonneMere = "idbordereau",
               nomSaisie = "Bordereau";
        int taille = 10;
        String[] lesOp = new String[]{};
        EtatFactureMontantDaty[] facture = new EtatFactureMontantDaty[0];
        if(request.getParameter("idsOP") != null) {
//            lesOp = request.getParameter("idsOP").split(";");
            lesOp = Utilitaire.stringToTab(request.getParameter("idsOP"),";");
            String afterW =" and id in ( " + Utilitaire.tabToString(lesOp, "'", ",") + ")" ;
            System.out.println("OPS ---- "+afterW);
            facture = (EtatFactureMontantDaty[]) CGenUtil.rechercher(new EtatFactureMontantDaty(), null, null, null, afterW);
            taille = facture.length;
        }
        
        BordereauFF mere = new BordereauFF();
        BordereauFilleFFLibComplet fille = new BordereauFilleFFLibComplet();
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("Etat").setVisible(false);
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("daty").setLibelle("Date");
        
//        for( int i = 0 ; i < taille ; i++ ){
//            pi.getFormufle().getChamp("idop_"+i).setAutre("readonly");
//            pi.getFormufle().getChamp("idop_"+i).setPageAppel("choix/listeOrdonnerPayementChoix.jsp","idop;idoplibelle");
//        }
        if(lesOp.length >0){
            for(int i = 0 ; i < taille ; i++){
                pi.getFormufle().getChamp("montant_"+i).setAutre("readonly");
                pi.getFormufle().getChamp("montant_"+i).setDefaut(facture[i].getMontantTTC()+"");
                pi.getFormufle().getChamp("idop_"+i).setDefaut(facture[i].getId());
                pi.getFormufle().getChamp("idop_"+i).setValeurLibelle(facture[i].getId());
            }
        }
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idbordereau"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("remarque"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idfacture"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idbordereaulib"), false);
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