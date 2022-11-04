<%@page import="facture.PaiementFacture"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%  
    
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PaiementFacture pf = new PaiementFacture();
    pf.setNomTable("paiementfacture");
    PageInsert pi = new PageInsert(pf, request, (user.UserEJB) session.getValue("u"));
    String id = request.getParameter("id");
    if(id!=null)
        pi.getFormu().getChamp("idmvt").setDefaut(id);
    pi.getFormu().getChamp("idmvt").setAutre("readonly");
    pi.getFormu().getChamp("idmvt").setLibelle("Mouvement");
    pi.getFormu().getChamp("idfact").setPageAppel("choix/listeFactureClientViseeChoix.jsp");
    pi.getFormu().getChamp("idfact").setAutre("readonly");
    pi.getFormu().getChamp("idfact").setLibelle("Facture");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie paiement facture</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>

    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="treso/paiementfacture-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="facture.PaiementFacture">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>