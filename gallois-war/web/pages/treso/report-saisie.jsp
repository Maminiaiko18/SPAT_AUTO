<%@page import="mg.spat.Report"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    Report report = new Report();
    PageInsert pi = new PageInsert(report, request, (user.UserEJB) session.getValue("u"));
    
    affichage.Champ[] liste = new affichage.Champ[2];
    
    TypeObjet esc = new TypeObjet();
    esc.setNomTable("CAISSE");
    liste[0] = new Liste("caisse", esc, "VAL", "id");
    
    TypeObjet dev = new TypeObjet();
    dev.setNomTable("devise");
    liste[1] = new Liste("devise", dev, "VAL", "ID");
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("devise").setDefaut("Ar");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date");
    
    pi.setLien((String) session.getValue("lien"));
    
    String[] ordre = {"daty","caisse","montant","devise","id","etat"};    
    pi.getFormu().setOrdre(ordre);
    
    pi.preparerDataFormu();
    
    
%>
<div class="content-wrapper">
    <h1>Saisie Report</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="report" id="report" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
  
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="treso/report-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Report">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>