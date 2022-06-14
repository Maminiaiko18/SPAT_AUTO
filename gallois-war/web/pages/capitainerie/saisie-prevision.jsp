
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Prevision"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Prevision pj = new Prevision();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet liste1 = new TypeObjet();
    liste1.setNomTable("COMMANDANT");
    liste[0] = new Liste("pilote", liste1, "val", "id");
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireExterneChoix.jsp");
    pi.getFormu().getChamp("provenance").setAutre("readonly");
    pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireInterneChoix.jsp"); 
    pi.getFormu().getChamp("destination").setAutre("readonly");
    pi.getFormu().getChamp("cargaison").setPageAppel("choix/listeCargaisonChoix.jsp");
    pi.getFormu().getChamp("cargaison").setAutre("readonly");
//    pi.getFormu().getChamp("pilote").setPageAppel("choix/piloteChoix.jsp");
    pi.getFormu().getChamp("tonnage").setLibelle("Tonnage deb. prev.");
    pi.getFormu().getChamp("consignataire").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("consignataire").setAutre("readonly");    
    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("date_arrivee").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("heure_arrivee").setDefaut(Utilitaire.getHeureActuel());    
    pi.getFormu().getChamp("date_rade").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("date_arrivee").setLibelle("Date d'arrivée");
    pi.getFormu().getChamp("heure_arrivee").setLibelle("Heure d'arrivée");
    pi.getFormu().getChamp("date_depart").setLibelle("Date de départ");
    //pi.getFormu().getChamp("date_depart").setVisible(false);
    pi.getFormu().getChamp("heure_depart").setLibelle("Heure de départ");
    pi.getFormu().getChamp("date_rade").setLibelle("Date rade");
    pi.getFormu().getChamp("destination").setLibelle("Quai");
    pi.getFormu().getChamp("pilote").setLibelle("Commandant");
    pi.getFormu().getChamp("noVoyage").setLibelle("N° voyage");
    
    pi.getFormu().getChamp("armateur").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("estFictive").setVisible(false);
    pi.setLien((String) session.getValue("lien"));
    String[] ordre = {"id","date_rade","provenance","navire","consignataire","cargaison","tonnage","pilote","date_arrivee","heure_arrivee","date_depart","heure_depart","destination","etat","escale","noVoyage","armateur","estFictive"};
    pi.getFormu().setOrdre(ordre);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'une prévision</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/quais/quais-prevision-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Prevision">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>