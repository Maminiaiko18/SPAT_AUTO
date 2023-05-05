
<%@page import="ordremission.OrdreMissionLib"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    OrdreMissionLib t = new OrdreMissionLib();
    t.setNomTable("ordre_mission_lib");
    String listeCrt[] = {"id", "nom", "prenom", "matricule", "numom", "datedepart", "duree", "lieudeplacement"};
    String listeInt[] = {"datedepart", "duree"};
    String libEntete[] = {"id", "numom", "nom", "prenom", "matricule", "fonction", "datedepart", "duree", "lieudeplacement"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setNpp(10);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ordre-mission/ordre-mission-liste.jsp");
    pr.getFormu().getChamp("datedepart1").setLibelle("Date depart min");
    pr.getFormu().getChamp("datedepart2").setLibelle("Date depart max");
    pr.getFormu().getChamp("duree1").setLibelle("Durée min");
    pr.getFormu().getChamp("duree2").setLibelle("Durée max");
    pr.getFormu().getChamp("numom").setLibelle("Num OM");
    pr.getFormu().getChamp("lieudeplacement").setLibelle("Lieu de Placement");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Ordre de Mission</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ordre-mission/ordre-mission-liste.jsp" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ordre-mission" + "/ordre-mission-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Num OM", "Nom", "Prénom", "Fonction", "Matricule", "Date départ", "Durée", "Lieu de Placement"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>



