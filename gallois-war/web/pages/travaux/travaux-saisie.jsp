
<%@page import="mg.spat.Travaux"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Travaux pj = new Travaux();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));

        pi.getFormu().getChamp("datedebut").setLibelle("Date début");
        pi.getFormu().getChamp("datedebut").setDefaut(Utilitaire.dateDuJour());

        pi.getFormu().getChamp("datefin").setLibelle("Date fin");
        pi.getFormu().getChamp("datefin").setDefaut(Utilitaire.dateDuJour());

        pi.getFormu().getChamp("montant").setLibelle("Montant prévu");

        pi.getFormu().getChamp("avancement").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);

        affichage.Champ[] liste = new affichage.Champ[2];

        TypeObjet mvt = new TypeObjet();
        mvt.setNomTable("typetravaux");
        liste[0] = new Liste("idtypetravaux", mvt, "VAL", "id");

        TypeObjet mvt2 = new TypeObjet();
        mvt2.setNomTable("devisedemat");
        liste[1] = new Liste("iddevise", mvt2, "VAL", "id");

        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("Idtypetravaux").setLibelle("Type travaux");
        pi.getFormu().getChamp("iddevise").setLibelle("Devise");
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("codeetablissement").setLibelle("Code etablissement");
        
        
        
        pi.getFormu().getChamp("codeetablissement").setVisible(false);
        
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("projet").setVisible(false);

        pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        
        
        pi.getFormu().getChamp("idpatrimoine").setPageAppel("choix/listePatrimoineChoix.jsp");
        pi.getFormu().getChamp("idpatrimoine").setAutre("readonly");
                pi.getFormu().getChamp("idpatrimoine").setLibelle("Patrimoine");


        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie de travaux</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="travaux/travaux-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.Travaux">
    </form>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>