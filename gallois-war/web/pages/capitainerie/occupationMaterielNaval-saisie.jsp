
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="mg.spat.Mouvement"%>
<%@page import="mg.spat.PrevisionMaterielNavalLibComplet"%>
<%@page import="service.PrevisionService"%>
<%@page import="mg.spat.OccupationMaterielNaval"%>
<%@page import="mg.spat.MaterielNaval"%>
<%@page import="mg.spat.Navire"%>
<%@page import="mg.spat.Prevision"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (UserEJB) session.getValue("u");
    
    OccupationMaterielNaval pj = new OccupationMaterielNaval();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    
    if(request.getParameter("id")!=null){
        PrevisionMaterielNavalLibComplet prev= PrevisionService.getPrevisionMaterielNavalById(request.getParameter("id"),null);
        pi.getFormu().getChamp("idnavire").setDefaut(prev.getIdnavire());
        pi.getFormu().getChamp("idmateriel_naval").setDefaut(prev.getIdmateriel_naval());
        pi.getFormu().getChamp("idcommandant").setDefaut(prev.getIdcommandant());
        pi.getFormu().getChamp("idnatureoperation").setDefaut(prev.getIdnatureoperation());
        //pi.getFormu().getChamp("idclient").setDefaut(prev.getIdclient());
        pi.getFormu().getChamp("observation").setDefaut(prev.getObservation());
        pi.getFormu().getChamp("idarrivee").setDefaut(prev.getIdarrivee());
        pi.getFormu().getChamp("idarrivee").setValeurLibelle(prev.getIdarrivee());
        pi.getFormu().getChamp("idmateriel_naval").setValeurLibelle(prev.getDenomination());
        pi.getFormu().getChamp("idarrivee").setValeurLibelle(prev.getIdarriveelib());
    }
    
    pi.getFormu().getChamp("heuredebut").setDefaut(Utilitaire.getHeureActuel());
    
    pi.getFormu().getChamp("idnavire").setPageAppel("choix/listeNavireChoix.jsp");
    pi.getFormu().getChamp("idnavire").setAutre("readonly");
    pi.getFormu().getChamp("idarrivee").setPageAppel("choix/listeMouvementArriveeChoix.jsp");
    pi.getFormu().getChamp("idarrivee").setAutre("readonly");
    pi.getFormu().getChamp("idarrivee").setLibelle("Arrivee");
    pi.getFormu().getChamp("idclient").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[3];
    
    TypeObjet carg = new TypeObjet();
    carg.setNomTable("commandant");
    liste[0] = new Liste("idcommandant", carg, "VAL", "id");
    
    TypeObjet nature = new TypeObjet();
    nature.setNomTable("natureoperation");
    liste[1] = new Liste("idnatureoperation", nature, "VAL", "id");
    
    TypeObjet man = new TypeObjet();
    man.setNomTable("manoeuvrebord");
    liste[2] = new Liste("idmanoeuvrebord", man, "VAL", "id");

    /*Liste li = new Liste("position");
    String [] val = {"1", "2"};
    String [] aff = {"tribord", "bâbord"};
    li.ajouterValeur( val, aff );
    liste[4]=li;*/
    
    pi.getFormu().changerEnChamp(liste);
    
    List<String> col = new ArrayList();
    List<String> colVal = new ArrayList();
    
    col.add("daty");
    col.add("datefin");
    
    if(request.getParameter("idmvt")!=null && !request.getParameter("idmvt").isEmpty()){
        Mouvement[] mvt = (Mouvement[]) CGenUtil.rechercher(new Mouvement(), null, null, " and id='"+request.getParameter("idmvt")+"' ");
        pi.getFormu().getChamp("idarrivee").setDefaut(request.getParameter("idmvt"));
        pi.getFormu().getChamp("idprevision").setDefaut(mvt[0].getEscale());
        
//        if(mvt[0].getDatearrivee() != null) pi.getFormu().getChamp("daty").setDefaut(Utilitaire.datetostring(mvt[0].getDatearrivee()));
        pi.getFormu().getChamp("heuredebut").setDefaut(Utilitaire.champNull(mvt[0].getHeure()));
//        if(mvt[0].getDate_depart() != null) pi.getFormu().getChamp("datefin").setDefaut(Utilitaire.datetostring(mvt[0].getDate_depart()));
        pi.getFormu().getChamp("heurefin").setDefaut(Utilitaire.champNull(mvt[0].getHeure_depart()));
        
        String manoeuvre = mvt[0].getTypeMvt().equalsIgnoreCase(Constante.idtypeMvtDepart) ? Constante.manoeuvreSortie : Constante.manoeuvreEntree;
        pi.getFormu().getChamp("idmanoeuvrebord").setDefaut(manoeuvre);
        
        String datedeb = mvt[0].getDatearrivee() != null ? Utilitaire.datetostring(mvt[0].getDatearrivee()) : "";
        String datefin = mvt[0].getDate_depart() != null ? Utilitaire.datetostring(mvt[0].getDate_depart()) : "";
        colVal.add(datedeb);
        colVal.add(datefin);
    }
    
//    pi.getFormu().getChamp("idmateriel_naval").setPageAppel("choix/listeMaterielNava.jsp");
    pi.getFormu().getChamp("idprevision").setPageAppel("choix/listePrevisionChoix.jsp");
    pi.getFormu().getChamp("idprevision").setAutre("readonly");
    pi.getFormu().getChamp("idmateriel_naval").setPageAppel("choix/listeMaterielNavalChoixMultiple.jsp");
    pi.getFormu().getChamp("idmateriel_naval").setAutre("readonly");
    pi.getFormu().getChamp("idmateriel_naval").setLibelle("Flotte");
    pi.getFormu().getChamp("idcommandant").setLibelle("Commandant");
    pi.getFormu().getChamp("idnatureoperation").setLibelle("Nature op&eacuteration");
    //pi.getFormu().getChamp("idclient").setVisible(false);
    pi.getFormu().getChamp("daty").setLibelle("Date d&eacutebut");
    pi.getFormu().getChamp("datefin").setLibelle("Date Fin");
    
    pi.getFormu().getChamp("idmanoeuvrebord").setLibelle("Manoeuvre bord");
    pi.getFormu().getChamp("heuredebut").setLibelle("heure d&eacutebut");
    pi.getFormu().getChamp("heurefin").setLibelle("heure fin");
    pi.getFormu().getChamp("Idprevision").setLibelle("Prévision");
    //pi.getFormu().getChamp("heurefin").setAutre("required");
    
    if(request.getParameter("estCommandant") != null && request.getParameter("estCommandant").trim().equalsIgnoreCase("1")) {
        if(u.getCommandant()!=null){
            pi.getFormu().getChamp("idcommandant").setDefaut(""+u.getCommandant().getId());
        }
//        pi.getFormu().getChamp("idarrivee").setDefaut(Utilitaire.champNull(request.getParameter("idEscale")));
        pi.getFormu().getChamp("idprevision").setDefaut(Utilitaire.champNull(request.getParameter("idEscale")));
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.champNull(request.getParameter("date_debut")));
        pi.getFormu().getChamp("heuredebut").setDefaut(Utilitaire.champNull(request.getParameter("heure_debut")));
        pi.getFormu().getChamp("datefin").setDefaut(Utilitaire.champNull(request.getParameter("date_fin")));
        pi.getFormu().getChamp("heurefin").setDefaut(Utilitaire.champNull(request.getParameter("heure_fin")));
        
        colVal.add(request.getParameter("date_debut"));
        colVal.add(request.getParameter("date_fin"));
    }
    
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("duree").setVisible(false);
    pi.getFormu().getChamp("idnavire").setVisible(false);
    pi.getFormu().getChamp("position").setVisible(false);
    pi.getFormu().getChamp("idpilote").setVisible(false);
    
    if(request.getParameter("idPrevision")!=null && !request.getParameter("idPrevision").isEmpty()){
        Prevision[] prevision = (Prevision[]) CGenUtil.rechercher(new Prevision(), null, null, " and id='"+request.getParameter("idPrevision")+"' ");
        pi.getFormu().getChamp("idprevision").setDefaut(prevision[0].getId());
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.formatterDaty(prevision[0].getDate_arrivee()));
        pi.getFormu().getChamp("heuredebut").setDefaut(prevision[0].getHeure_arrivee());
        pi.getFormu().getChamp("datefin").setDefaut(Utilitaire.formatterDaty(prevision[0].getDate_depart()));
        pi.getFormu().getChamp("heurefin").setDefaut(prevision[0].getHeure_depart());
        
        colVal.add(Utilitaire.formatterDaty(prevision[0].getDate_arrivee()));
        colVal.add(Utilitaire.formatterDaty(prevision[0].getDate_depart()));
    }
    
    String[] ordreFormu = {"daty", "heuredebut", "datefin", "heurefin", "idmateriel_naval", "idcommandant", "idnatureoperation", "idmanoeuvrebord", "observation", "idarrivee", "idprevision", "id", "idpilote", "idnavire", "idclient", "duree", "position", "etat"};
    pi.getFormu().setOrdre(ordreFormu);
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
    
%>
<div class="content-wrapper">
    <h1>Saisie prestation</h1>    
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="capitainerie/occupationMaterielNaval-fiche.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.OccupationMaterielNaval">
    </form>
</div>
<script language="JavaScript">
    $(document).ready(function() {
        <%for(int i=0; i<col.size(); i++){%>
            document.getElementById("<%=col.get(i)%>").value = "<%=Utilitaire.champNull(colVal.get(i))%>";
        <%}%>
    });
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>
