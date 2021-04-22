<%-- 
    Document   : contract-fournisseur-saisie
    Created on : 10 déc. 2019, 19:24:05
    Author     : HP
--%>

<%@page import="mg.spat.ContratFournisseur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ContratFournisseur pj = new ContratFournisseur();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("ville").setVisible(false);
    pi.getFormu().getChamp("beneficiaire").setVisible(false);
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("mode_reglement");
    String [] val = {"Espece", "Cheque", "Mobile money"};
    String [] aff = {"Espece", "Cheque", "Mobile money"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("mode_reglement").setLibelle("Mode de reglement");
    pi.getFormu().getChamp("condition_reglement").setLibelle("Condition reglement");
    pi.getFormu().getChamp("ref_fournisseur").setLibelle("Ref fournisseur");
    pi.getFormu().getChamp("cp").setLibelle("Code postal");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un Contrat Fournisseur</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/bon-commande/contrat-fournisseur-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.ContratFournisseur">
    </form>
</div>
<%}catch(Exception e){ %>
    e.printStackTrace();
    <script language="JavaScript">alert('<%=e.getMessage()%>');history.back();</script>
<% }%>
