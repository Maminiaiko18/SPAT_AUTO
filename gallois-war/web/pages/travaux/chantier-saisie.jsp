<%@page import="bean.CGenUtil"%>
<%@page import="mg.spat.Travaux"%>
<%@page import="user.UserEJB"%> 
<%@page import="affichage.PageInsert"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.Chantier"%>
<%@page import="detailschantier.DetailChantier"%>
<%@page import="mg.spat.ChantierLibComplet"%>
<%@page import="utilitaire.Utilitaire"%>

<%

    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String mapping = "mg.spat.Chantier",
                nomtable = "chantier",
                apres = "travaux/chantier-fiche.jsp",
                titre = "Nouveau chantier";

        Chantier objet = new Chantier();
        PageInsert pi = new PageInsert(objet, request, u);
        pi.setLien((String) session.getValue("lien"));
        Travaux t = new Travaux();
        t.setNomTable("travauxlib");
        Travaux[] travaux = (Travaux[])CGenUtil.rechercher(t,null,null,null," and id = '"+request.getParameter("idtravaux")+"' ");
        if (request.getParameter("idtravaux") != null) {
            pi.getFormu().getChamp("idtravaux").setDefaut(request.getParameter("idtravaux"));
            pi.getFormu().getChamp("idtravaux").setValeurLibelle(travaux[0].getNom());
        }
        pi.getFormu().getChamp("idpatrimoine").setDefaut(travaux[0].getIdpatrimoine());
        pi.getFormu().getChamp("idpatrimoine").setValeurLibelle(travaux[0].getPatrimoinelib());
        
        pi.getFormu().getChamp("idpatrimoine").setAutre("readonly");
        pi.getFormu().getChamp("idpatrimoine").setNom("idpatrimoine");
        pi.getFormu().getChamp("idtravaux").setPageAppel("choix/listeTravauxChoix.jsp","idtravaux;idtravauxlibelle;idpatrimoine;idpatrimoinelibelle");
        pi.getFormu().getChamp("idpatrimoine").setPageAppel("choix/listePatrimoineChoix.jsp");
        pi.getFormu().getChamp("idtravaux").setAutre("readonly");
        pi.getFormu().getChamp("datydebut").setAutre("Date de d&eacute;but");
        pi.getFormu().getChamp("datydebut").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("datyfin").setAutre("Date de fin");
        pi.getFormu().getChamp("datyfin").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("idtiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("idtiers").setAutre("readonly");
        pi.getFormu().getChamp("idtiers").setLibelle("Tiers");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("avancement").setVisible(false);
        pi.getFormu().getChamp("idtravaux").setLibelle("projet");
        pi.getFormu().getChamp("datydebut").setLibelle("Date debut");
        pi.getFormu().getChamp("datyfin").setLibelle("Date fin");
        pi.getFormu().getChamp("nom").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("projet").setLibelle("Code projet");
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("codeetablissement").setLibelle("Code etablissement");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
        pi.getFormu().getChamp("idpatrimoine").setLibelle("Patrimoine");

        pi.preparerDataFormu();
%>

<div class="content-wrapper">
    <h1> <%=titre%></h1>

    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>
<script>
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
        var query = $('#chantier').serialize();
        $.get("apresAjax.jsp?"+query, function(data, status){
            var temp = data.trim().split("_");
            if(temp[0] === 'error'){
                btn.disabled = false;
                alert(temp[1]);
            }
            else{
                window.location.href = "<%=pi.getLien()%>?but=travaux/chantier-fiche.jsp&id="+temp[1];
            }
        });
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