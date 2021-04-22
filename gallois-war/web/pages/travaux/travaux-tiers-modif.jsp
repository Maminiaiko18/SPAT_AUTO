<%-- 
    Document   : mouvement-modif
    Created on : 5 nov. 2019, 15:19:41
    Author     : john
--%>

<%@page import="mg.spat.Travaux_tiers"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Travaux_tiers tiers = new Travaux_tiers();
    PageUpdate pi = new PageUpdate(tiers, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("idtravaux").setPageAppel("choix/listeTravauxChoix.jsp");
    pi.getFormu().getChamp("idtiers").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("idtiers").setAutre("readonly");
    pi.getFormu().getChamp("idtravaux").setAutre("readonly");
    pi.getFormu().getChamp("idtiers").setLibelle("tiers");
    pi.getFormu().getChamp("idtravaux").setLibelle("travaux");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="travaux/travaux-tiers-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Travaux_tiers">
                        <input name="nomtable" type="hidden" id="nomtable" value="travaux_tiers">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>