
<%@page import="mg.spat.MaterielNaval"%>
<%@page import="mg.spat.OccupationMaterielNaval"%>
<%@page import="mg.spat.OccupationMaterielNavalLibComplet"%>
<%@page import="mg.spat.PrevisionMaterielNavalLibComplet"%>
<%@page import="service.PrevisionService"%>
<%@page import="mg.spat.Prevision"%>
<%@page import="mg.spat.Mouvement"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

 <%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    OccupationMaterielNaval occupation = new OccupationMaterielNaval();
    //materielNaval.setNomTable("materielnavallib");
    
    PageUpdate pi = new PageUpdate(occupation, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    //pi.getFormu().getChamp("pavillon").setPageAppel("choix/listePaysChoix.jsp");
    
    affichage.Champ[] liste = new affichage.Champ[3];
    /*
    TypeObjet cons = new TypeObjet();
        cons.setNomTable("pilote");
        liste[0] = new Liste("idpilote", cons, "VAL", "id");*/
    
    TypeObjet carg = new TypeObjet();
        carg.setNomTable("commandant");
        liste[0] = new Liste("idcommandant", carg, "VAL", "id");
    
    TypeObjet nature = new TypeObjet();
        nature.setNomTable("natureoperation");
        liste[1] = new Liste("idnatureoperation", nature, "VAL", "id");

    TypeObjet man = new TypeObjet();
        man.setNomTable("manoeuvrebord");
        liste[2] = new Liste("idmanoeuvrebord", man, "VAL", "id");
    
    pi.getFormu().changerEnChamp(liste);
    
    pi.getFormu().getChamp("idnavire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("idnavire").setAutre("readonly");
    pi.getFormu().getChamp("idarrivee").setPageAppel("choix/listeMouvementArriveeChoix.jsp");
    pi.getFormu().getChamp("idarrivee").setAutre("readonly");
    pi.getFormu().getChamp("idarrivee").setLibelle("Arrivee");
    pi.getFormu().getChamp("idmateriel_naval").setPageAppel("choix/listeMaterielNava.jsp");
    pi.getFormu().getChamp("idmateriel_naval").setAutre("readonly");
    pi.getFormu().getChamp("idmateriel_naval").setLibelle("Flotte");
    pi.getFormu().getChamp("idcommandant").setLibelle("Commandant");
    pi.getFormu().getChamp("idnatureoperation").setLibelle("Nature operation");
    
    pi.getFormu().getChamp("idprevision").setPageAppel("choix/listePrevisionChoix.jsp", "idprevision;idprevisionlibelle;daty;heuredebut;datefin;heurefin");
    pi.getFormu().getChamp("idprevision").setAutre("readonly");
    
    pi.getFormu().getChamp("idpilote").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    pi.getFormu().getChamp("idnavire").setVisible(false);
    pi.getFormu().getChamp("position").setVisible(false);
    pi.getFormu().getChamp("heuredebut").setDefaut(Utilitaire.getHeureActuel());
    pi.getFormu().getChamp("heuredebut").setLibelle("heure d&eacutebut");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daty").setLibelle("Date d&eacutebut");
    pi.getFormu().getChamp("heurefin").setLibelle("heure fin");
    pi.getFormu().getChamp("datefin").setLibelle("Date Fin");
    pi.getFormu().getChamp("idmanoeuvrebord").setLibelle("Manoeuvre bord");
    
    String[] ordreFormu = {"id","idmateriel_naval","daty","heuredebut","datefin","heurefin","idcommandant","idnatureoperation","idmanoeuvrebord","observation","idclient","idpilote","idnavire","duree","position","etat","idarrivee","idprevision"};
    pi.getFormu().setOrdre(ordreFormu);
    pi.preparerDataFormu();
%>

<div class="content-wrapper">
    <div class="row">
        <a href="../apresTarifMultiple.jsp"></a>
        <!--<div class="col-md-6">-->
            <div class="col-md-8 col-md-offset-2">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification prestation</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <!--
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        -->
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="capitainerie/occupationMaterielNaval-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.OccupationMaterielNaval">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <!--<input name="nomtable" type="hidden" id="nomtable" value="Materiel_naval">-->
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
