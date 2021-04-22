<%@page import="mg.spat.Patrimoine"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    //idObjet,idTypePatrimoine,
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Patrimoine patrimoine = new Patrimoine();
    PageUpdate pi = new PageUpdate(patrimoine, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idObjet").setLibelle("Objet");
    pi.getFormu().getChamp("debut_contrat").setLibelle("Date d'acquisition");
    pi.getFormu().getChamp("fin_contrat").setLibelle("fin du contrat");
//    pi.getFormu().getChamp("idObjet").setPageAppel("choix/listeMaterielNaval.jsp");
//    pi.getFormu().getChamp("idObjet").setAutre("readonly");
    //pi.getFormu().getChamp("occupant").setPageAppel("choix/listeClientCategorieChoix");
    //pi.getFormu().getChamp("occupant").setAutre("readonly");
    pi.getFormu().getChamp("occupant").setVisible(false);
    pi.getFormu().getChamp("fin_contrat").setVisible(false);
    pi.getFormu().getChamp("date_change").setLibelle("Date de change");
    pi.getFormu().getChamp("date_change").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("cours_change").setLibelle("Cours de change");
     affichage.Champ[] liste = new affichage.Champ[3];
    
    TypeObjet mvt = new TypeObjet();
    mvt.setNomTable("typepatrimoine");
    liste[0] = new Liste("idTypePatrimoine", mvt, "VAL", "id");
   
    pi.getFormu().getChamp("idTypePatrimoine").setAutre("readonly");
    TypeObjet etat = new TypeObjet();
    etat.setNomTable("etatpatrimoine");
    liste[1] = new Liste("etat", etat, "VAL", "id");
    
    TypeObjet dev = new TypeObjet();
    dev.setNomTable("devisedemat");
    liste[2] = new Liste("devise", dev, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("etat").setLibelle("etat du patrimoine");
    pi.getFormu().getChamp("idTypePatrimoine").setLibelle("Type Patrimoine");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification patrimoine</h1>
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
                        <input name="bute" type="hidden" id="bute" value="patrimoine/patrimoine-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.Patrimoine">
                        <input name="nomtable" type="hidden" id="nomtable" value="patrimoine">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>