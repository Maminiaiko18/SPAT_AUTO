
<%@page import="ordremission.RetourOM"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    try{
        String autreparsley = "data-parsley-range='[8, 40]' required";
        RetourOM om = new RetourOM();
        PageUpdate pi = new PageUpdate(om, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("id").setVisible(false);
        pi.getFormu().getChamp("datearrivee").setLibelle("Date arriv&eacute;e");
        pi.getFormu().getChamp("heurearrivee").setLibelle("Heure arriv&eacute;e");
        pi.getFormu().getChamp("prixunitaire").setLibelle("Prix unitaire");
        pi.getFormu().getChamp("nombres").setVisible(false);
        pi.getFormu().getChamp("autres").setVisible(false);
        pi.getFormu().getChamp("idom").setVisible(false);
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-7">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
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
                        <input name="bute" type="hidden" id="bute" value="ordre-mission/retourom-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="ordremission.RetourOM">
                        <input name="nomtable" type="hidden" id="nomtable" value="RETOUR_OM">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>