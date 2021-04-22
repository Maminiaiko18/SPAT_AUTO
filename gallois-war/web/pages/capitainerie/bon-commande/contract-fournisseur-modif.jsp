<%-- 
    Document   : bon-commande-modif
    Created on : 10 déc. 2019, 17:39:25
    Author     : HP
--%>

<%@page import="mg.spat.ContratFournisseur"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ContratFournisseur c = new ContratFournisseur();
    PageUpdate pi = new PageUpdate(c, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification Contrat Fournisseur</h1>
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
                        <input name="bute" type="hidden" id="bute" value="capitainerie/bon-commande/contrat-fournisseur-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.ContratFournisseur">
                        <input name="nomtable" type="hidden" id="nomtable" value="contrat_engagement_fournisseur">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
