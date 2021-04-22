<%@page import="affichage.Liste"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@page import="mg.spat.Navire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Postedestinataire pj = new Postedestinataire();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("quai").setPageAppel("choix/listeQuaisChoix.jsp");
    pi.getFormu().getChamp("quai").setAutre("readonly");
    pi.getFormu().getChamp("pays").setVisible(false);
    pi.getFormu().getChamp("tirant").setVisible(false);
    pi.getFormu().getChamp("longueur").setVisible(false);
    pi.getFormu().getChamp("profondeur").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[1];
    Liste li = new Liste("interne");
    String [] val = {"1", "0"};//here
    String [] aff = {"Interne", "Externe"};
    li.ajouterValeur( val, aff );
    liste[0]=li;
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("interne").setLibelle("Localisation");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un poste destinataire</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/postedestinataire-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Postedestinataire">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>