<%@page import="mg.spat.Navire"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="affichage.Champ" %>
<%@ page import="affichage.Liste" %>
<%@ page import="affichage.PageInsert" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Navire pj = new Navire();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet liste1 = new TypeObjet();
    liste1.setNomTable("typenavire");
    liste[0] = new Liste("type", liste1, "val", "id");
    pi.getFormu().changerEnChamp(liste);
	
    
    pi.getFormu().getChamp("pavillon").setPageAppel("choix/listePaysChoix.jsp");
    pi.getFormu().getChamp("pavillon").setAutre("readonly");
    pi.getFormu().getChamp("reference").setLibelle("R&eacute;f&eacute;rence");
    pi.getFormu().getChamp("armateur").setLibelle("Armateur");
    pi.getFormu().getChamp("armateur").setAutre("readonly");
    pi.getFormu().getChamp("armateur").setPageAppel("choix/listeArmateurChoix.jsp");
    
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("volume").setVisible(false);
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un navire</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/navire-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Navire">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>