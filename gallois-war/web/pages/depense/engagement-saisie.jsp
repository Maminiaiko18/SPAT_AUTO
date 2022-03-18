<%-- 
    Document   : additif-saisie
    Created on : 18 d�c. 2020, 09:27:13
    Author     : Sanda
--%>

<%@page import="affichage.Liste"%>
<%@page import="mg.spat.EngagementFille"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="avoir.Avoir"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="mg.spat.Engagement"%> 
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = (user.UserEJB) session.getValue("u");
        String mapping = Engagement.class.getName(),
                nomtable = "engagement",
                mappingFille = EngagementFille.class.getName(),
                colonneMere = "idmere",
                apres = "depense/engagement-fiche.jsp",
                titre = "Nouvel Engagement";

        Engagement objet = new Engagement();
        EngagementFille objetFille = new EngagementFille();
        int nbLigne = 10;

        PageInsertMultiple pi = new PageInsertMultiple(objet, objetFille, request, nbLigne, u);
        pi.setLien((String) session.getValue("lien"));

        Liste[] listes = new Liste[1];
        String[] avecFactureAff = {"oui", "non"};
        String[] avecFactureVal = {"1", "0"};
        listes[0] = new Liste("avecFacture", avecFactureAff, avecFactureVal);

        pi.getFormu().changerEnChamp(listes);

        pi.getFormu().getChamp("etat").setVisible(false);

        pi.getFormu().getChamp("codeEtablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("codeEtablissement").setAutre("readonly");
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("idLC").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLC;idLClibelle;idLClibelle;idLClibelle");
        pi.getFormu().getChamp("idLC").setAutre("readonly");

        pi.getFormu().getChamp("compte").setVisible(false);
        pi.getFormu().getChamp("num").setVisible(false);
        pi.getFormu().getChamp("avecFacture").setLibelle("Avec Facture");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("codeEtablissement").setLibelle("Code &Eacute;tablissement");
        pi.getFormu().getChamp("dispoAvant").setVisible(false);
        pi.getFormu().getChamp("dispoApres").setVisible(false);
        pi.getFormu().getChamp("disponible").setVisible(false);
        pi.getFormu().getChamp("idLC").setLibelle("Budget");
        pi.getFormu().getChamp("daty").setLibelle("Date");

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        pi.getFormufle().getChamp("designation_0").setLibelle("D&eacute;signation");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");

        if (u.getCodeEtablissement() != null) {
            pi.getFormu().getChamp("codeEtablissement").setDefaut(Utilitaire.champNull(u.getCodeEtablissement().getId()));
        }
        pi.getFormu().getChamp("designation").setAutre("onchange=\"setFilleValue('designation_0', this)\"");
        pi.getFormu().getChamp("montant").setAutre("onchange=\"setFilleValue('montant_0', this)\"");
        int taille = pi.getNombreLigne();
        for (int i = 0; i < taille; i++) {
            if (i == 0) {
                pi.getFormufle().getChamp("designation_" + i).setAutre("onchange=\"setOnblurInMere('designation_0', this)\"");
                pi.getFormufle().getChamp("montant_" + i).setAutre("onchange=\"setOnblurInMere('montant_0', this)\"");
            }
            else {
                pi.getFormufle().getChamp("montant_" + i).setAutre("onchange=\"calculTotal()\"");
            }
        }
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
    <h1> <%=titre%></h1>

    <form action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="classefille" type="hidden" id="classefille" value="<%= mappingFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nbLigne%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere%>">

    </form>
</div>
<script>
    function initTotalSection() {
        const engagementForm = document.getElementById('engagement');
        const boxFooterElmts = engagementForm.getElementsByClassName('box-footer');
        const lastFooter = boxFooterElmts[boxFooterElmts.length - 1];
        const parentNode = lastFooter.parentNode;
        const total = document.createElement("p");
        total.className = "total-section";
        total.innerHTML = "Total:<span id='totalAmount'>0</span>";

        parentNode.insertBefore(total, lastFooter);
    }

    $(document).ready(function () {
        initTotalSection();
        calculTotal();

    });
</script>
<script>
    <% if (u.getCodeEtablissement() != null) {%>
    $("#codeEtablissementlibelle").val("<%= Utilitaire.champNull(u.getCodeEtablissement().getVal())%>");
    <% } %>
    function setFilleValue(idFille, elem) {
        var elemFille = document.getElementById(idFille);
        if (elemFille) {
            elemFille.value = elem.value;
        }
    }

    function getValeurMontant(numLigne) {
        const valeur = Number($('#montant_' + numLigne).val());
        return !isNaN(valeur) ? valeur : 0;
    }

    function calculTotal() {
        let total = 0;
    <% for (int i = 0; i < pi.getNombreLigne(); i++) { %>
        total += getValeurMontant(<%=i%>);
    <%}%>

        const nouvelValeur = Intl.NumberFormat('fr-FR').format(total);
        $('#totalAmount').text(nouvelValeur);
    }

    function setOnblurInMere(idMere, elemFille) {
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
    history.back();</script>
    <% }%>
