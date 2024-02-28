<%-- 
    Document   : liaison-placement-modif
    Created on : 22 nov. 2019, 16:15:20
    Author     : Asus
--%>


<%@page import="mg.spat.placement.PlacementBanqueCaisse"%>
<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PlacementBanqueCaisse liaisonP = new PlacementBanqueCaisse();
    PageUpdate pi = new PageUpdate(liaisonP, request, (user.UserEJB) session.getValue("u"));

    pi.setLien((String) session.getValue("lien"));

    UserEJB u = (UserEJB) session.getAttribute("u");

    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("banque");
    liste[0] = new Liste("val", mvt, "val", "id");

    TypeObjet mvt2 = new TypeObjet();
    mvt2.setNomTable("caisse");
    liste[1] = new Liste("desce", mvt2, "val", "id");

    pi.getFormu().changerEnChamp(liste);
    pi.preparerDataFormu();

    pi.getFormu().getChamp("val").setLibelle("Banque");
    pi.getFormu().getChamp("desce").setLibelle("Caisse");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification placement banque</h1>
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
                        <input name="bute" type="hidden" id="bute" value="placement/placement-banquecaisse-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.placement.PlacementBanqueCaisse">
                        <input name="nomtable" type="hidden" id="nomtable" value="PLACEMENT_BANQUE_CAISSE">
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</div>
