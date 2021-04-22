
<%@page import="mg.spat.relationhumaine.Enfant_personnel"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Enfant_personnel pj = new Enfant_personnel();
    PageUpdate pi = new PageUpdate(pj, request, (user.UserEJB) session.getValue("u"));
    pi.getFormu().getChamp("nom_prenom_enfant").setLibelle("nom et prenom de l'enfant");
    pi.getFormu().getChamp("dateNaissanceEnfant").setLibelle("Date naisssance de l'enfant");
    pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");
    pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
    pi.setLien((String) session.getValue("lien"));
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
                        <input name="bute" type="hidden" id="bute" value="carriere/enfant-personnel-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Enfant_personnel">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="Enfant_personnel">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
                        