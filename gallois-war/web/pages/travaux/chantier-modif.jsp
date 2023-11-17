<%-- 
    Document   : mouvement-modif
    Created on : 5 nov. 2019, 15:19:41
    Author     : john
--%>

<%@page import="mg.spat.Chantier"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Chantier chantier = new Chantier();
    chantier.setNomTable("CHANTIER_LIB_NOM");
    PageUpdate pi = new PageUpdate(chantier, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    Chantier base = (Chantier) pi.getBase();
    pi.getFormu().getChamp("idtiers").setValeurLibelle(base.getNomtiers());
    pi.getFormu().getChamp("idtravaux").setValeurLibelle(base.getNomtravaux());
    pi.getFormu().getChamp("codeetablissement").setValeurLibelle(base.getCodeetablissementlib());
    pi.getFormu().getChamp("projet").setValeurLibelle(base.getProjetlib());
    pi.getFormu().getChamp("idpatrimoine").setValeurLibelle(base.getPatrimoinelib());
    pi.getFormu().getChamp("idtravaux").setPageAppel("choix/listeTravauxChoix.jsp","idtravaux;idtravauxlibelle;idpatrimoine;idpatrimoinelibelle");
    pi.getFormu().getChamp("idtiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("idtiers").setAutre("readonly");
    pi.getFormu().getChamp("idtravaux").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setVisible(false);
    pi.getFormu().getChamp("idtiers").setLibelle("Tiers");
    pi.getFormu().getChamp("tierslib").setVisible(false);
    pi.getFormu().getChamp("idtravaux").setLibelle("Travaux");
    pi.getFormu().getChamp("datydebut").setLibelle("date de début");
    pi.getFormu().getChamp("datyfin").setLibelle("date fin");
    pi.getFormu().getChamp("patrimoinelib").setVisible(false);
    pi.getFormu().getChamp("patrimoinedesce").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("avancement").setVisible(false);
    pi.getFormu().getChamp("nomtiers").setVisible(false);
    pi.getFormu().getChamp("nomtravaux").setVisible(false);
    pi.getFormu().getChamp("dirtravaux").setVisible(false);
    pi.getFormu().getChamp("codeetablissementlib").setVisible(false);
    pi.getFormu().getChamp("projetlib").setVisible(false);
    pi.getFormu().getChamp("idpatrimoine").setAutre("readonly");
    pi.getFormu().getChamp("idpatrimoine").setLibelle("Patrimoine");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
    pi.getFormu().getChamp("codeetablissement").setLibelle("Code etablissement");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
    pi.getFormu().getChamp("idpatrimoine").setPageAppel("choix/listePatrimoineChoix.jsp");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
                <div class="box">
                    <h1>Modification chantier</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-warning pull-right" name="Submit2" type="submit">Enregistrer les modifications</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="travaux/chantier-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Chantier">
                        <input name="nomtable" type="hidden" id="nomtable" value="chantier">
                    </form>
                </div>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>