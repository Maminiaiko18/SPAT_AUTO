<%@page import="mg.cnaps.formation.FormDemande"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    user.UserEJB u = (user.UserEJB) session.getValue("u");
    FormDemande a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new FormDemande();
    a.setNomTable("FORM_DEMANDE_SAISIE");

    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("form_domaine").setPageAppel("choix/paiedomaine.jsp");
     pi.getFormu().getChamp("log_service").setPageAppel("choix/serviceformation.jsp","log_service;log_servicelibelle;id_direction;id_directionlibelle"); 
       
    pi.getFormu().getChamp("categorie_pro").setPageAppel("choix/paiecategorieChoix.jsp");
    pi.getFormu().getChamp("statut_pro").setPageAppel("choix/paiestatut.jsp");
    pi.getFormu().getChamp("id_direction").setPageAppel("choix/logDirectionChoix.jsp");
    affichage.Champ[] liste = new affichage.Champ[3];


    TypeObjet t = new TypeObjet();
    t.setNomTable("FORM_TYPE");
    liste[2] = new Liste("id_type", t, "val", "id");


    TypeObjet tc = new TypeObjet();
    tc.setNomTable("FORM_TYPE_COUT");
    liste[0] = new Liste("id_type_cout", tc, "val", "id");

    TypeObjet dem = new TypeObjet();
    dem.setNomTable("FORM_TYPE_DEMANDEUR");
    liste[1] = new Liste("type_demandeur", dem, "val", "id");

    pi.getFormu().changerEnChamp(liste);

//    ComptaExercice e = new ComptaExercice();
//    e.setEtat(1);
//    ComptaExercice[] ex = (ComptaExercice[]) CGenUtil.rechercher(e, null, null, "");

    pi.getFormu().getChamp("categorie_pro").setLibelle("Categorie");
    pi.getFormu().getChamp("statut_pro").setLibelle("Statut");
    pi.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
    pi.getFormu().getChamp("type_demandeur").setLibelle("Type demandeur");
        pi.getFormu().getChamp("annee_scolaire").setLibelle("Ann&eacute;e scolaire");
        pi.getFormu().getChamp("idmatiere").setPageAppel("choix/formMatiere.jsp");
    pi.getFormu().getChamp("id_etablissement").setLibelle("Etablissement");
    pi.getFormu().getChamp("form_domaine").setLibelle("Domaine");
    pi.getFormu().getChamp("log_service").setLibelle("Service");
    pi.getFormu().getChamp("id_categorie").setLibelle("Cat&eacute;gorie");
    pi.getFormu().getChamp("id_categorie").setVisible(false);
    pi.getFormu().getChamp("id_type").setLibelle("Type de formation");
    pi.getFormu().getChamp("id_personnel").setLibelle("Personnel");
    pi.getFormu().getChamp("id_personnel").setDefaut(u.getUser().getTeluser());
    pi.getFormu().getChamp("date_debut").setLibelle("Date d&eacute;but");
    pi.getFormu().getChamp("date_debut").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pi.getFormu().getChamp("date_fin").setLibelle("Date fin");
    pi.getFormu().getChamp("lieu").setLibelle("Lieu");
    pi.getFormu().getChamp("objett").setVisible(false);
    pi.getFormu().getChamp("niveau_requis").setLibelle("Niveau requis");
    pi.getFormu().getChamp("id_type_cout").setLibelle("Type coût");
    pi.getFormu().getChamp("cout_offre").setLibelle("Co&ucirc;t (Ariary)");
    pi.getFormu().getChamp("idmatiere").setLibelle("Mati&egrave;re");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("exercice").setLibelle("Exercice");
//    pi.getFormu().getChamp("exercice").setDefaut(String.valueOf(ex[0].getId()));
    pi.getFormu().getChamp("iduser").setVisible(false);
    pi.getFormu().getChamp("heure_debut").setLibelle("Heure début de la formation");
    pi.getFormu().getChamp("heure_debut").setAutre("Placeholder = HH:MM");
    pi.getFormu().getChamp("heure_fin").setLibelle("Heure fin de la formation");
    pi.getFormu().getChamp("heure_fin").setAutre("Placeholder = HH:MM");
    pi.getFormu().getChamp("duree_hdebut").setVisible(false);
    pi.getFormu().getChamp("duree_hfin").setVisible(false);
    pi.getFormu().getChamp("id_direction").setLibelle("Direction");
    pi.getFormu().getChamp("id_etablissement").setPageAppel("choix/formetablissementChoix.jsp");
    pi.getFormu().getChamp("id_personnel").setPageAppel("choix/logPersonnelChoix.jsp");
    pi.getFormu().getChamp("fonction").setPageAppel("choix/paieFonctionChoix.jsp");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'une demande</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formoffreformation">
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
                        <input name="bute" type="hidden" id="bute" value="formation/demande-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormDemande">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="form_demande">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>