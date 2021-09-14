
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="facture.EtatProvision" %>


<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        EtatProvision r = new EtatProvision();
        PageInsert pi = new PageInsert(r, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        
        pi.getFormu().getChamp("idfacture").setDefaut(Utilitaire.champNull(request.getParameter("idFacture")));
        
        pi.getFormu().getChamp("idfacture").setPageAppel("choix/listeFactureClientChoix.jsp");
        pi.getFormu().getChamp("idfacture").setAutre("readonly");
        
        pi.getFormu().getChamp("idnavire").setPageAppel("choix/listeNavireChoix.jsp");
        pi.getFormu().getChamp("idnavire").setAutre("readonly");
        
        affichage.Liste[] liste = new affichage.Liste[2];
        TypeObjet mode = new  TypeObjet();
        mode.setNomTable("MODEPAIEMENT");
        liste[0] = new Liste("idmode", mode, "desce", "id");
        TypeObjet banque = new  TypeObjet();
        banque.setNomTable("BANQUE");
        liste[1] = new Liste("idbanque", banque, "val", "id");
        
        pi.getFormu().changerEnChamp(liste);
        
        pi.getFormu().getChamp("idfacture").setLibelle("Facture");
        pi.getFormu().getChamp("idnavire").setLibelle("Navire");
        pi.getFormu().getChamp("idbanque").setLibelle("Banque");
        pi.getFormu().getChamp("idmode").setLibelle("Mode");
        pi.getFormu().getChamp("operation").setLibelle("Opération");
        
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 class="box-title">Enregistrer &eacute;tat de provision</h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="etatprovision" id="etatprovision" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="facture/etatprovision-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="facture.EtatProvision">
        <input name="nomtable" type="hidden" id="classe" value="etat_provision">
    </form>
</div>
<%} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert("<%=e.getMessage()%>");
            history.back();</script>

<% }%>
