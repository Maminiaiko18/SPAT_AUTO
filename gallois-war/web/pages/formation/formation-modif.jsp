<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="java.util.Calendar"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    FormFormation a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new FormFormation();
    a.setNomTable("FORM_FORMATION_SAISIE");
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));

//    ComptaExercice e = new ComptaExercice();
//    e.setEtat(1);
//    ComptaExercice[] ex = (ComptaExercice[]) CGenUtil.rechercher(e, null, null, "");

    affichage.Champ[] liste = new affichage.Champ[5];

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
    pi.getFormu().getChamp("form_demande").setPageAppel("choixMultiple/demandeformation.jsp");
    pi.getFormu().getChamp("statut_pro").setLibelle("Statut");
    pi.getFormu().getChamp("categorie_pro").setLibelle("Cat&eacute;gorie");
    pi.getFormu().getChamp("type_demandeur").setLibelle("Type demande");
    pi.getFormu().getChamp("idmatiere").setPageAppel("choix/formMatiere.jsp");
    pi.getFormu().getChamp("form_domaine").setLibelle("Domaine");
    pi.getFormu().getChamp("log_service").setLibelle("Service");
    pi.getFormu().getChamp("form_formateur").setLibelle("Formateur");
    pi.getFormu().getChamp("id_categorie").setVisible(false);
    pi.getFormu().getChamp("id_type").setLibelle("Type de formation");
    pi.getFormu().getChamp("id_of").setLibelle("Offre de formation");
    pi.getFormu().getChamp("form_demande").setLibelle("Demande de formation");
    pi.getFormu().getChamp("date_debut").setLibelle("Date d&eacute;but");
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
//    pi.getFormu().getChamp("exercice").setDefaut(String.valueOf(ex[0].getId()));
    pi.getFormu().getChamp("etablissement").setLibelle("Etablissement");
    pi.getFormu().getChamp("iduser").setVisible(false);
    pi.getFormu().getChamp("heure_debut").setLibelle("Heure début de la formation");
    pi.getFormu().getChamp("heure_debut").setAutre("Placeholder = HH:MM:SS");
//    pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin de la formation");
    pi.getFormu().getChamp("heure_fin").setAutre("Placeholder = HH:MM:SS");
    pi.getFormu().getChamp("id_direction").setLibelle("Direction");
    pi.getFormu().getChamp("duree_hdebut").setVisible(false);
    pi.getFormu().getChamp("duree_hfin").setVisible(false);
    pi.getFormu().getChamp("idmatiere").setLibelle("Mati&egrave;re");
    pi.getFormu().getChamp("annee_scolaire").setLibelle("Ann&eacute;e");
    pi.getFormu().getChamp("etablissement").setPageAppel("choix/formetablissementChoix.jsp");
    pi.getFormu().getChamp("id_of").setPageAppel("choix/formOffreChoix.jsp");
    pi.getFormu().getChamp("form_formateur").setPageAppel("choix/formFormateurChoix.jsp");
    pi.getFormu().getChamp("fonction").setPageAppel("choix/paieFonctionChoix.jsp");

    pi.getFormu().getChamp("form_domaine").setPageAppel("choix/paiedomaine.jsp");
    pi.getFormu().getChamp("log_service").setPageAppel("choixMultiple/service.jsp", "log_service;log_servicelibelle;id_direction;id_directionlibelle");
    pi.getFormu().getChamp("categorie_pro").setPageAppel("choix/paiecategorieChoix.jsp");
    pi.getFormu().getChamp("statut_pro").setPageAppel("choix/paiestatut.jsp");
    pi.getFormu().getChamp("id_direction").setPageAppel("choix/logDirectionChoix.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'une formation</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formformation">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="formation/formation-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormFormation">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="form_formation">
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
