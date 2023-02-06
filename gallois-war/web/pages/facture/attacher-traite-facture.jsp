<%@page import="facture.tr.FCTraite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%  
    
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FCTraite fctraite = new FCTraite();
    PageInsert pi = new PageInsert(fctraite, request, (user.UserEJB) session.getValue("u"));

    pi.getFormu().getChamp("idtraite").setLibelle("Traite");
    pi.getFormu().getChamp("idfc").setLibelle("Facture Client");
    pi.getFormu().getChamp("idtraite").setLibelle("Traite");

    if(request.getParameter("idTraite")!=null){
        pi.getFormu().getChamp("idtraite").setDefaut(request.getParameter("idTraite"));
    }else{
        pi.getFormu().getChamp("idtraite").setPageAppel("choix/traiteChoix.jsp");
    }

    if(request.getParameter("idfc")!=null){
        pi.getFormu().getChamp("idfc").setDefaut(request.getParameter("idfc"));
    }else{
        pi.getFormu().getChamp("idfc").setPageAppel("choix/listeFactureClientViseeChoix.jsp");
    }
    pi.getFormu().getChamp("idfc").setAutre("readonly");
    pi.getFormu().getChamp("idtraite").setAutre("readonly");
    pi.getFormu().getChamp("idJc").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);

    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Attacher Traite Facture</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="facture/fctraite-liste.jsp">
    <input name="classe" type="hidden" id="classe" value="facture.tr.FCTraite">
    <input name="nomtable" type="hidden" id="classe" value="FCTraite">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>