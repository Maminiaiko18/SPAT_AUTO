<%-- 
    Document   : activites-saisie
    Created on : 18 mai 2021, 16:24:17
    Author     : nyamp
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="lignecredit.LigneCredit"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.Champ" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageInsert" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    
    String nomtable = "ligneCreditDepense";
    
    LigneCredit obj = new LigneCredit();
    obj.setNomTable(nomtable);
    PageInsert pi = new PageInsert(obj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp","projet;projetlibelle;projetdesce");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("codeEtablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp","codeEtablissement;codeEtablissementlibelle;codeEtablissementdesce");
    pi.getFormu().getChamp("codeEtablissement").setAutre("readonly");
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("annee").setLibelle("Ann&eacute;e");
    pi.getFormu().getChamp("quantite").setLibelle("Quantit&eacute;");
    pi.getFormu().getChamp("codeEtablissement").setLibelle(" Code direction");
    pi.getFormu().getChamp("annee").setDefaut(Utilitaire.getAnneeEnCours());
    pi.getFormu().getChamp("compteg").setVisible(false); 
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("quantite").setVisible(false);

    pi.getFormu().setOrdre(new String[] {"designation", "montant", "annee", "codeEtablissement","projet","compte","compteg","etat","quantite"});

    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie ligne cr&eacute;dit d&eacute;penses</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="lignecredit" id="lignecredit" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="codeEtablissementdesce" type="hidden" id="codeEtablissementdesce" value>
    <input name="projetdesce" type="hidden" id="projetdesce" value>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="ligneCredit/fiche-ligneCreditDepense.jsp">
    <input name="classe" type="hidden" id="classe" value="lignecredit.LigneCredit">
    <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>

<script>
    $("#codeEtablissementdesce, #projetdesce").change(function() {
        changeCode();
    });
    
    function changeCode(){
        $("#compte").val(addChampsValuesLibelle($("#codeEtablissementdesce").val(),$("#projetdesce").val()));
    }
    
    function addChampsValuesLibelle(...others) {
        var arrayChampsValuesLibelle = [];
        for(let i=0; i<others.length; i++) { 
          if(others[i] !== null) {
            arrayChampsValuesLibelle.push(others[i]);
          }
        }
        return arrayChampsValuesLibelle.join("");
    }
</script>
<%}catch(Exception e){
    e.printStackTrace();
}%>