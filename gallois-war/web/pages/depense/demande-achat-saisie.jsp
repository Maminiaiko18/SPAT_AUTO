<%@page import="utilisateur.Utilisateur"%>
<%@page import="affichage.Liste"%>
<%@page import="user.*"%> 
<%@page import="mg.spat.DemandeAchatMere"%>
<%@page import="mg.spat.DemandeAchatFille"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try {
        UserEJB u = null;
        String idUser = "";
        u = (UserEJB) session.getValue("u");
        idUser = "" + u.getUser().getTuppleID();
        String classeMere = DemandeAchatMere.class.getName(),
                classeFille = DemandeAchatFille.class.getName(),
                colonneMereDansFille = "idmere";
        String js = "";
        String id = request.getParameter("id");
        String autreparsley = "data-parsley-range='[8, 40]' required";
        DemandeAchatMere dam = new DemandeAchatMere();
        DemandeAchatFille dafille = new DemandeAchatFille();
        dafille.setIdmere(id);
        dafille.setNomTable("DEM_ACHAT_FILLELIB");
        PageInsertMultiple pi = new PageInsertMultiple(dam, dafille, request, 10, u);
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp");
        pi.getFormu().getChamp("idengagement").setAutre("readonly");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("daty").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pi.getFormu().getChamp("num").setVisible(false);
        pi.getFormufle().getChamp("designation_0").setLibelle("D&eacute;signation");
        pi.getFormufle().getChamp("id_0").setLibelle("Id");
        pi.getFormufle().getChamp("produit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("pu_0").setLibelle("Pu");
        pi.getFormufle().getChamp("qte_0").setLibelle("Qte");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
        Liste[] listef = new Liste[1];
        TypeObjet baseUnite = new TypeObjet();
        baseUnite.setNomTable("UNITECHANTIER");
        listef[0] = new Liste("unite", baseUnite, "val", "id");
        pi.getFormufle().changerEnChamp(listef);
        pi.getFormufle().getChamp("unite_0").setLibelle("Unit&eacute;");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("produitlib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("unitelib"), false);
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("produit"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("unitelib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        String mere = request.getParameter("idmere");
        if (mere != null && mere.compareToIgnoreCase("") != 0) {
            pi.getFormu().getChamp("idmere").setDefaut(mere);
        }
        int taille = pi.getNombreLigne();
        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("produit"), "choix/produitChoix.jsp", "produit;produitlibelle;produitlibelle;produitlibelle;produitlibelle;designation");
        pi.preparerDataFormu();

%>
<div class="content-wrapper">
    <h1>Demande d'achat</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="demandeAchat" id="demandeAchat">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="depense/demande-achat-fiche.jsp">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="idmere">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille%>">

    </form>

</div>
<script>
    console.log("mande");
    var footer = document.getElementsByClassName('box-footer');
    var tot = document.createElement('input');
    tot.readOnly = true;
    tot.type = "text";
    tot.id = "total";
    tot.style.border = 0;
    tot.style.fontSize = "21px";
    tot.style.color = "blue";
    tot.style.position = "relative";
    tot.style.top = "-38px";
    footer[1].appendChild(tot);
    function getMontant(i) {
        var qteStr = $('#qte_' + i).val().trim();
        var puStr = $('#pu_' + i).val().trim();
        var qte = qteStr === '' ? 0 : parseFloat(qteStr);
        var pu = puStr === '' ? 0 : parseFloat(puStr);
        return qte * pu;
    }

    function calculerMontant(i) {
        $('#montant_' + i).val(getMontant(i));
    }

    function Total() {
        var total = 0;
    <% for (int j = 0; j < pi.getNombreLigne(); j++) {%>
        var montantstr = $('#montant_<%= j%>').val().trim();
        var montant = montantstr === '' ? 0 : parseFloat(montantstr);
        total += montant;
    <% } %>
        $('#total').val("Total: "+total);
    }

    <% for (int i = 0; i < pi.getNombreLigne(); i++) {%>
    $('#qte_<%= i%>, #pu_<%= i%>').attr('onblur', 'calculerMontant(<%= i%>),Total()');
    $('#montant_<%= i%>').attr('onblur', 'Total()');
    <% } %>

    Total();
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
