<%-- 
    Document   : occupationMaterielNaval-liste
    Created on : 25 nov. 2019, 14:45:57
    Author     : Asus
--%>

<%@page import="mg.spat.OccupationMaterielNaval"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@page import="mg.spat.Postedestinataire"%>
<%@page import="mg.spat.Navire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        OccupationMaterielNaval oprevision = new OccupationMaterielNaval();
        oprevision.setNomTable("OCCUPMATERIELNAVALLIB");

//        String[] champ = {"id", "idcommandant", "idnatureoperation","etatlib", "idmanoeuvrebord", "heuredebut", "heurefin", "observation", "daty", "datefin", "duree"};
//        String[] libelle_comp = {"Id", "Commandant", "Nature operation","etat", "Manoeuvre bord", "Heure debut", "Heure fin", "Observation", "Date debut", "Date fin", "Duree"};

        String listeCrt[] = {"idarrivee"};
        String listeInt[] = {};
        String libEntete[] = {"id", "idcommandant", "idnatureoperation","idmanoeuvrebord","daty","heuredebut","datefin","heurefin","duree","etatlib"};
        PageRecherche pr = new PageRecherche(oprevision, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("capitainerie/inc/liste-utilisation-materiels.jsp");
//        pr.setOrdre("order by daty desc");

//        pr.getFormu().getChamp("idmateriel_naval").setLibelle("Materiel naval");
//        pr.getFormu().getChamp("idpilote").setLibelle("Pilote");
//        pr.getFormu().getChamp("idcommandant").setLibelle("Commandant");
//        pr.getFormu().getChamp("idnatureoperation").setLibelle("Nature operation");
//        pr.getFormu().getChamp("idmanoeuvrebord").setLibelle("Manoeuvre de bord");
//        pr.getFormu().getChamp("idnavire").setLibelle("Navire");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>


<%
    String lienTableau[] = {pr.getLien() + "?but=capita"
        + "inerie/occupationMaterielNaval-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    String libEnteteAffiche[] = {"Id", "Commandant", "Opération","Manoeuvre","Date arrivée","Heure début","Date fin","Heure fin","Durée","Etat"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
//    pr.getTableau().construire_libelle(champ, libelle_comp);
%>

    
    
    <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="facturation" id="facturation">
    <%
        pr.getTableau().setNameBoutton("Facturer");
        pr.getTableau().setNameActe("facturerOccupation");
        out.println(pr.getTableau().getHtml());

    //   out.println(pr.getBasPage());
    %>
        <input name="acte" type="hidden" id="acte" value="facturerOccupation">
        <input name="bute" type="hidden" id="bute" value="facture/facture-client-modif.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.OccupationMaterielNaval">
    </form> 
<%} catch (Exception e) {
        e.printStackTrace();
    }%>