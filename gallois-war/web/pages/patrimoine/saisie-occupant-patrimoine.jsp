
<%@page import="mg.spat.OccupantPatrimoine"%>
<%@page import="java.util.HashMap"%>
<%@page import="service.SpatService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        HashMap<String, String> listePopup = SpatService.getPopupPatrimoine(null);
        String objet = request.getParameter("objet");

        OccupantPatrimoine op = new OccupantPatrimoine(); 
        PageInsert pi = new PageInsert(op, request, (user.UserEJB) session.getValue("u"));

        affichage.Champ[] liste = new affichage.Champ[1];
        
        TypeObjet dev = new TypeObjet();
        dev.setNomTable("devisedemat");
        liste[0] = new Liste("iddevise", dev, "VAL", "id");
        
        pi.getFormu().changerEnChamp(liste);

        //String idTypePatrimoine=(String)request.getParameter("idPat");
        
//        HashMap<String,String> listeType=SpatService.getTypePatrimoineLibelle(null);
        
//        pi.getFormu().getChamp("idTypePatrimoine").setLibelle("Type patrimoine");
//        //pi.getFormu().getChamp("idTypePatrimoine").setDefaut(idTypePatrimoine);
//        //pi.getFormu().getChamp("idTypePatrimoine").setAutre("readonly");
//        pi.getFormu().getChamp("etat").setLibelle("Etat du patrimoine");

//        pi.getFormu().getChamp("idpatrimoine").setLibelle("Patrimoine");
        pi.getFormu().getChamp("debutcontrat").setLibelle("Début de contrat");
        pi.getFormu().getChamp("debutcontrat").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("fincontrat").setLibelle("Fin de contrat");
        pi.getFormu().getChamp("fincontrat").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("idoccupant").setPageAppel("choix/listeClientCategorieChoix.jsp");
        pi.getFormu().getChamp("idoccupant").setLibelle("Occupant");
        pi.getFormu().getChamp("idoccupant").setAutre("readonly");
        pi.getFormu().getChamp("datechange").setLibelle("Date de change");
        pi.getFormu().getChamp("datechange").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("courschange").setLibelle("Cours de change");

        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie d'un patrimoine</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="patrimoine/patrimoine-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.Patrimoine">
    </form>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
}%>