<%@page import="facture.OpFacture"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%  
    
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    OpFacture pf = new OpFacture();
    PageInsert pi = new PageInsert(pf, request, (user.UserEJB) session.getValue("u"));
    String id = request.getParameter("id");
    if(id!=null)
        pi.getFormu().getChamp("idop").setDefaut(id);
    pi.getFormu().getChamp("idop").setAutre("readonly");
    pi.getFormu().getChamp("idop").setLibelle("OP");
    pi.getFormu().getChamp("idfacture").setPageAppel("choix/listeFactureFournisseurChoix.jsp");
    pi.getFormu().getChamp("idfacture").setAutre("readonly");
    pi.getFormu().getChamp("idfacture").setLibelle("Facture");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Ajout Facture Fournisseur</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>

    <input name="acte" type="hidden" id="nature" value="ajouterFF">
    <input name="bute" type="hidden" id="bute" value="ded/ordonnerpayement-fiche.jsp">
    <input name="id" type="hidden" id="id" value=<%=id %> >
    <input name="classe" type="hidden" id="classe" value="facture.OpFacture">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>