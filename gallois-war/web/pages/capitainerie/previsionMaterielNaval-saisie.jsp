
<%@page import="mg.spat.PrevisionMaterielNaval"%>
<%@page import="mg.spat.MaterielNaval"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Prevision"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        PrevisionMaterielNaval pj = new PrevisionMaterielNaval();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        pi.getFormu().getChamp("idnavire").setPageAppel("choix/listeNavireChoix.jsp");
        pi.getFormu().getChamp("idnavire").setAutre("readonly");
        /*pi.getFormu().getChamp("idclient").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("idclient").setAutre("readonly");*/
        affichage.Champ[] liste = new affichage.Champ[2];
        TypeObjet cons = new TypeObjet();
        cons.setNomTable("commandant");
        liste[0] = new Liste("idcommandant", cons, "VAL", "id");

        TypeObjet carg = new TypeObjet();
        carg.setNomTable("natureoperation");
        liste[1] = new Liste("idnatureoperation", carg, "VAL", "id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("idmateriel_naval").setPageAppel("choix/listeMaterielNava.jsp");
        pi.getFormu().getChamp("idmateriel_naval").setAutre("readonly");
        pi.getFormu().getChamp("idmateriel_naval").setLibelle("Flotte");
        pi.getFormu().getChamp("idarrivee").setPageAppel("choix/listeMouvementArriveeChoix.jsp");
        pi.getFormu().getChamp("idarrivee").setAutre("readonly");
        pi.getFormu().getChamp("idarrivee").setLibelle("Arrivee");
    
        pi.getFormu().getChamp("idmateriel_naval").setLibelle("Flotte");
        pi.getFormu().getChamp("idcommandant").setLibelle("Commandant");
        pi.getFormu().getChamp("idnatureoperation").setLibelle("Nature opération");
        pi.getFormu().getChamp("idnavire").setVisible(false);
        pi.getFormu().getChamp("idclient").setVisible(false);
        pi.getFormu().getChamp("daty").setLibelle("Date début");
        pi.getFormu().getChamp("daty").setVisible(false);

        pi.getFormu().getChamp("date_depart").setLibelle("Date de fin");
        pi.getFormu().getChamp("heure_arrivee").setLibelle("Heure début");
        pi.getFormu().getChamp("date_arrivee").setLibelle("Date début");

        pi.getFormu().getChamp("date_depart").setDefaut(Utilitaire.dateDuJour());

        pi.getFormu().getChamp("heure_depart").setLibelle("Heure fin");
        pi.getFormu().getChamp("duree").setVisible(false);
        pi.getFormu().getChamp("date_arrivee").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("heure_arrivee").setDefaut(Utilitaire.getHeureActuel());
        pi.getFormu().getChamp("etat").setVisible(false);

        pi.setLien((String) session.getValue("lien"));
        String[] ordre = {"idmateriel_naval","idcommandant","idnatureoperation","observation","date_arrivee","heure_arrivee","date_depart","heure_depart","idarrivee"};
        pi.getFormu().setColOrdre(ordre);
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'une prévision de matériel naval</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="capitainerie/previsionMaterielNaval-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.PrevisionMaterielNaval">
    </form>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>