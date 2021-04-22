<%-- 
    Document   : renseignement-interne-modif
    Created on : 30 nov. 2019, 17:08:32
    Author     : Asus
--%>

<%-- 
    Document   : enfant-personnel-modif
    Created on : 30 nov. 2019, 15:47:38
    Author     : Asus
--%>

<%@page import="mg.spat.relationhumaine.Renseigement_interne"%>
<%@page import="service.SpatService"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Renseigement_interne ident = new Renseigement_interne();
    ident.setNomTable("Renseignement_interne");
     
    PageUpdate pi = new PageUpdate(ident, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("IdPersonnel").setVisible(false);
    pi.getFormu().getChamp("daty").setLibelle("Date");
    
    affichage.Champ[] liste = new affichage.Champ[1];
        
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("Type_renseignement_interne");
    liste[0] = new Liste("type", mvt, "VAL", "id");

    pi.getFormu().changerEnChamp(liste);
        
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
                        <input name="bute" type="hidden" id="bute" value="carriere/renseignement-interne-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Renseigement_interne">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>