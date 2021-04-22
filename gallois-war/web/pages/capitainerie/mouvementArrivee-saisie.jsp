
<%@ page import="affichage.PageInsert" %>
<%@page import="mg.spat.Mouvement"%>
<%@page import="mg.spat.Prevision"%>
<%@page import="mg.spat.PrevisionLibComplet"%>
<%@ page import="user.UserEJB" %>
<%@ page import="utilitaire.Constante" %>
<%@ page import="utilitaire.Utilitaire" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Mouvement pj = new Mouvement();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    if(request.getParameter("id")!=null){
        Prevision prev = new Prevision();
        prev.setId(request.getParameter("id"));
        PrevisionLibComplet preveLibC = prev.getPrevisionLibCompletById(null);
        pi.getFormu().getChamp("escale").setDefaut(preveLibC.getId());
        pi.getFormu().getChamp("escale").setValeurLibelle(preveLibC.getEscale());
        pi.getFormu().getChamp("navire").setDefaut(preveLibC.getNavire());
        pi.getFormu().getChamp("navire").setValeurLibelle(preveLibC.getNomnavire());
        pi.getFormu().getChamp("consignataire").setDefaut(preveLibC.getConsignataire());
        pi.getFormu().getChamp("consignataire").setValeurLibelle(preveLibC.getValconsignataire());
        pi.getFormu().getChamp("provenance").setDefaut(preveLibC.getProvenance());
        pi.getFormu().getChamp("provenance").setValeurLibelle(preveLibC.getValtypequaisprovenance()+"-"+preveLibC.getValpaysprovenance());
        pi.getFormu().getChamp("cargaison").setDefaut(preveLibC.getCargaison());
        pi.getFormu().getChamp("cargaison").setValeurLibelle(preveLibC.getValcargaison());
        pi.getFormu().getChamp("destination").setDefaut(preveLibC.getDestination());
        pi.getFormu().getChamp("destination").setValeurLibelle(preveLibC.getValtypequaisdestination()+"-"+preveLibC.getValquaisdestination());
    }
    pi.getFormu().getChamp("navire").setPageAppel("choix/listeNavireChoix.jsp");
//    pi.getFormu().getChamp("cargaison").setPageAppel("choix/listeCargaisonChoix.jsp");
    pi.getFormu().getChamp("cargaison").setPageAppel("choix/listeCargaisonChoixMultiple.jsp");
    pi.getFormu().getChamp("consignataire").setPageAppel("choix/listeConsignataireChoix.jsp");
    pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireExterneChoix.jsp");
    pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireInterneChoix.jsp");
    
    pi.getFormu().getChamp("navire").setAutre("readonly");
    pi.getFormu().getChamp("cargaison").setAutre("readonly");
    pi.getFormu().getChamp("consignataire").setAutre("readonly");
    pi.getFormu().getChamp("destination").setAutre("readonly");
    pi.getFormu().getChamp("provenance").setAutre("readonly");
    pi.getFormu().getChamp("heure").setDefaut(Utilitaire.heureCouranteHMS());
    
    pi.getFormu().getChamp("escale").setPageAppel("choix/listePrevisionChoix.jsp");
    pi.getFormu().getChamp("escale").setAutre("readonly");
    pi.getFormu().getChamp("navire").setLibelle("Navire");
    pi.getFormu().getChamp("dateArrivee").setLibelle("Date effective");
    pi.getFormu().getChamp("PROVENANCE").setLibelle("Provenance");
    pi.getFormu().getChamp("DESTINATION").setLibelle("Destination");
    pi.getFormu().getChamp("CONSIGNATAIRE").setLibelle("Consignataire");
    pi.getFormu().getChamp("dateArrivee").setDefaut(""+Utilitaire.dateDuJour());
    pi.getFormu().getChamp("heure_depart").setVisible(false);
    pi.getFormu().getChamp("date_depart").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    pi.getFormu().getChamp("daty").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("typeMvt").setVisible(false);
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie Occupation</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="typeMvt" type="hidden" id="nature" value="<%=Constante.tpmvtarrive%>">
    <input name="daty" type="hidden" id="nature" value="<%=Utilitaire.dateDuJour()%>">
    <input name="bute" type="hidden" id="bute" value="capitainerie/mouvement-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.Mouvement">
    <input name="nomtable" type="hidden" id="nomtable" value="MOUVEMENT">
    </form>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>