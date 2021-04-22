
<%@page import="mg.spat.relationhumaine.Conge"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Conge pj = new Conge();
    PageUpdate pi = new PageUpdate(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("date_debut_conge").setLibelle("Date de début de congé");
    pi.getFormu().getChamp("date_fin_conge").setLibelle("Date de fin de congé");
    pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
    pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");
    pi.getFormu().getChamp("nombre").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
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
                        <input name="bute" type="hidden" id="bute" value="carriere/conge-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Conge">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="Conge">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
                        