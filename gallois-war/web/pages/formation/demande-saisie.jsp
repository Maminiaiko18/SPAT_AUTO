<%--
    Document   : demande-saisie
    Created on : 13 oct. 2015, 14:04:11
    Author     : user
--%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.log.LogService"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%
    user.UserEJB u = (user.UserEJB) session.getValue("u");
    try {

        String autreparsley = "data-parsley-range='[8, 40]' required";
        FormDemande a = new FormDemande();
        a.setNomTable("FORM_DEMANDE_SAISIE");
        PageInsert pi = new PageInsert(a, request, u);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("form_domaine").setPageAppel("choix/paiedomaine.jsp");
        pi.getFormu().getChamp("log_service").setPageAppel("choix/serviceformation.jsp","log_service;log_servicelibelle;id_direction;id_directionlibelle"); 
        pi.getFormu().getChamp("categorie_pro").setPageAppel("choix/paiecategorieChoix.jsp");
        pi.getFormu().getChamp("statut_pro").setPageAppel("choix/paiestatut.jsp");
//        pi.getFormu().getChamp("id_direction").setPageAppel("choix/logDirectionChoix.jsp");
        affichage.Champ[] liste = new affichage.Champ[4];
        TypeObjet cat = new TypeObjet();
        cat.setNomTable("FORM_CATEGORIE");
        liste[2] = new Liste("id_categorie", cat, "val", "id");
        
        TypeObjet t = new TypeObjet();
        t.setNomTable("FORM_TYPE");
        liste[3] = new Liste("id_type", t, "val", "id");

        TypeObjet tc = new TypeObjet();
        tc.setNomTable("FORM_TYPE_COUT");
        liste[1] = new Liste("id_type_cout", tc, "val", "id");

        TypeObjet dem = new TypeObjet();
        dem.setNomTable("FORM_TYPE_DEMANDEUR");
        liste[0] = new Liste("type_demandeur", dem, "val", "id");

        pi.getFormu().changerEnChamp(liste);

        //ComptaExercice e = new ComptaExercice();
        //e.setEtat(1);
        //ComptaExercice[] ex = (ComptaExercice[]) CGenUtil.rechercher(e, null, null, "");

        pi.getFormu().getChamp("categorie_pro").setLibelle("Categorie");
        pi.getFormu().getChamp("statut_pro").setLibelle("Statut");
        pi.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
        pi.getFormu().getChamp("type_demandeur").setLibelle("Type demande");
        pi.getFormu().getChamp("annee_scolaire").setLibelle("Ann&eacute;e scolaire");

        pi.getFormu().getChamp("id_etablissement").setLibelle("Etablissement");
        pi.getFormu().getChamp("form_domaine").setLibelle("Domaine");
        pi.getFormu().getChamp("log_service").setLibelle("Service");
        pi.getFormu().getChamp("id_categorie").setLibelle("Cat&eacute;gorie");
        pi.getFormu().getChamp("id_categorie").setVisible(false);
        pi.getFormu().getChamp("id_type").setLibelle("Type de formation");
        pi.getFormu().getChamp("id_personnel").setLibelle("Personnel");
        pi.getFormu().getChamp("id_personnel").setDefaut(u.getUser().getTeluser());
        pi.getFormu().getChamp("id_personnel").setVisible(false);
        pi.getFormu().getChamp("date_debut").setLibelle("Date d&eacute;but");
        //pi.getFormu().getChamp("date_debut").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pi.getFormu().getChamp("date_fin").setLibelle("Date fin");
        pi.getFormu().getChamp("lieu").setLibelle("Lieu");
        pi.getFormu().getChamp("objett").setVisible(false);
        pi.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
        pi.getFormu().getChamp("id_type_cout").setLibelle("Type coût");
        pi.getFormu().getChamp("cout_offre").setLibelle("Co&ucirc;t (Ariary)");
        pi.getFormu().getChamp("idmatiere").setLibelle("Mati&egrave;re");
        pi.getFormu().getChamp("idmatiere").setPageAppel("choix/formMatiere.jsp");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("exercice").setLibelle("Exercice");
        pi.getFormu().getChamp("exercice").setDefaut(String.valueOf(utilitaire.Utilitaire.getAneeEnCours()));
        pi.getFormu().getChamp("iduser").setVisible(false);
        pi.getFormu().getChamp("heure_debut").setLibelle("Heure début de la formation");
        pi.getFormu().getChamp("heure_debut").setAutre("Placeholder = HH:MM:SS");
        pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin de la formation");
        pi.getFormu().getChamp("heure_fin").setAutre("Placeholder = HH:MM:SS");
        pi.getFormu().getChamp("duree_hdebut").setVisible(false);
        pi.getFormu().getChamp("duree_hfin").setVisible(false);
//        pi.getFormu().getChamp("id_direction").setLibelle("Direction");

        pi.getFormu().getChamp("id_etablissement").setPageAppel("choix/formetablissementChoix.jsp");
        pi.getFormu().getChamp("id_personnel").setPageAppel("choix/logPersonnelChoix.jsp");
        pi.getFormu().getChamp("fonction").setPageAppel("choix/paieFonctionChoix.jsp");
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Demande de formation</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="demandeform" id="demandeform" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="formation/demande-liste.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormDemande">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>