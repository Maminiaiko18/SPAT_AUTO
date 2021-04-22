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
    try{
  
    OccupationMaterielNaval oprevision = new OccupationMaterielNaval();
    oprevision.setNomTable("occupmaterielnavallib");
    
    
    String[] champ = {"id","idmateriel_naval","idcommandant","idnatureoperation","idmanoeuvrebord","heuredebut","datefin","heurefin","position","observation","daty","duree"};
    String[] libelle_comp = {"Id","Materiel naval","Commandant","Nature operation","Manoeuvre bord","Heure debut","date fin","heure fin","Position","Observation","Date début","Duree"};
     
    String listeCrt[] = {"id","idmateriel_naval","idnatureoperation"};
    String listeInt[] = {"duree"};
    String libEntete[] = {"id","idmateriel_naval", "idcommandant", "idnatureoperation","idmanoeuvrebord","observation","daty","duree","heuredebut","datefin","heurefin","position"};
    PageRecherche pr = new PageRecherche(oprevision, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("capitainerie/occupationMaterielNaval-liste.jsp");
    pr.setOrdre("order by daty desc");
    
    pr.getFormu().getChamp("idmateriel_naval").setLibelle("Materiel naval");
//    pr.getFormu().getChamp("idpilote").setLibelle("Pilote");
//    pr.getFormu().getChamp("idcommandant").setLibelle("Commandant");
    pr.getFormu().getChamp("idnatureoperation").setLibelle("Nature operation");
//    pr.getFormu().getChamp("idmanoeuvrebord").setLibelle("Manoeuvre de bord");
//    pr.getFormu().getChamp("idnavire").setLibelle("Navire");
    
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des prestations</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/occupationMaterielNaval-liste.jsp" method="post" name="listeoccupationMaterielNaval" id="listeoccupationMaterielNaval">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capita"
                    + "inerie/occupationMaterielNaval-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            //String libEnteteAffiche[] = {"id","Materiel naval", "Pilote", "Commandant","Nature operation", "Manoeuvre de bord","Navire","Observation","Date","Duree","Heure de debut","Heure de fin","Position"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<%}catch(Exception e){
    e.printStackTrace();
}%>