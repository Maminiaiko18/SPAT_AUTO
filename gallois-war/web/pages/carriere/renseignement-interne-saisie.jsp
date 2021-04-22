
<%@page import="mg.spat.relationhumaine.Renseigement_interne"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Renseigement_interne pj = new Renseigement_interne();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));

        pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
        if (request.getParameter("idpersonnel") != null) {
            pi.getFormu().getChamp("idPersonnel").setDefaut(request.getParameter("idpersonnel"));
        }

        affichage.Champ[] liste = new affichage.Champ[1];
        
        TypeObjet mvt = new TypeObjet();
        mvt.setNomTable("Type_renseignement_interne");
        liste[0] = new Liste("type", mvt, "VAL", "id");
        
        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
         pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");

        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie renseignement interne</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="carriere/renseignement-interne-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Renseigement_interne">
    </form>
<%if (request.getParameter("idpersonnel") != null) {
        Renseigement_interne info = new Renseigement_interne();
        info.setNomTable("renseignement_interne_lib");
        String listeCrt[] = {"id", "idPersonnel", "libelle", "type", "observation", "daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "idPersonnel", "libelle", "type", "observation", "daty"};
        PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        // pr.getFormu().getChamp("daty").setLibelle("Date");
        pr.setApres("carriere/renseignement-interne-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);%>

    <section class="content-header">
        <h1>Liste renseignement interne</h1>
    </section>
    <section class="content">
        <%
            String lienTableau[] = {pr.getLien() + "?but=carriere/renseignement-interne-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            
            String libEnteteAffiche[] = {"Id", "Personnel", "Libelle", "Type", "Observation", "Date"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<%
} }catch(Exception e){
e.printStackTrace();
}

%>