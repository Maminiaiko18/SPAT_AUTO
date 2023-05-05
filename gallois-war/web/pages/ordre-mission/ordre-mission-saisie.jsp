

<%@ page import="ordremission.OrdreMission" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    OrdreMission om = new OrdreMission();
    PageInsert pi = new PageInsert(om, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    pi.getFormu().getChamp("estForfaitaire").setLibelle("Forfaitaire");
    pi.getFormu().getChamp("idmotifvoyage").setLibelle("Motif de voyage");
    pi.getFormu().getChamp("idtiers").setLibelle("Tiers");
    pi.getFormu().getChamp("idindemnitemission").setLibelle("Indemnité de Mission");
    pi.getFormu().getChamp("lieudeplacement").setLibelle("Lieu de Placement");
    pi.getFormu().getChamp("datedepart").setLibelle("Date depart");
    pi.getFormu().getChamp("numOM").setLibelle("Num OM");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idindemnitemission").setPageAppel("choix/indemnite-mission-choix.jsp");
    pi.getFormu().getChamp("idindemnitemission").setAutre("readonly");
    pi.getFormu().getChamp("idmotifvoyage").setPageAppel("choix/motif-voyage-choix.jsp");
    pi.getFormu().getChamp("idmotifvoyage").setAutre("readonly");
    pi.getFormu().getChamp("idtiers").setPageAppel("choix/tiersChoix.jsp");
    pi.getFormu().getChamp("idtiers").setAutre("readonly");
    String[]valeurChampestForfaitaire = {"1", "-1"};
    String[]afficheChampestForfaitaire = {"oui", "non"};
    
    affichage.Liste[] lst= new affichage.Liste[1];
    lst[0] = new Liste("estForfaitaire");
    lst[0].ajouterValeur(valeurChampestForfaitaire, afficheChampestForfaitaire);
    pi.getFormu().changerEnChamp(lst);
    pi.getFormu().getChamp("estForfaitaire").setLibelle("Est Forfaitaire");
    
    //Variables de navigation
    String classe = "ordremission.OrdreMission";
    String butApresPost = "ordre-mission/ordre-mission-fiche.jsp";
    String nomTable = "ordre_mission";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie Ordre de Mission</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}
%>

