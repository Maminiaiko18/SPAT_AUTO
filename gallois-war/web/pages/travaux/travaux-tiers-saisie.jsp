
<%@page import="mg.spat.TravauxTiersLibComplet"%>
<%@page import="mg.spat.Travaux_tiers"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String popup = request.getParameter("typetiers").equalsIgnoreCase("partenaire") ? "choix/listeTiersChoixPartenaire.jsp" : "choix/listeTiersChoixPrestatire.jsp" ;
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Travaux_tiers pj = new Travaux_tiers();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    pi.getFormu().getChamp("idtravaux").setLibelle("Travaux"); 
    if(request.getParameter("idtravaux") != null){
        pi.getFormu().getChamp("idtravaux").setDefaut(request.getParameter("idtravaux"));
    }else{
        pi.getFormu().getChamp("idtravaux").setPageAppel("choix/listeTravauxChoix.jsp");
    }
    pi.getFormu().getChamp("idtiers").setLibelle("Tiers"); 
    pi.getFormu().getChamp("idtiers").setPageAppel( popup ); 
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un travail tiers</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="travaux/travaux-tiers-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Travaux_tiers">
    </form>
    
    <%if (request.getParameter("idtravaux") != null) {
        TravauxTiersLibComplet t = new TravauxTiersLibComplet();
        String listeCrt[] = {"id","idtravauxtiers","typetiers","nom","description","valtypetravaux","datedebut","datefin"};
        String listeInt[] = {"datedebut","datefin"};
        String libEntete[] = {"id","nom","description","idtravauxtiers","valtypetravaux","datedebut","datefin","nomtiers","descriptiontiers","avancement"};
        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("travaux/travaux-tiers-complet-liste.jsp");
        pr.setAWhere(" and id = '"+request.getParameter("idtravaux")+"'");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
    %>

    <section class="content-header">
        <h1>Liste chantier par travaux </h1>
    </section>
    <section class="content">
        <%
            String libEnteteAffiche[] = {"Id","Nom","Description","Travaux tiers","Type travaux","Date debut","Date fin","Tiers","Description","Avancement"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>
    </section>
    <%}%>
    
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>