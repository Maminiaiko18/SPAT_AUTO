
<%@page import="mg.spat.Navire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.PrevisionMaterielNaval"%>

<% 
    try{
    PrevisionMaterielNaval prevision = new PrevisionMaterielNaval();
    prevision.setNomTable("previsionmaterielnavallib2");
    
    String[] champ = {"id","idmateriel_naval","idcommandant","idnatureoperation","daty","heure_depart","date_arrivee","heure_arrivee"};
    String[] libelle_comp = {"Id","Materiel naval","Commandant","Nature operation","Date debut","heure debut","Date fin","Heure fin"};
     
    String listeCrt[] = {"id","idmateriel_naval", "idcommandant", "idnatureoperation"};
    String listeInt[] = {};
    String libEntete[] = {"id","idmateriel_naval", "idcommandant", "idnatureoperation","daty","heure_depart","date_arrivee","heure_arrivee"};
    PageRecherche pr = new PageRecherche(prevision, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setOrdre(" order by daty,date_arrivee desc");  
    pr.setApres("capitainerie/previsionMaterielNaval-liste.jsp");
    
    
    pr.getFormu().getChamp("idmateriel_naval").setLibelle("Matériel naval");
    pr.getFormu().getChamp("idcommandant").setLibelle("Commandant");
    pr.getFormu().getChamp("idnatureoperation").setLibelle("Nature opération");
//    pr.getFormu().getChamp("idnavire").setLibelle("Navire");
    
    String[] colSomme = null;
    
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listenavire.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Prévisions de matériel naval</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/previsionMaterielNaval-liste.jsp" method="post" name="listenavire" id="listenavire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/previsionMaterielNaval-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
//            String libEnteteAffiche[] = {"id","idmateriel_naval", "idcommandant", "idnatureoperation","idnavire","idclient","observation","daty","duree"};
            //String libEnteteAffiche[] = {"ID","Materiel naval", "Commandant", "Nature Operation","Navire","Client","Observation","Date","Duree"};
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
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>