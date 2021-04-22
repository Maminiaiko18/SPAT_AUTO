<%-- 
    Document   : analyse-conventionnel
    Created on : 29 nov. 2019, 10:52:34
    Author     : Asus
--%>


<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="mg.spat.MouvementLibelleComplet"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>

<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {

        MouvementLibComplet mvt = new MouvementLibComplet();

        String[] champ = {"id","escale","navire","consignataire","heure","provenance","destination","remarque","valmvt","valconsignataire","desceconsignataire","referencenavire","nomnavire","pavillonnavire","remarquenavire","valquaisprovenance","interneprovenance","valpaysprovenance","quaidestination","internedestination","valpaysdestination","idtypemvt","idquaiprovenance","idquaidestination","cargaison","cargval","cargdesce","heure_depart","daty","datearrivee","date_depart","duree","jntnavire","jbtnavire","pltnavire","lhtnavire","lmnavire","tenavire","volumenavire","longueurdestination","profondeurdestination","tirantdestination","longueurprovenance","profondeurprovenance","tirantprovenance","valcargaison","valquaisdestination"};
        String[] libelle_comp = {"Id","Escale","Navire","Consignataire","Heure","Provenance","Destination","Remarque","Type mvt","Consignataire","Consignataire","Reference navire","Navire","Pavillon navire","Remarque navire","Quai provenance","Interne provenance","Pays provenance","Quai destination","Interne destination","Pays destination","Type mouvement","Quai provenance","Quai destination","ID Cargaison","Cargaison valeur","Cargaison description","Heure depart","Datye","Date arrivee ","Date depart","duree","JNT navire","JBT navire","PLT navire","LHT navire","LM navire","TE navire","volumenavire","Longueur destination","profondeurdestination","Tirant destination","Longueur provenance","Profondeur provenance","Tirant provenance","Cargaison","Quais destination"};
     
    
        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"datearrivee", "nomnavire", "valmvt", "consignataire", "valcargaison", "date_depart"};
        String listeInt[] = {"datearrivee", "date_depart"};
        String[] pourcentage = {"nombrepargroupe"};
        String colDefaut[] = {"datearrivee", "heure", "nomnavire", "valmvt", "valconsignataire", "valcargaison", "valpaysprovenance", "valquaisprovenance", "date_depart", "heure_depart", "valpaysdestination", "valquaisdestination"};
        String somDefaut[] = {};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 11, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("datearrivee1").setLibelle("Date arrivée (min)");
        pr.getFormu().getChamp("datearrivee2").setLibelle("Date arrivée (max)");
        pr.getFormu().getChamp("date_depart1").setLibelle("Date départ (min)");
        pr.getFormu().getChamp("date_depart2").setLibelle("Date départ (max)");

        pr.getFormu().getChamp("datearrivee1").setDefaut(fin[0]);
        pr.getFormu().getChamp("datearrivee2").setDefaut(fin[1]);
        pr.getFormu().getChamp("date_depart1").setDefaut(fin[0]);
        pr.getFormu().getChamp("date_depart2").setDefaut(fin[1]);
        pr.getFormu().getChamp("valmvt").setLibelle("type mouvement");
        pr.getFormu().getChamp("valcargaison").setLibelle("Cargaison");
        pr.setApres("but=capitainerie/quais/analysestatistique-quais.jsp");
        pr.creerObjetPagePourc();

%>
<script>
    function changerDesignation() {
        document.analyse.submit();

    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse statistique</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/quais/analysestatistique-quais.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            pr.getTableau().setColonneLien(somDefaut);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            //String libEnteteAffiche[] = {"Date arrivée", "heure arrivée", "Navire", "Type mouvement", "Consignataire", "Cargaison", "Pays provenance", "Quai provenance", "Date départ", "Heure départ", "Pays destination", "Quai destination", "Nombre par groupe"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            
            pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
