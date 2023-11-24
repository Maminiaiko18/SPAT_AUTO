
<%@page import="utilisateur.Role"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Role r = new Role();
    PageUpdate pi = new PageUpdate(r, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    
    pi.getFormu().getChamp("descrole").setLibelle("description");
    pi.getFormu().getChamp("rang").setLibelle("Rang");    
    
    pi.getFormu().getChamp("rang").setVisible(false);
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
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
                        <input name="bute" type="hidden" id="bute" value="parametre/role-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="utilisateur.Role">
                        <input name="nomtable" type="hidden" id="nomtable" value="roles">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>