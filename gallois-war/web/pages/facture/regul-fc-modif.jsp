<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="facture.RegulFCProvision"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%
try {
    RegulFCProvision a = new RegulFCProvision();
    a.setNomTable("REGULFCPROVISIONLIB");
    String  mapping = "facture.RegulFCProvision",
            apres = "facture/regul-fc-fiche.jsp",
            titre = "Modif Régul FC Provision";
    
    PageUpdate pu = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    a = (RegulFCProvision) pu.getBase();
    
    pu.getFormu().getChamp("idProvision").setPageAppel("choix/listeFactureClientChoix.jsp");
    pu.getFormu().getChamp("idFacture").setPageAppel("choix/listeFactureClientChoix.jsp");
    
    pu.getFormu().getChamp("idProvision").setAutre("readonly");
    pu.getFormu().getChamp("idFacture").setAutre("readonly");
    pu.getFormu().getChamp("etatlib").setAutre("readonly");
    pu.getFormu().getChamp("etat").setVisible(false);
    pu.getFormu().getChamp("idprovisioncode").setVisible(false);
    pu.getFormu().getChamp("idfacturecode").setVisible(false);
    pu.getFormu().getChamp("idProvision").setLibelle("Provision");
    pu.getFormu().getChamp("idFacture").setLibelle("Facture");
    pu.getFormu().getChamp("etatlib").setLibelle("Etat");
    pu.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
        <%
            out.println(pu.getFormu().getHtmlInsert());
        %>
        <div class="row">
            <div class="col-md-11">
                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
            </div>
            <br><br> 
        </div>
        <input name="acte" type="hidden" id="acte" value="update">
        <input name="bute" type="hidden" id="bute" value="<%=apres%>?id=<%=request.getParameter("id")%>">
        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
    </form>
</div>
<script type="text/javascript">
    document.getElementById("idProvisionlibelle").value = "<%=a.getIdProvisionCode()==null || a.getIdProvisionCode().isEmpty() ? Utilitaire.champNull(a.getIdProvision()) : a.getIdProvisionCode()%>";
    document.getElementById("idFacturelibelle").value = "<%=a.getIdFactureCode()==null || a.getIdFactureCode().isEmpty() ? Utilitaire.champNull(a.getIdFacture()) : a.getIdFactureCode()%>";
</script>
<%} catch (Exception e) {
    e.printStackTrace();
}%>