
<%@page import="mg.cnaps.paie.PersonnelValideInfoLibelle"%>
<%@page import="affichage.PageRecherche"%>

<%!
    String[] colSomme = null;
%>
<%
    String idform = request.getParameter("valeur");
    String retour = request.getParameter("retour");

    if (retour != null && retour.compareToIgnoreCase("") != 0) {
        if (retour.valueOf(true).compareTo("true") == 0) {
            PersonnelValideInfoLibelle participantItem = new PersonnelValideInfoLibelle();
            participantItem.setNomTable("FORMDEM_PARTICIPANTCOMPLET");
            String listeCrt[] = {"id", "personnel", "matricule", "categorie", "fonction", "service", "direction"};
            String listeInt[] = {};
            String libEntete[] = {"id", "personnel", "matricule", "categorie", "fonction", "service", "direction"};
            PageRecherche participants = new PageRecherche(participantItem, request, listeCrt, listeInt, 3, libEntete, 7);
            participants.setNpp(-2);
            participants.setUtilisateur((user.UserEJB) session.getValue("u"));
            participants.setLien((String) session.getValue("lien"));
            participants.setApres("formation/demandeparticipantchoix.jsp&retour=true&valeur=" + idform);
            participants.setAWhere(" AND ID_FORMATION = '" + idform + "'");
            participants.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des agents participants <a href="?but=formation/demande-fiche.jsp&id=<%=idform%>"><%=idform%></a></h1>
    </section>

    <form action="<%=participants.getLien()%>?but=formation/participant-multiple.jsp" method="post" name="participant" id="participant">
        <input type="hidden" name="bute" value="formation/demandeparticipantchoix.jsp&valeur=<%=idform%>&retour=true"/>
        <input type="hidden" name="classe" value="mg.cnaps.formation.FormParticipantDemande"/>
        <input type="hidden" name="acte" value="enlever"/>
        <input type="hidden" name="nomTable" value="form_participant_demande"/>
        <input type="hidden" name="idformation" value="<%=idform%>"/>
        <%
            String libEnteteParticipant[] = {"id", "Personnel", "Matricule", "Categorie", "Fonction", "Service", "Direction"};
            participants.getTableau().setLibelleAffiche(libEnteteParticipant);
            participants.getTableau().setNameActe("enlever");
            participants.getTableau().setNameBoutton("Enlever");
            out.println(participants.getTableau().getHtmlWithCheckbox());
        %>
    </form>
    
    <%
        String awhere = " AND ID NOT IN ( SELECT part.log_personnel from form_participant_demande part where id_formation = '" + idform + "')";
        String listeCrt1[] = {"id", "personnel", "matricule", "categorie", "fonction", "service", "direction"};
        String listeInt1[] = {};
        String libEntete1[] = {"id", "personnel", "matricule", "categorie", "fonction", "service", "direction"};
        PageRecherche toAdd = new PageRecherche(new PersonnelValideInfoLibelle(), request, listeCrt1, listeInt1, 3, libEntete1, 7);
        toAdd.setAWhere(awhere);
        toAdd.setUtilisateur((user.UserEJB) session.getValue("u"));
        toAdd.setLien((String) session.getValue("lien"));
        toAdd.setApres("formation/demandeparticipantchoix.jsp&retour=true&valeur=" + idform);
        toAdd.creerObjetPage(libEntete1, null);
    %>   
    <section class="content-header">
        <h1>Choix personnel participants</h1>
    </section> 
    <section class="content">
        <form action="<%=toAdd.getLien()%>?but=formation/demandeparticipantchoix.jsp&valeur=<%=idform%>&retour=true" method="post" name="formation" id="formation">
            <% out.println(toAdd.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            String lienTableau1[] = {toAdd.getLien() + "?but=employe/personnel-fiche.jsp"};
            String colonneLien1[] = {"id"};
            toAdd.getTableau().setLien(lienTableau1);
            toAdd.getTableau().setColonneLien(colonneLien1);
            out.println(toAdd.getTableauRecap().getHtml());
        %>
        <form method="post" action="<%=toAdd.getLien()%>?but=formation/participant-multiple.jsp" method="post" name="participant" id="participant">
            <input type="hidden" name="bute" value="formation/demandeparticipantchoix.jsp&valeur=<%=idform%>"/>
            <input type="hidden" name="classe" value="mg.cnaps.formation.FormParticipantDemande"/>
            <input type="hidden" name="acte" value="insert"/>
            <input type="hidden" name="nomTable" value="form_participant_demande"/>
            <input type="hidden" name="idformation" value="<%=idform%>"/>
            <%
                String libEnteteAffiche1[] = {"id", "Personnel", "Matricule", "Categorie", "Fonction", "Service", "Direction"};
                toAdd.getTableau().setLibelleAffiche(libEnteteAffiche1);
                toAdd.getTableau().setNameActe("insert");
                out.println(toAdd.getTableau().getHtmlWithCheckbox());
                out.println(toAdd.getBasPage());
            %>
        </form>
    </section>
    
    <% }} %>
</div>   