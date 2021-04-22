<%-- 
    Document   : regularisation
    Created on : 30 déc. 2020, 20:51:54
    Author     : Sanda
--%>

<%@page import="mg.spat.BonProvisoire"%>
<%@page import="bon.RegulBP"%>
<%@page import="facturefournisseur.RegulFacture"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="utilitaire.Utilitaire"%> 
<%
    try {
//        String idfacture = "", apresFacture = "";
//        if(request.getParameter("idfacture") != null){
//            idfacture = request.getParameter("idfacture") ;
//            apresFacture = "&id=" + idfacture;
//        }
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = (user.UserEJB) session.getValue("u");
        String mapping = "bon.RegulBP",
                nomtable = "regulbp",
                apres = "treso/regulBP-fiche.jsp",
                titre = "Regularisation BP";
        String idbon = request.getParameter("idbon");
        
        RegulBP objet = new RegulBP();
        objet.setNomTable(nomtable);
        
        PageInsert pi = new PageInsert(objet, request, u);
        pi.setLien((String) session.getValue("lien"));
        
        if(idbon != null && !idbon.equalsIgnoreCase("")) {
            objet.setIdbon(idbon);
            pi.getFormu().getChamp("idbon").setDefaut(idbon);
        }
        
        pi.getFormu().getChamp("idbon").setLibelle("Bon Provisoire");
        pi.getFormu().getChamp("idbon").setAutre("readonly");
        pi.getFormu().getChamp("idbon").setPageAppel("choix/listeBonProvisoireChoix.jsp");
        pi.getFormu().getChamp("montant").setAutre("readonly");

        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());

        pi.getFormu().getChamp("montant").setDefaut(Utilitaire.formaterAr(objet.getMontantReste(null)));

        pi.getFormu().getChamp("iduser").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);

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
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();</script>
    <% }%>
