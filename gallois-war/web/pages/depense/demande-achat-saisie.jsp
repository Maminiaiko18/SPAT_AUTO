<%@page import="utilisateur.Utilisateur"%>
<%@page import="affichage.Liste"%>
<%@page import="user.*"%> 
<%@page import="mg.spat.DemandeAchatMere"%>
<%@page import="mg.spat.DemandeAchatFille"%>
<%@page import="data.*"%>
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
        pi.getFormu().getChamp("codeetablissement").setLibelle("Code Etablissement");
        pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        //pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp");
        //pi.getFormu().getChamp("idengagement").setAutre("readonly");
        pi.getFormu().getChamp("idengagement").setVisible(false);
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("designation").setType("textarea");
        pi.getFormu().getChamp("daty").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pi.getFormu().getChamp("num").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
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
        
        String idEngagement = request.getParameter("idEngagement");
        DemandeAchatData dmdAchData = new DemandeAchatData();
        if(idEngagement != null && idEngagement.compareToIgnoreCase("") != 0) {
            dmdAchData.getDemandeAchatByEngagement(idEngagement);
            if(dmdAchData.getDemandeAchatMere() != null) {
                pi.getFormu().getChamp("codeEtablissement").setDefaut(Utilitaire.champNull(dmdAchData.getDemandeAchatMere().getCodeetablissement()));
                pi.getFormu().getChamp("projet").setDefaut(Utilitaire.champNull(dmdAchData.getDemandeAchatMere().getProjet()));
            }
            if(dmdAchData.getDemandeAchatFille() != null) {
                for(int i=0; i<10; i++) {
                    pi.getFormufle().getChamp("designation_"+i).setValeur(Utilitaire.champNull(dmdAchData.getDemandeAchatFille().getDesignation()));
                    pi.getFormufle().getChamp("pu_"+i).setValeur(Utilitaire.champNull(""+dmdAchData.getDemandeAchatFille().getMontant()));
                    pi.getFormufle().getChamp("qte_"+i).setValeur("1");
                }
            }
        }
        
        pi.preparerDataFormu();

%>
<div class="content-wrapper">
    <h1>Saisie DASE</h1>
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
    <% if (idEngagement != null) {%>
    $("#codeetablissementlibelle").val("<%= Utilitaire.champNull(dmdAchData.getDemandeAchatMere().getCodeetablissementlib())%>");
    $("#projetlibelle").val("<%= Utilitaire.champNull(dmdAchData.getDemandeAchatMere().getProjetlib())%>");
    <% } %>
</script>
<script>
    console.log("mande");
    var footer = document.getElementsByClassName('box-footer')[1].querySelector("div");
    var tot = document.createElement('p');
    tot.readOnly = true;
    tot.type = "text";
    tot.id = "total";
    tot.style.fontSize = "21px";
    tot.style.color = "blue";
    tot.classList= ["pull-left"];
//    tot.style.top = "-38px";
    footer.appendChild(tot);
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
        $('#total').text("Total: "+ new Intl.NumberFormat('fr-FR').format(total));
    }

    <% for (int i = 0; i < pi.getNombreLigne(); i++) {%>
    $('#qte_<%= i%>, #pu_<%= i%>').attr('onblur', 'calculerMontant(<%= i%>),Total()');
    $('#montant_<%= i%>').attr('onblur', 'Total()');
    <% } %>

    Total();
    window.onload = () =>{
        var submitBtns = document.querySelectorAll("button[name='Submit2'][type='submit']");
        for(var i=0; i < submitBtns.length; i++){
            modifySubmitBtn(submitBtns[i]);    
        }
    }
    
    function modifySubmitBtn(btn){
        btn.setAttribute("type","button");
        btn.onclick = save;
    }
    
    function save() {
        var btn = this;
        btn.disabled = true;
        var query = $('#demandeAchat').serialize();
        $.get("apresMultipleAjax.jsp?"+query, function(data, status){
            var temp = data.trim().split("_");
            if(temp[0] === 'error'){
                btn.disabled = false;
                alert(temp[1]);
            }
            else{
                window.location.href = "<%=pi.getLien()%>?but=depense/demande-achat-fiche.jsp&id="+temp[1];
            }
        });
    }
    
    function add_line_tab(champ){
        var firstElement = document.getElementById("ajout_multiple_ligne").lastChild.innerHTML;
        var indiceNew = $("#ajout_multiple_ligne tr").length;
        console.log("firstElement",firstElement)
        var indiceAvant = indiceNew-1;
        var selectElement = document.getElementById("unite_"+indiceAvant);
        var contenu = '<select name="unite_'+indiceNew +'" class="form-control" id="unite_'+indiceNew +'" >'+selectElement.innerHTML + '</select>';
        //var newElem = firstElement.toString().replaceAll(/(?<=[^0-9])0(?=[^0-9])/g, ''+indiceNew);
        var newElem = firstElement.replaceAll(/[0-9]/g, indiceNew);
        newElem = newElem.replaceAll(indiceNew+""+indiceNew, indiceNew);
        console.log("newElen",newElem)
        $("#ajout_multiple_ligne").append("<tr id='ligne-multiple-"+indiceNew+"'>"+newElem+"</tr>");
        $("#nombreLigne").val(indiceNew+1);
        var parentElement = document.getElementById("unite_"+indiceNew).parentNode; 
        parentElement.innerHTML = contenu;

    }



    function add_line_tabs(champ){
        var firstElement = document.getElementById("ajout_multiple_ligne").lastChild.innerHTML;
        
        for(let i=0;i<10;i++){
            var indiceNew = $("#ajout_multiple_ligne tr").length;
            var indiceAvant = indiceNew-1
            var selectElement = document.getElementById("unite_"+indiceAvant);
            var contenu = '<select name="unite_'+indiceNew +'" class="form-control" id="unite_'+indiceNew +'" >'+selectElement.innerHTML+ '</select>';
            //var newElem = firstElement.replaceAll(/(?<=[^0-9])0(?=[^0-9])/g, (indiceNew+i));
            var newElem = firstElement.replaceAll(/[0-9]/g, indiceNew);
            newElem = newElem.replaceAll(indiceNew+""+indiceNew, indiceNew);
            newElem = newElem.replaceAll(indiceNew+""+indiceNew+""+indiceNew+""+indiceNew, indiceNew);
            $("#ajout_multiple_ligne").append("<tr id='ligne-multiple-"+(indiceNew)+"'>"+newElem+"</tr>");
            $("#nombreLigne").val(indiceNew+(1));
            var parentElement = document.getElementById("unite_"+indiceNew).parentNode;
            parentElement.innerHTML = contenu;

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
