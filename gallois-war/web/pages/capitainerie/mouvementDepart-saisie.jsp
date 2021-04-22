<%-- 
    Document   : mouvementDepart-saisie
    Created on : 6 nov. 2019, 11:02:23
    Author     : Notiavina
--%>

<%@ page import="affichage.PageInsert" %>
<%@page import="mg.spat.Mouvement"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@ page import="user.UserEJB" %>
<%@ page import="utilitaire.Constante" %>
<%@ page import="utilitaire.Utilitaire" %>

<%
    try {
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Mouvement pj = new Mouvement();
    pj.setId(request.getParameter("id"));
    MouvementLibComplet mvtLibComp = pj.getMouvementLibCompletById(null);
    
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

  
    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("consignataire").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireTousChoix.jsp");
    pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireInterneChoix.jsp");
    pi.getFormu().getChamp("cargaison").setPageAppel("choix/listeCargaisonChoix.jsp");
    
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("cargaison").setAutre("readonly");
    pi.getFormu().getChamp("consignataire").setAutre("readonly");
    pi.getFormu().getChamp("destination").setAutre("readonly");
    pi.getFormu().getChamp("provenance").setAutre("readonly");
    pi.getFormu().getChamp("daty").setVisible(false);
    pi.getFormu().getChamp("typeMvt").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("heure_depart").setLibelle("Heure de départ");
    pi.getFormu().getChamp("heure_depart").setDefaut(Utilitaire.heureCouranteHMS());
    pi.getFormu().getChamp("date_depart").setLibelle("Date de départ");
    pi.getFormu().getChamp("date_depart").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("heure").setVisible(false);
    
    if(mvtLibComp != null){
        pi.getFormu().getChamp("navire").setValeurLibelle(mvtLibComp.getNomnavire());
        pi.getFormu().getChamp("consignataire").setValeurLibelle(mvtLibComp.getValconsignataire());
        pi.getFormu().getChamp("cargaison").setValeurLibelle(mvtLibComp.getValcargaison());
        pi.getFormu().getChamp("provenance").setValeurLibelle(mvtLibComp.getValtypequaisdestination()+"-"+mvtLibComp.getValquaisdestination());
        pi.getFormu().getChamp("escale").setDefaut(mvtLibComp.getIdprevision());
        pi.getFormu().getChamp("escale").setValeurLibelle(mvtLibComp.getEscale());
        pi.getFormu().getChamp("navire").setDefaut(mvtLibComp.getNavire());
        pi.getFormu().getChamp("consignataire").setDefaut(mvtLibComp.getConsignataire());
        pi.getFormu().getChamp("provenance").setDefaut(mvtLibComp.getDestination());
//        pi.getFormu().getChamp("date_depart").setDefaut(Utilitaire.datetostring(mvtLibComp.getDate_depart()));
//        pi.getFormu().getChamp("heure_depart").setDefaut(mvtLibComp.getHeure_depart());
        pi.getFormu().getChamp("cargaison").setDefaut(mvtLibComp.getCargaison());
    }
    
    pi.getFormu().setColOrdre(new String[] {"escale", "navire", "cargaison", "consignataire", "provenance", "DESTINATION", "date_depart", "heure_depart", "remarque"});
    
    //pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("escale").setPageAppel("choix/listePrevisionChoix.jsp");
    pi.getFormu().getChamp("escale").setAutre("readonly required");
    pi.getFormu().getChamp("navire").setLibelle("Navire");
    pi.getFormu().getChamp("dateArrivee").setVisible(false);
    pi.getFormu().getChamp("PROVENANCE").setLibelle("Provenance");
    pi.getFormu().getChamp("DESTINATION").setLibelle("Destination");
    pi.getFormu().getChamp("CONSIGNATAIRE").setLibelle("Consignataire");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Mouvement</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="typeMvt" type="hidden" id="typeMvt" value="<%=Constante.tpmvtdepart%>">
    <input name="daty" type="hidden" id="daty" value="<%=Utilitaire.dateDuJour()%>">
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/mouvement-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Mouvement">
    <input name="nomtable" type="hidden" id="nomtable" value="MOUVEMENT">
    </form>
</div>
    <%} catch(Exception ex) {
ex.printStackTrace();
}%>