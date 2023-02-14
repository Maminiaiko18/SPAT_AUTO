<%@page import="facture.FactureClientAvoir"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="facture.FactureClient"%>
<%  
    
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureClientAvoir pf = new FactureClientAvoir();
    PageInsert pi = new PageInsert(pf, request, (user.UserEJB) session.getValue("u"));
    String id = request.getParameter("idFC");
    String[] col = {"idtiers"};
    String tiers = "";
    String[] val = null;
    FactureClient e = new FactureClient();
    e = (FactureClient) new FactureClient().getById(id, "facture_client_union_ordre", null);
    if(e != null){
        pi.getFormu().getChamp("montant").setDefaut(Utilitaire.formaterAr(e.getMontantreste()));
        val = new String[1];
        val[0] = e.getTiers();
    }
    
    if(id!=null)
        pi.getFormu().getChamp("idfc").setDefaut(id);
    
    pi.getFormu().getChamp("idfc").setAutre("readonly");
    pi.getFormu().getChamp("idfc").setLibelle("Facture client");
    pi.getFormu().getChamp("idavoir").setLibelle("Avoirs");
    pi.getFormu().getChamp("montant").setAutre("readonly");
    pi.getFormu().getChamp("idavoir").setAutre("readonly");
    pi.getFormu().getChamp("idavoir").setPageAppelAvecFiltre("choix/avoir-montant-reste.jsp", "idavoir;idavoirlibelle", col, val);
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Régulariser Avoir</h1>
    <form action="<%=pi.getLien()%>?but=apresRegulariserAvoir.jsp&id=<%=id%>" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>

    <input name="acte" type="hidden" id="nature" value="regulariser">
    <input name="id" type="hidden" id="nature" value="<%=id%>">
    <input name="bute" type="hidden" id="bute" value="facture/factureclient-fiche-vaovao.jsp">
    <input name="classe" type="hidden" id="classe" value="facture.FactureClientAvoir">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>