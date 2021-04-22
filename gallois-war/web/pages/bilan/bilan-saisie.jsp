
<%@page import="mg.spat.Bilan"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Bilan pj = new Bilan();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("typeBilan").setLibelle("Type");
    
    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("typebilan");
    liste[0] = new Liste("typeBilan", mvt, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un bilan</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="bilan/bilan-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Bilan">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
    throw e;
}%>