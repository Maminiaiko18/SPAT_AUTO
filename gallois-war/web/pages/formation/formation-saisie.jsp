<%--
    Document   : formation-saisie
    Created on : 13 oct. 2015, 15:03:13
    Author     : user
--%>
<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="mg.cnaps.formation.FormOffreFormation"%>
<%@page import="mg.cnaps.formation.FormDemande"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="java.util.Calendar"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        FormFormation a = new FormFormation();
        a.setNomTable("FORM_FORMATION_SAISIE");
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));

//        ComptaExercice e = new ComptaExercice();
//        e.setEtat(1);
//        ComptaExercice[] ex = (ComptaExercice[]) CGenUtil.rechercher(e, null, null, "");
        affichage.Champ[] liste = new affichage.Champ[5];
         pi.getFormu().getChamp("form_demande").setPageAppel("choixMultiple/demandeformation.jsp");
        pi.getFormu().getChamp("form_domaine").setPageAppel("choix/paiedomaine.jsp");
//        pi.getFormu().getChamp("log_service").setPageAppel("choixMultiple/service.jsp","log_service;log_servicelibelle;id_direction;id_directionlibelle"); 
        pi.getFormu().getChamp("categorie_pro").setPageAppel("choix/paiecategorieChoix.jsp");
        pi.getFormu().getChamp("statut_pro").setPageAppel("choix/paiestatut.jsp");
        pi.getFormu().getChamp("id_direction").setVisible(false);
        pi.getFormu().getChamp("idmatiere").setPageAppel("choix/formMatiere.jsp");

        TypeObjet t = new TypeObjet();
        t.setNomTable("FORM_TYPE");
        liste[3] = new Liste("id_type", t, "val", "id");

        TypeObjet tc = new TypeObjet();
        tc.setNomTable("FORM_TYPE_COUT");
        liste[0] = new Liste("id_type_cout", tc, "val", "id");

        TypeObjet cout = new TypeObjet();
        cout.setNomTable("FORM_TYPE_COUT");
        liste[1] = new Liste("id_type_cout", cout, "val", "id");

        TypeObjet dem = new TypeObjet();
        dem.setNomTable("FORM_TYPE_DEMANDEUR");
        liste[2] = new Liste("type_demandeur", dem, "val", "id");

        Liste listeExercice = new Liste("exercice");
        Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int defau = 1900;
        int taille = (year + 50) - 1900;
        String[] val1 = new String[taille];
        int compteur = 0;
        String[] aff1 = new String[taille];
        for (int i = 1900; i < year + 50; i++) {
            val1[compteur] = Integer.toString(i);
            aff1[compteur] = Integer.toString(i);
            compteur++;
        }
        listeExercice.ajouterValeur(val1, aff1);
        liste[4] = listeExercice;
        pi.getFormu().getChamp("exercice").setDefaut(Integer.toString(year));

        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("statut_pro").setLibelle("Statut");
        pi.getFormu().getChamp("categorie_pro").setLibelle("Cat&eacute;gorie");
        pi.getFormu().getChamp("type_demandeur").setLibelle("Type demande");
        pi.getFormu().getChamp("form_domaine").setLibelle("Domaine");
        pi.getFormu().getChamp("log_service").setLibelle("Service");
        pi.getFormu().getChamp("form_formateur").setLibelle("Formateur");
        pi.getFormu().getChamp("id_categorie").setVisible(false);
        pi.getFormu().getChamp("id_type").setLibelle("Type de formation");
        pi.getFormu().getChamp("id_of").setLibelle("Offre de formation");
        pi.getFormu().getChamp("form_demande").setLibelle("Demande de formation");
        pi.getFormu().getChamp("date_debut").setLibelle("Date d&eacute;but");
        pi.getFormu().getChamp("date_debut").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pi.getFormu().getChamp("date_fin").setLibelle("Date fin");
        pi.getFormu().getChamp("date_fin").setAutre("required");
        pi.getFormu().getChamp("lieu").setLibelle("Lieu");
        pi.getFormu().getChamp("objett").setVisible(false);
        pi.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
        pi.getFormu().getChamp("id_type_cout").setLibelle("Type co&ucirc;t");
        pi.getFormu().getChamp("cout_offre").setLibelle("Co&ucirc;t (Ariary)");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("exercice").setLibelle("Exercice");
        pi.getFormu().getChamp("intitule").setLibelle("Intitul&eacute;");
//        pi.getFormu().getChamp("exercice").setDefaut(String.valueOf(ex[0].getId()));
        pi.getFormu().getChamp("etablissement").setLibelle("Etablissement");
        pi.getFormu().getChamp("iduser").setVisible(false);
        pi.getFormu().getChamp("heure_debut").setLibelle("Heure début de la formation");
        pi.getFormu().getChamp("heure_debut").setAutre("Placeholder = HH:MM:SS");
        pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin de la formation");
        pi.getFormu().getChamp("heure_fin").setAutre("Placeholder = HH:MM:SS");
        pi.getFormu().getChamp("duree_hdebut").setVisible(false);
        pi.getFormu().getChamp("duree_hfin").setVisible(false);
        pi.getFormu().getChamp("idmatiere").setLibelle("Mati&egrave;re");
        pi.getFormu().getChamp("annee_scolaire").setLibelle("Ann&eacute;e");

        pi.getFormu().getChamp("etablissement").setPageAppel("choix/formetablissementChoix.jsp");
        pi.getFormu().getChamp("id_of").setPageAppel("choix/formOffreChoix.jsp");
        pi.getFormu().getChamp("form_formateur").setPageAppel("choix/formFormateurChoix.jsp");
        pi.getFormu().getChamp("id_direction").setLibelle("Direction");
        pi.getFormu().getChamp("fonction").setPageAppel("choix/paieFonctionChoix.jsp");
        
        
        String idoffre = request.getParameter("idoffre");
        if (idoffre != null && idoffre.compareToIgnoreCase("") != 0) {
            FormOffreFormation f = new FormOffreFormation();
            f.setId(idoffre);
            FormOffreFormation[] fd = (FormOffreFormation[]) CGenUtil.rechercher(f, null, null, "");
            if (fd.length > 0) {
                pi.getFormu().getChamp("etablissement").setDefaut(fd[0].getEtablissement());
                pi.getFormu().getChamp("log_service").setDefaut(fd[0].getLog_service());
                pi.getFormu().getChamp("id_categorie").setDefaut(fd[0].getForm_categorie());
                pi.getFormu().getChamp("id_categorie").setVisible(false);
                pi.getFormu().getChamp("id_type").setDefaut(fd[0].getId_type());
                
                if (fd[0].getDate_debut() != null) {
                    pi.getFormu().getChamp("date_debut").setDefaut(utilitaire.Utilitaire.datetostring(fd[0].getDate_debut()));
                }
                if (fd[0].getDate_fin() != null) {
                    pi.getFormu().getChamp("date_fin").setDefaut(utilitaire.Utilitaire.datetostring(fd[0].getDate_fin()));
                }
                pi.getFormu().getChamp("lieu").setDefaut(fd[0].getLieu());
                pi.getFormu().getChamp("intitule").setDefaut(fd[0].getRemarque());
                pi.getFormu().getChamp("niveau_requis").setDefaut(String.valueOf(fd[0].getNiveau_requis()));
                pi.getFormu().getChamp("cout_offre").setDefaut(String.valueOf(fd[0].getCout_offre()));
                pi.getFormu().getChamp("id_of").setDefaut(fd[0].getId());
                pi.getFormu().getChamp("form_formateur").setDefaut(fd[0].getId_formateur());
            }
        }
        String iddemande = request.getParameter("id");
        if (iddemande != null && iddemande.compareToIgnoreCase("") != 0) {
            FormDemande f = new FormDemande();
            f.setId(iddemande);
            FormDemande[] fd = (FormDemande[]) CGenUtil.rechercher(f, null, null, "");
            if (fd.length > 0) {
                pi.getFormu().getChamp("statut_pro").setDefaut(fd[0].getStatut_pro());
                pi.getFormu().getChamp("type_demandeur").setDefaut(fd[0].getType_demandeur());
                pi.getFormu().getChamp("form_demande").setDefaut(iddemande);
                pi.getFormu().getChamp("etablissement").setDefaut(fd[0].getId_etablissement());
                pi.getFormu().getChamp("form_domaine").setDefaut(fd[0].getForm_domaine());
                pi.getFormu().getChamp("log_service").setDefaut(fd[0].getLog_service());
                pi.getFormu().getChamp("id_categorie").setDefaut(fd[0].getId_categorie());
                pi.getFormu().getChamp("id_categorie").setVisible(false);
                pi.getFormu().getChamp("categorie_pro").setDefaut(fd[0].getCategorie_pro());
                pi.getFormu().getChamp("id_type").setDefaut(fd[0].getId_type());
                pi.getFormu().getChamp("id_direction").setDefaut(fd[0].getId_direction());
                pi.getFormu().getChamp("annee_scolaire").setDefaut(fd[0].getAnnee_scolaire());
                if (fd[0].getDate_debut() != null) {
                    pi.getFormu().getChamp("date_debut").setDefaut(utilitaire.Utilitaire.datetostring(fd[0].getDate_debut()));
                }
                if (fd[0].getDate_fin() != null) {
                    pi.getFormu().getChamp("date_fin").setDefaut(utilitaire.Utilitaire.datetostring(fd[0].getDate_fin()));
                }
                pi.getFormu().getChamp("lieu").setDefaut(fd[0].getLieu());
//            pi.getFormu().getChamp("objet").setDefaut(fd[0].getObjet());

                pi.getFormu().getChamp("niveau_requis").setDefaut(String.valueOf(fd[0].getNiveau_requis()));
                pi.getFormu().getChamp("cout_offre").setDefaut(String.valueOf(fd[0].getCout_offre()));
                pi.getFormu().getChamp("exercice").setDefaut(String.valueOf(fd[0].getExercice()));
                pi.getFormu().getChamp("heure_debut").setDefaut(String.valueOf(fd[0].getHeure_debut()));
                pi.getFormu().getChamp("heure_fin").setDefaut(String.valueOf(fd[0].getHeure_fin()));
                pi.getFormu().getChamp("fonction").setDefaut(String.valueOf(fd[0].getFonction()));
                pi.getFormu().getChamp("idmatiere").setDefaut(fd[0].getIdmatiere());
                pi.getFormu().getChamp("id_type_cout").setDefaut(fd[0].getId_type_cout());
                pi.getFormu().getChamp("effectif").setDefaut(String.valueOf(fd[0].getEffectif()));
            }
        }
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1 align="center">Formation</h1>
    <form 
        <% if (iddemande != null && iddemande.compareToIgnoreCase("") != 0) {%>
        action="<%=(String) session.getValue("lien")%>/../../SaisieFormation"
        <% } else {%>
        action="<%=pi.getLien()%>?but=apresTarif.jsp" 
        <%
            }
        %>

        method="post" name="formation" id="formation" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="iddemande" type="hidden" id="iddemande" value="<%=iddemande%>"/>
        <input name="acte" type="hidden" id="acte" value="insert">
        <input name="bute" type="hidden" id="bute" value="formation/formation-liste.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormFormation">
        <input name="nomtable" type="hidden" id="nomtable" value="form_formation">
    </form>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>
