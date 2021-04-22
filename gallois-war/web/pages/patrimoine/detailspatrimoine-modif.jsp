<%@page import="mg.spat.DetailsPatrimoine"%>
<%@page import="mg.spat.Patrimoine"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    //idObjet,idTypePatrimoine,
    String autreparsley = "data-parsley-range='[8, 40]' required";
    DetailsPatrimoine lp = new DetailsPatrimoine();
    PageUpdate pi = new PageUpdate(lp, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idPatrimoine").setLibelle("Patrimoine");
    pi.getFormu().getChamp("idPatrimoine").setPageAppel("choix/listePatrimoineChoix.jsp");
    pi.getFormu().getChamp("natureObjet").setLibelle("Nature de l'objet");
    pi.getFormu().getChamp("surfaceOccupe").setLibelle("Surface occupée");
    pi.getFormu().getChamp("surfaceDisponible").setLibelle("Surface disponible");
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
                        <input name="bute" type="hidden" id="bute" value="patrimoine/detailspatrimoine-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.DetailsPatrimoine">
                        <input name="nomtable" type="hidden" id="nomtable" value="details_patrimoine">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>