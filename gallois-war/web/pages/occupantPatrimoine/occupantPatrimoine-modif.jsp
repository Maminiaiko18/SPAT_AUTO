<%@page import="mg.spat.OccupantPatrimoine"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    //idObjet,idTypePatrimoine,
    String autreparsley = "data-parsley-range='[8, 40]' required";
    OccupantPatrimoine patrimoine = new OccupantPatrimoine();
    PageUpdate pi = new PageUpdate(patrimoine, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste = new affichage.Champ[1];
        
    TypeObjet dev = new TypeObjet();
    dev.setNomTable("devisedemat");
    liste[0] = new Liste("iddevise", dev, "VAL", "id");

    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("debutcontrat").setLibelle("Début de contrat");
    pi.getFormu().getChamp("debutcontrat").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("fincontrat").setLibelle("Fin de contrat");
    pi.getFormu().getChamp("fincontrat").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idoccupant").setPageAppel("choix/listePersonnelChoix.jsp");
    pi.getFormu().getChamp("idoccupant").setLibelle("Occupant");
    pi.getFormu().getChamp("idoccupant").setAutre("readonly");
    pi.getFormu().getChamp("datechange").setLibelle("Date de change");
    pi.getFormu().getChamp("datechange").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("courschange").setLibelle("Cours de change");
    pi.getFormu().getChamp("courschange").setDefaut("1");
    pi.getFormu().getChamp("idpatrimoine").setLibelle("Patrimoine");
    pi.getFormu().getChamp("idpatrimoine").setPageAppel("choix/listePatrimoineChoix.jsp");
    pi.getFormu().getChamp("idpatrimoine").setAutre("readonly");
    pi.getFormu().getChamp("iddevise").setLibelle("Devise");
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
                        <input name="bute" type="hidden" id="bute" value="occupantPatrimoine/occupantPatrimoine-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.OccupantPatrimoine">
                        <input name="nomtable" type="hidden" id="nomtable" value="occupantPatrimoine">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>