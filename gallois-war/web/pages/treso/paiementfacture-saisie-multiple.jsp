<%@page import="facture.PaiementFacture"%>
<%@page import="user.UserEJB"%> 
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try{
    UserEJB u = null;
    String idUser= "";
    u = (UserEJB) session.getValue("u");
    idUser = ""+u.getUser().getTuppleID();

    String autreparsley = "data-parsley-range='[8, 40]' required";
    PaiementFacture  a = new PaiementFacture();   
    PaiementFacture details = new PaiementFacture();
    
    PageInsertMultiple pi = new PageInsertMultiple(a, details, request, 10, u);
    pi.setLien((String) session.getValue("lien"));

    String idmvt = request.getParameter("idmvt");
    String tiers = request.getParameter("tiers");
    
    String[] col={"tiers"};
    String[] val={tiers};
    
    for( int i = 0 ; i < pi.getNombreLigne() ; i++ ){
//        pi.getFormufle().getChamp("idMvt_"+i).setAutre( " readonly " );
//        pi.getFormufle().getChamp("idMvt_"+i).setDefaut(idmvt);
        pi.getFormufle().getChamp("idFact_"+i).setPageAppelAvecFiltre("choix/listeFactureClientViseeChoix.jsp", "idFact_"+i+";montant_"+i+";idFactlibelle_"+i, col, val);
        pi.getFormufle().getChamp("idFact_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("idMvt_"+i).setVisible(false);
    }
//    pi.getFormufle().getChamp("idMvt_0").setLibelle("Mouvement");     
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");     
    pi.getFormufle().getChamp("idFact_0").setLibelle("Facture"); 
    pi.getFormu().getChamp("montant").setAutre("onchange=\"setFilleValue('montant_0', this)\"");
    int taille = pi.getNombreLigne();
    for (int i = 0; i < taille; i++) {
        if (i == 0) {
            pi.getFormufle().getChamp("montant_" + i).setAutre("onchange=\"setOnblurInMere('montant_0', this)\"");
        }
        else {
            pi.getFormufle().getChamp("montant_" + i).setAutre("onchange=\"calculTotal()\"");
        }
    }
        
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 

    pi.preparerDataFormu();
       
%>
<style>
    .total-section {
        font-size: 25px;
        font-style: bold;
        padding: 10px;
        margin-right: 120px;
        float: right;
    }
    #totalAmount {
        margin: 0 50px;
    }
</style>
<div class="content-wrapper">
    <h1>Enregistrer Paiement Facture</h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="paiement" id="paiement">
        <div class="form-group row">
            <div class="col-md-3">
                <label for="idTraite">Mouvement</label>
                <input name="idmvt" type="text" id="idmvt" value="<%=idmvt%>" readonly>
            </div>

        </div>
        <%
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        
        <input name="acte" type="hidden" id="nature" value="insertPaiementFacture">
        <input name="bute" type="hidden" id="bute" value="treso/journalcaisse-fiche.jsp&id=<%=idmvt%>&tiers=<%=tiers%>">
        <input name="classe" type="hidden" id="classe" value="facture.PaiementFacture">
        <input name="classefille" type="hidden" id="classefille" value="facture.PaiementFacture">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">

    </form>

</div>
<script>
    function initTotalSection() {
        const engagementForm = document.getElementById('paiement');
        const boxFooterElmts = engagementForm.getElementsByClassName('box-footer');
        const lastFooter = boxFooterElmts[boxFooterElmts.length - 1];
        const parentNode = lastFooter.parentNode;
        const total = document.createElement("p");
        total.className = "total-section";
        total.innerHTML = "Total:<span id='totalAmount'>0</span>";

        parentNode.insertBefore(total, lastFooter);
    }
    
    function getValeurMontant(numLigne) {
        const valeur = Number($('#montant_' + numLigne).val());
        return !isNaN(valeur) ? valeur : 0;
    }

    function calculTotal() {
        let total = 0;
        const ligneTab = document.getElementById('ajout_multiple_ligne').children;
        
        for(let i=0; i < ligneTab.length; i++) {
            total += getValeurMontant(i);
        }

        const nouvelValeur = Intl.NumberFormat('fr-FR').format(total);
        $('#totalAmount').text(nouvelValeur);
    }

    $(document).ready(function () {
        initTotalSection();
        calculTotal();
    });
</script>
<script>
    function setOnblurInMere(idMere, elemFille) {
        console.log('calcul total');
        calculTotal();
        var elemMere = document.getElementById(idMere);
        if (elemMere && elemFille.value != "") {
            elemMere.onblur = calculTotal();
        }
    }
</script>  
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>

