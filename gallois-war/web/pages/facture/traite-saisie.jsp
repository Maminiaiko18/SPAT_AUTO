<%-- 
    Document   : casierarticle-saisie
    Created on : 29 d�c. 2022, 09:23:57
    Author     : Rado
--%>


<%@page import="facture.tr.Traite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {

        Traite a = new Traite();
        a.setNomTable("traite");
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        affichage.Champ[] liste = new affichage.Champ[2];

        TypeObjet o = new TypeObjet();
        o.setNomTable("banque");
        liste[0] = new Liste("banque", o, "VAL", "id");
        System.out.println(" coucouzrer");
        TypeObjet obj = new TypeObjet();
        obj.setNomTable("type_piece");
        liste[1] = new Liste("idtypepiece",obj,"desce","id");
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("tiers").setPageAppel("choix/clientCategorieChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("idtypepiece").setLibelle("Type");
        pi.getFormu().getChamp("idtypepiece").setDefaut(Constante.getTypePieceTraite());
        pi.getFormu().getChamp("dateEcheance").setLibelle("Date d'echeance");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idfinaledestination").setVisible(false);
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Traite</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="facture/traite-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="facture.tr.Traite">
        <input name="nomtable" type="hidden" id="classe" value="traite">
    </form>
</div>

<%} catch (Exception e) {
        e.printStackTrace();
    }%>