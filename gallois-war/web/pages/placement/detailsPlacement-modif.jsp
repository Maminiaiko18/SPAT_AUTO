
<%@page import="mg.spat.placement.DetailsPlacements"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    DetailsPlacements placement = new DetailsPlacements();
    PageUpdate pi = new PageUpdate(placement, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("idMere").setVisible(false);
    pi.getFormu().getChamp("mois").setAutre("readonly");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
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
                        <input name="bute" type="hidden" id="bute" value="placement/detailsPlacement-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.placement.DetailsPlacements">
                        <input name="nomtable" type="hidden" id="nomtable" value="detailsplacement">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
