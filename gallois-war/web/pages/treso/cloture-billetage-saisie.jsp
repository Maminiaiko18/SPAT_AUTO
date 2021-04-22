<%-- 
    Document   : cloture-billetage-saisie
    Created on : 7 nov. 2019, 09:48:22
    Author     : Notiavina
--%>
<%@page import="mg.spat.CloturerBilletage"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        CloturerBilletage pj = new CloturerBilletage();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        
        affichage.Champ[] liste = new affichage.Champ[1];
    
        TypeObjet esc = new TypeObjet();
        esc.setNomTable("CAISSE");
        liste[0] = new Liste("caisse", esc, "VAL", "id");
        
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("solde").setVisible(false);
         pi.getFormu().getChamp("daty").setLibelle("date");
         pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie Cloture de billetage</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="treso/cloturer-billetage-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.CloturerBilletage">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>