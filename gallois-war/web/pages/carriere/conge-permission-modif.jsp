
<%@page import="mg.spat.relationhumaine.InfoCongePermission"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    InfoCongePermission ident = new InfoCongePermission();
    PageUpdate pi = new PageUpdate(ident, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("date_debut_conge").setLibelle("Date début congé");
    pi.getFormu().getChamp("date_fin_conge").setLibelle("Date fin congé");
    pi.getFormu().getChamp("date_debut_permission").setLibelle("Date début permission");
    pi.getFormu().getChamp("date_fin_permission").setLibelle("Date fin permission");
    pi.getFormu().getChamp("nombrepermission").setLibelle("Nombre permission");
    pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");
    pi.getFormu().getChamp("idPermission").setVisible(false);
    pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
    pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
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
                        <input name="bute" type="hidden" id="bute" value="carriere/conge-permission-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.InfoCongePermission">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>