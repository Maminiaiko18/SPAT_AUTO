<%-- 
    Document   : liaison-placement-modif
    Created on : 22 nov. 2019, 16:15:20
    Author     : Asus
--%>


<%@page import="mg.spat.placement.Liaisonplacement"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Liaisonplacement liaisonP = new Liaisonplacement();
    PageUpdate pi = new PageUpdate(liaisonP, request, (user.UserEJB) session.getValue("u"));
   
    pi.setLien((String) session.getValue("lien"));
    
    UserEJB u = (UserEJB) session.getAttribute("u");
    
    affichage.Champ[] liste = new affichage.Champ[2];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("entite");
    liste[0] = new Liste("identite", mvt, "val", "id");
    
    TypeObjet mvt2 = new TypeObjet();
    mvt2.setNomTable("banque");
    liste[1] = new Liste("idbanque", mvt2, "val", "id");
    
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idbanque").setLibelle("banque");
    pi.getFormu().getChamp("identite").setLibelle("entite");
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification</h1>
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
                        <input name="bute" type="hidden" id="bute" value="placement/liaison-placement-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.placement.Liaisonplacement">
                        <input name="nomtable" type="hidden" id="nomtable" value="Liaisonplacement">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
  