
<%@page import="mg.spat.Tiers"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Tiers pj = new Tiers();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
      
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("type");
    String [] val = {"partenaire", "prestataire"};
    String [] aff = {"Partenaire", "Prestataire"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("type").setDefaut("prestataire"); 
    pi.getFormu().getChamp("compteAuxFournisseur").setLibelle("Compte fournisseur"); 
    pi.getFormu().getChamp("compteAuxClient").setLibelle("Compte client"); 
    pi.getFormu().getChamp("etat").setVisible(false); 
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
    
    String bute = request.getParameter("param") != null && request.getParameter("param").compareToIgnoreCase("1") == 0 ? "travaux/tiers-fiche.jsp&param=1" : "travaux/tiers-fiche.jsp";
%>
<div class="content-wrapper">
    <h1>Saisie d'un tiers</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=bute%>">
        <input name="classe" type="hidden" id="classe" value="mg.spat.Tiers">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>