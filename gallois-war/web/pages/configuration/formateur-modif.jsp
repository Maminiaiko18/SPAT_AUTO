<%@page import="mg.cnaps.formation.FormFormateur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    FormFormateur a;
%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    a = new FormFormateur();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("nom").setLibelle("Nom");  
    pi.getFormu().getChamp("niveau").setLibelle("Niveau"); 
    pi.getFormu().getChamp("experience").setLibelle("Exp&eacute;rience"); 
    pi.getFormu().getChamp("desce").setLibelle("Description"); 
    pi.getFormu().getChamp("remarque").setLibelle("Remarque"); 
    pi.getFormu().getChamp("id_etablissement").setLibelle("Etablissement");
    pi.getFormu().getChamp("id_etablissement").setPageAppel("choix/formetablissementChoix.jsp");        
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification d'un Formateur</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="formformateur">
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
                        <input name="bute" type="hidden" id="bute" value="configuration/formateur-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormFormateur">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="form_formateur">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
