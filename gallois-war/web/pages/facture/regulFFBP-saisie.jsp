
<%@page import="facture.FactureFournisseur"%>
<%@page import="mg.spat.RegulFFBP"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    RegulFFBP  reg = new RegulFFBP ();
    PageInsert pi = new PageInsert(reg, request, (user.UserEJB) session.getValue("u"));
    String id = request.getParameter("id");
    FactureFournisseur ff = new FactureFournisseur();
    ff.setNomTable("factfourn_msum_lib_ficheB");
    FactureFournisseur[] fact = (FactureFournisseur[])CGenUtil.rechercher(ff, null, null, " and id='"+id+"'");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idbp").setPageAppel("choix/bonprovisoire-tous.jsp");
    pi.getFormu().getChamp("idbp").setLibelle("Bon provisoire");   
    pi.getFormu().getChamp("idff").setLibelle("Facture fournisseur");
    pi.getFormu().getChamp("idff").setDefaut(id);
    pi.getFormu().getChamp("idff").setAutre("readonly");
    pi.getFormu().getChamp("montant").setDefaut(""+fact[0].getMontantreste());
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie Regularisation Facture via Bon provisoire </h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="facture/regulFFBP-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.RegulFFBP">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>