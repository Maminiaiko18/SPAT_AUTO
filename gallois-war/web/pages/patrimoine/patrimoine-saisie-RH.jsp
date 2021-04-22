
<%@page import="java.util.HashMap"%>
<%@page import="service.SpatService"%>
<%@page import="mg.spat.Patrimoine"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        HashMap<String, String> listePopup = SpatService.getPopupPatrimoine(null);
        String objet = request.getParameter("objet");

        Patrimoine pj = new Patrimoine();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));

        pi.getFormu().getChamp("idObjet").setLibelle("Objet");
        
        if(objet!=null && objet.compareTo("")!=0){
            pi.getFormu().getChamp("idObjet").setPageAppel(listePopup.get(objet));
            pi.getFormu().getChamp("idObjet").setAutre("readonly");
        }

        affichage.Champ[] liste = new affichage.Champ[3];

        TypeObjet etat = new TypeObjet();
        etat.setNomTable("etatpatrimoine");
        liste[0] = new Liste("etat", etat, "VAL", "id");
        
        TypeObjet etat1 = new TypeObjet();
        etat1.setNomTable("typepatrimoine");
        liste[1] = new Liste("idTypePatrimoine", etat1, "VAL", "id");
        
        TypeObjet devise = new TypeObjet("DEVISEDEMAT");
        liste[2] = new Liste("devise", devise, "VAL", "id");
        pi.getFormu().changerEnChamp(liste);

        //String idTypePatrimoine=(String)request.getParameter("idPat");
        
        HashMap<String,String> listeType=SpatService.getTypePatrimoineLibelle(null);
        
        pi.getFormu().getChamp("idTypePatrimoine").setLibelle("Type patrimoine");
        //pi.getFormu().getChamp("idTypePatrimoine").setDefaut(idTypePatrimoine);
        //pi.getFormu().getChamp("idTypePatrimoine").setAutre("readonly");
        pi.getFormu().getChamp("etat").setLibelle("Etat du patrimoine");
        pi.getFormu().getChamp("debut_contrat").setLibelle("Début de contrat");
        pi.getFormu().getChamp("debut_contrat").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("fin_contrat").setLibelle("Fin de contrat");
        pi.getFormu().getChamp("fin_contrat").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("occupant").setPageAppel("choix/listeIdentificationChoixSimple.jsp");
        pi.getFormu().getChamp("occupant").setAutre("readonly");
        
        pi.getFormu().getChamp("date_change").setLibelle("Date de change");
        pi.getFormu().getChamp("date_change").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("cours_change").setLibelle("Cours de change");

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
        <input name="bute" type="hidden" id="bute" value="patrimoine/patrimoine-fiche-RH.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.Patrimoine">
    </form>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>