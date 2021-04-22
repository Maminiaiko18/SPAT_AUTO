<%@page import="mg.spat.relationhumaine.Diplome"%>
<%@page import="mg.spat.relationhumaine.Renseigement_interne"%>
<%@page import="service.SpatService"%>
<%@page import="mg.spat.relationhumaine.InfoProfessionnel"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Diplome diplome = new Diplome();
    diplome.setNomTable("DIPLOME");
    PageUpdate pi = new PageUpdate(diplome, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.preparerDataFormu();
      
  //  pi.getFormu().getChamp("Annee_diplome").setLibelle("Année de diplôme");
    pi.getFormu().getChamp("Id").setVisible(false);
    pi.getFormu().getChamp("IdPersonnel").setVisible(false);
    pi.getFormu().getChamp("annee_diplome").setLibelle("Ann&eacute;e dipl&ocirc;me");
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
                        <input name="bute" type="hidden" id="bute" value="carriere/diplomes-obtenus-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Diplome">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>