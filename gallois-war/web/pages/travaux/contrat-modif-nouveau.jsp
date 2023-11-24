<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>
<%@page import="mg.spat.Contrat"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Contrat t = new Contrat();
    PageUpdate pi = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    
//    pi.getFormu().getChamp("id").setAutre("readonly");
//    pi.getFormu().getChamp("nom").setLibelle("Nom");
//    pi.getFormu().getChamp("code").setLibelle("Code");
//    pi.getFormu().getChamp("prix").setLibelle("Prix");
//    pi.getFormu().getChamp("date").setLibelle("Date");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
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
                        <input name="bute" type="hidden" id="bute" value="travaux/contrat-fiche-nouveau.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Contrat">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="contrat">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>