<%@page import="facture.FactureClient"%>
<%@page import="mg.spat.FcDefPr"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%
try{
    UserEJB u = (user.UserEJB) session.getValue("u");
    String id1 = request.getParameter("id1");
    String id1Lib = null;
    String  mapping = "mg.spat.FcDefPr",
            nomtable = "FCDEFPR",
            apres = "facture/liaison-fc-prov-fiche.jsp",
            titre = "Saisie Liaison FD et prévision";
    
            FcDefPr objet = new FcDefPr();
     
    objet.setNomTable(nomtable);
    
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));  
    pi.getFormu().getChamp("id1").setLibelle("Facture client");
    pi.getFormu().getChamp("id2").setLibelle("Provision");
    pi.getFormu().getChamp("etat").setVisible(false);

    pi.getFormu().getChamp("id2").setPageAppel("choix/listeFactureClientChoix.jsp");
    
    pi.getFormu().getChamp("id1").setAutre("readonly");
    pi.getFormu().getChamp("id2").setAutre("readonly");
    
    if(id1!=null && !id1.isEmpty()){
        pi.getFormu().getChamp("id1").setDefaut(id1);
        FactureClient pr = objet.getFacture(null, id1);
        pi.getFormu().getChamp("montant").setDefaut(Utilitaire.formaterAr(pr.getMontantreste()));
        id1Lib = pr!=null ? pr.getCode() : "";
    }
    
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
<script type="text/javascript">
    document.getElementById("id1").value = "<%= id1==null || id1.isEmpty() ? Utilitaire.champNull(id1) : id1%>";
</script> 
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>