
<%@page import="mg.spat.HistoriqueSyndicat"%>
<%@ page import="mg.spat.Syndicat" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="poste.Poste"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    String posteVue = "poste";
    String param = request.getParameter("param");
    if (param != null && param.equals("1"))    posteVue = "postemembre";    
    if (param != null && param.equals("2"))    posteVue = "postebureau";    
    HistoriqueSyndicat pj = new HistoriqueSyndicat();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
      
    affichage.Champ[] liste = new affichage.Champ[2];
    Poste poste = new Poste();
    poste.setNomTable(posteVue);
    liste[0] = new Liste("idposte", poste, "VAL", "id");
    Syndicat syndicat = new Syndicat();
    liste[1] = new Liste("idsyndicat", syndicat, "nom", "id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("daty").setAutre("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());  
    pi.getFormu().getChamp("date_fin").setAutre("Date");   
    pi.getFormu().getChamp("date_fin").setDefaut(Utilitaire.dateDuJour());    
    pi.getFormu().getChamp("idpersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");   
    pi.getFormu().getChamp("etat").setVisible(false);
    
    pi.getFormu().getChamp("idsyndicat").setLibelle("Syndicat"); 
    pi.getFormu().getChamp("idposte").setLibelle("Poste"); 
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("date_fin").setLibelle("date fin");
    pi.getFormu().getChamp("idpersonnel").setLibelle("Personnel");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie des membres d'un syndicat</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="syndicat/historique-syndicat-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.HistoriqueSyndicat">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>