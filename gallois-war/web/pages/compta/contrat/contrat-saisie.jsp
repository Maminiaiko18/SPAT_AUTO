

<%@page import="mg.spat.ClientCategorie"%>
<%@page import="mg.spat.compta.Contrat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%  
    
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Contrat pj = new Contrat();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("idTiers").setLibelle("Tiers");
    pi.getFormu().getChamp("idTiers").setAutre("readonly");
    pi.getFormu().getChamp("idTiers").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("date_signature").setLibelle("Date de signature");
    pi.getFormu().getChamp("date_signature").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("debut_contrat").setLibelle("Date de début de contrat");
    pi.getFormu().getChamp("debut_contrat").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("fin_contrat").setLibelle("Date de fin de contrat");
    pi.getFormu().getChamp("droit_entree").setLibelle("Droit d'entrée");
    pi.getFormu().getChamp("redevance_fixe").setLibelle("Redevance fixe");
    pi.getFormu().getChamp("redevance_variable").setLibelle("Redevance variable");
    pi.getFormu().getChamp("droit_port").setLibelle("Droit de port");
        pi.getFormu().getChamp("redevance_domaniale").setLibelle("Redevance domaniale");
    pi.getFormu().getChamp("redevance_locative").setLibelle("Redevance locative");
    pi.getFormu().getChamp("pipeline").setLibelle("Pipeline");
    pi.getFormu().getChamp("typedroitport").setLibelle("Type droit port");
    pi.getFormu().getChamp("typeduree").setLibelle("Type durée");
    
    affichage.Champ[] liste = new affichage.Champ[4];
  
    TypeObjet mn1 = new TypeObjet();
           mn1.setNomTable("unite");
    liste[0] = new Liste("unite", mn1, "val", "id");
    
    TypeObjet mn2 = new TypeObjet();
    mn2.setNomTable("devisedemat");
    liste[1] = new Liste("devise", mn2, "val", "id");
    
    TypeObjet mn3 = new TypeObjet("TYPEDROITPORT");
    liste[2] = new Liste("typedroitport", mn3, "val", "id");
    
    TypeObjet mn4 = new TypeObjet("TYPEDUREE");
    liste[3] = new Liste("typeduree", mn4, "val", "id");
    
    pi.getFormu().changerEnChamp(liste);
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie de contrat</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>

    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="compta/contrat/contrat-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.compta.Contrat">
    </form>
</div>
        
        <script>
    function calculRedevence() {
        var domaniale = jQuery('#redevance_domaniale').val();
        var locative = jQuery('#redevance_locative').val();
        var pipeline = jQuery('#pipeline').val();

        if (jQuery.isNumeric(domaniale) && jQuery.isNumeric(locative)  && jQuery.isNumeric(pipeline)) {
            var montant = Number(domaniale)+Number(locative)+Number(pipeline);
            jQuery('#redevance_fixe').val(montant);
            
        }
    }
    
    
    jQuery(document).ready(function () {
        
        jQuery('#redevance_domaniale').keyup(function () {
            calculRedevence();
        });
         jQuery('#redevance_locative').keyup(function () {
            calculRedevence();
        });
         jQuery('#pipeline').keyup(function () {
            calculRedevence();
        });
        
    });

    
    
    
</script>

<%}catch(Exception e){
    e.printStackTrace();
}%>