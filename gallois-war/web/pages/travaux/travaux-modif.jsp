<%-- 
    Document   : mouvement-modif
    Created on : 5 nov. 2019, 15:19:41
    Author     : john
--%>

<%@page import="mg.spat.Travaux"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Travaux travaux = new Travaux();
    travaux.setNomTable("travauxlib");
    PageUpdate pi = new PageUpdate(travaux, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");

    pi.getFormu().getChamp("datedebut").setLibelle("Date début");
    pi.getFormu().getChamp("datefin").setLibelle("Date fin");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("datefin").setLibelle("Date fin");
    
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("typeTravaux");
    liste[0] = new Liste("idtypetravaux", mvt, "VAL", "id");
    TypeObjet mvt2 = new TypeObjet();
    mvt2.setNomTable("devisedemat");
    liste[1] = new Liste("iddevise", mvt2, "VAL", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.preparerDataFormu();
    pi.getFormu().getChamp("idtypetravaux").setLibelle("Type de travaux");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
    pi.getFormu().getChamp("projetlib").setVisible(false);
    pi.getFormu().getChamp("codeetablissementlib").setVisible(false);
    pi.getFormu().getChamp("codeetablissement").setLibelle("Code etablissement");
    pi.getFormu().getChamp("projet").setAutre("readonly");
    pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
    pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
    pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
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
                    <input name="bute" type="hidden" id="bute" value="travaux/travaux-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="mg.spat.Travaux">
                    <input name="nomtable" type="hidden" id="nomtable" value="travaux">
                </form>
            </div>
        </div>
    </div>
</div>