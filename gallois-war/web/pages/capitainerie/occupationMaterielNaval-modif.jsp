<%-- 
    Document   : postedestinataire-modif
    Created on : 5 nov. 2019, 16:19:24
    Author     : john
--%>


<%@page import="mg.spat.OccupationMaterielNaval"%>
<%@page import="mg.spat.MaterielNaval"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.OccupationMaterielNavalLibComplet"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        OccupationMaterielNaval posteDestinataire = new OccupationMaterielNaval();

        PageUpdate pi = new PageUpdate(posteDestinataire, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        UserEJB u = (UserEJB) session.getAttribute("u");

        pi.getFormu().getChamp("idnavire").setPageAppel("choix/listeNavireChoix.jsp");
        pi.getFormu().getChamp("idnavire").setAutre("readonly");
        pi.getFormu().getChamp("idarrivee").setPageAppel("choix/listeMouvementArriveeChoix.jsp");
        pi.getFormu().getChamp("idarrivee").setAutre("readonly");
        pi.getFormu().getChamp("idarrivee").setLibelle("Arrivee");

      /*  pi.getFormu().getChamp("idclient").setPageAppel("choix/listeClientChoix.jsp");
        pi.getFormu().getChamp("idclient").setAutre("readonly");*/

        affichage.Champ[] liste = new affichage.Champ[4];

        TypeObjet cons = new TypeObjet();
        cons.setNomTable("pilote");
        liste[0] = new Liste("idpilote", cons, "VAL", "id");

        TypeObjet carg = new TypeObjet();
        carg.setNomTable("commandant");
        liste[1] = new Liste("idcommandant", carg, "VAL", "id");

        /*Navire pilote = new Navire();
        liste[3] = new Liste("idnavire", pilote, "nom", "id");*/

        TypeObjet nature = new TypeObjet();
        nature.setNomTable("natureoperation");
        liste[2] = new Liste("idnatureoperation", nature, "VAL", "id");

        TypeObjet man = new TypeObjet();
        man.setNomTable("manoeuvrebord");
        liste[3] = new Liste("idmanoeuvrebord", man, "VAL", "id");

        /*Liste li = new Liste("position");
        String [] val = {"1", "2"};
        String [] aff = {"tribord", "bâbord"};
        li.ajouterValeur( val, aff );
        liste[4]=li;*/

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("idmateriel_naval").setPageAppel("choix/listeMaterielNava.jsp");
        pi.getFormu().getChamp("idmateriel_naval").setAutre("readonly");
        pi.getFormu().getChamp("idmateriel_naval").setLibelle("Flotte");
        pi.getFormu().getChamp("idcommandant").setLibelle("Commandant");
        pi.getFormu().getChamp("idnatureoperation").setLibelle("Nature op&eacuteration");
        //pi.getFormu().getChamp("idclient").setVisible(false);
        pi.getFormu().getChamp("daty").setLibelle("Date d&eacutebut");
        pi.getFormu().getChamp("datefin").setLibelle("Date Fin");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("heuredebut").setDefaut(Utilitaire.getHeureActuel());
        pi.getFormu().getChamp("idmanoeuvrebord").setLibelle("Manoeuvre bord");
        pi.getFormu().getChamp("heuredebut").setLibelle("heure d&eacutebut");
        pi.getFormu().getChamp("heurefin").setLibelle("heure fin");
        //pi.getFormu().getChamp("heurefin").setAutre("required");
        pi.getFormu().getChamp("idpilote").setLibelle("Pilote");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("duree").setVisible(false);
        pi.getFormu().getChamp("idpilote").setVisible(false);
        pi.getFormu().getChamp("idnavire").setVisible(false);
        pi.getFormu().getChamp("position").setVisible(false);

        String[] ordreFormu = {"id","idmateriel_naval","idcommandant","idnatureoperation","idmanoeuvrebord","observation","idarrivee","daty","heuredebut","datefin","heurefin","idpilote","idnavire","duree","position","etat"};
        pi.getFormu().setOrdre(ordreFormu);

        
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
                <div class="col-md-8 col-md-offset-2">
                    <h1>Modification prestation</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="recettebordereau" id="recettebordereau">
                        <%
                            pi.getFormu().makeHtmlInsertTabIndex();
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="capitainerie/occupationMaterielNaval-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="mg.spat.OccupationMaterielNaval">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                    </form>
                </div>
</div>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>