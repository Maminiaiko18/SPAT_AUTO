<%-- 
    Document   : liste-utilisation-materiels
    Created on : 25 févr. 2021, 10:11:58
    Author     : Sanda
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
        oprevision.setNomTable("prestations_escale");
        String id = request.getParameter("id");
        String listeCrt[] = {"idprevision"};
        String listeInt[] = {};
        String libEntete[] = {"id", "idcommandant", "idnatureoperation", "idarrivee", "idmanoeuvrebord", "daty", "heuredebut", "datefin", "heurefin", "duree", "etatlib"};
        PageRecherche pr = new PageRecherche(oprevision, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("capitainerie/quais/inc/liste-utilisation-materiels.jsp");
        pr.setAWhere(" and idprevision = '" + id + "'");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>


<%
    String lienTableau[] = {pr.getLien() + "?but=capitainerie/occupationMaterielNaval-fiche.jsp",
                            pr.getLien() + "?but=capitainerie/mouvement-fiche.jsp"};
    String colonneLien[] = {"id","idarrivee"};
    String[] urlLienMultiple = {"id","idarrivee"};
    String[] urlLienAffiche = {"id","id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setUrlLienAffiche(urlLienAffiche);
    pr.getTableau().setUrlLien(urlLienMultiple);

    String libEnteteAffiche[] = {"Id", "Commandant", "Opération","Mouvement","Manoeuvre","Date arrivée","Heure début","Date fin","Heure fin","Durée","Etat"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
//    pr.getTableau().construire_libelle(champ, libelle_comp);
%>



<form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="facturation" id="facturation">
    <%
        pr.getTableau().setNameBoutton("Facturer");
        pr.getTableau().setNameActe("facturerOccupation");
        out.println(pr.getTableau().getHtmlWithCheckbox());


    //   out.println(pr.getBasPage());
    %>
    <input name="acte" type="hidden" id="acte" value="facturerOccupation">
    <input name="bute" type="hidden" id="bute" value="facture/facture-client-modif.jsp">
    <input name="classe" type="hidden" id="classe" value="mg.spat.OccupationMaterielNaval">
</form> 
<%} catch (Exception e) {
        e.printStackTrace();
    }%>
