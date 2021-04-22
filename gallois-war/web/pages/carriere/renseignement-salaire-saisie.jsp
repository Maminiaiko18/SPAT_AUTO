
<%@page import="mg.spat.relationhumaine.InfoPersonnelGlobal"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    InfoPersonnelGlobal pj = new InfoPersonnelGlobal();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("indemnite_fonction").setLibelle("Indemnité de fonction");
    pi.getFormu().getChamp("indemnite_conge_paye").setLibelle("Indemnité congé payé");
    pi.getFormu().getChamp("indemnite_deplacement").setLibelle("Indemnité de déplacement");
    pi.getFormu().getChamp("indemnite_risque").setLibelle("Indemnité de risque");
    pi.getFormu().getChamp("autre_avantage").setLibelle("Autre avantage");
    pi.getFormu().getChamp("mode_paiement").setLibelle("Mode de paiement");
    pi.getFormu().getChamp("numero_virement").setLibelle("Numero de virement");
    pi.getFormu().getChamp("numero_cnaps").setLibelle("Numero cnaps");
    pi.getFormu().getChamp("salaire_base").setLibelle("Salaire de base");
    
    pi.getFormu().getChamp("idindemnite").setVisible(false);
    pi.getFormu().getChamp("idavantagenature").setVisible(false);
    
    //pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
    pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
    if(request.getParameter("idpersonnel")!=null){
        pi.getFormu().getChamp("idPersonnel").setDefaut(request.getParameter("idpersonnel"));
    }
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie renseignement salaire</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insertRenseignementSalaire">
    <input name="bute" type="hidden" id="bute" value="carriere/renseignement-salaire-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.InfoPersonnelGlobal">
    </form>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>