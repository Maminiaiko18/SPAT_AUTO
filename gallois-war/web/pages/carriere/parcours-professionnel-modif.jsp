
<%@page import="mg.spat.relationhumaine.Parcours_professionnel"%>
<%@page import="mg.spat.relationhumaine.Renseigement_interne"%>
<%@page import="service.SpatService"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Parcours_professionnel ident = new Parcours_professionnel();
   // ident.setNomTable("parcours_professionnel");
    
    
    PageUpdate pi = new PageUpdate(ident, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("Id").setVisible(false);
    pi.getFormu().getChamp("IdPersonnel").setVisible(false);
    pi.getFormu().getChamp("duree").setLibelle("Duree par mois");
    pi.getFormu().getChamp("poste_occupe").setLibelle("Poste occupe");
    pi.getFormu().getChamp("annee_parcours_pro").setLibelle("Annee parcours professionnel");
    
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
                        <input name="bute" type="hidden" id="bute" value="carriere/parcours-professionnel-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Parcours_professionnel">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>