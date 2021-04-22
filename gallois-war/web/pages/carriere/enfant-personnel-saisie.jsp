

<%@page import="mg.spat.relationhumaine.Enfant_personnel"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        /*
      private String id,idPersonnel,nom_prenom_enfant;
    private Date dateNaissanceEnfant;
         */
        Enfant_personnel pj = new Enfant_personnel();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        pi.getFormu().getChamp("nom_prenom_enfant").setLibelle("nom et prenom de l'enfant");
        pi.getFormu().getChamp("dateNaissanceEnfant").setLibelle("Date naisssance de l'enfant");
        pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");

        pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
        pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
        if (request.getParameter("idpersonnel") != null) {
            pi.getFormu().getChamp("idPersonnel").setDefaut(request.getParameter("idpersonnel"));
        }
        pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie enfant personnel</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="carriere/enfant-personnel-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Enfant_personnel">
    </form>
    <%if (request.getParameter("idpersonnel") != null) {
            Enfant_personnel info = new Enfant_personnel();
            info.setNomTable("ENFANT_PERSONNEL_PERSONNE_LIB");
            String listeCrt[] = {"id", "nom_prenom_enfant", "dateNaissanceEnfant"};
            String listeInt[] = {"dateNaissanceEnfant"};
            String libEntete[] = {"id", "idPersonnel", "nom_prenom_enfant", "dateNaissanceEnfant"};
            PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
            pr.setUtilisateur((user.UserEJB) session.getValue("u"));
            pr.setAWhere(" and personnel='"+request.getParameter("idpersonnel")+"'");
            pr.setLien((String) session.getValue("lien"));
            pr.setApres("carriere/enfant-personnel-liste.jsp");
            
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
    %>

    <section class="content-header">
        <h1>Liste enfant personnel</h1>
    </section>
    <section class="content">
        <%
            String libEnteteAffiche[] = {"Id", "Personnel", "Nom prenom enfant", "Date Naissance Enfant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>