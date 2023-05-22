

<%@page import="ordremission.IndemniteMission"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    IndemniteMission t = new IndemniteMission();
    t.setNomTable("indemnite_mission_lib");
    String listeCrt[] = {"idcategorieprofessionnel", "fraishebergement","fraisrestauration","fraisdeplacement","fraisforfaitaire","daty"};
    String listeInt[] = {"fraishebergement","fraisrestauration","fraisdeplacement","fraisforfaitaire","daty"};
    String libEntete[] = {"id","idcategorieprofessionnellib", "fraishebergement","fraisrestauration","fraisdeplacement","fraisforfaitaire","daty"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des indemnités de mission");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ordre-mission/indemnite-mission-liste.jsp");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("fraisrestauration1").setLibelle("Frais restauration min");
    pr.getFormu().getChamp("fraisrestauration2").setLibelle("Frais restauration max");
    pr.getFormu().getChamp("fraishebergement1").setLibelle("Frais hébergement min");
    pr.getFormu().getChamp("fraishebergement2").setLibelle("Frais hébergement max");
    pr.getFormu().getChamp("fraisdeplacement1").setLibelle("Frais déplacement min");
    pr.getFormu().getChamp("fraisdeplacement2").setLibelle("Frais déplacement max");
    pr.getFormu().getChamp("fraisforfaitaire1").setLibelle("Frais forfaitaire min");
    pr.getFormu().getChamp("fraisforfaitaire2").setLibelle("Frais forfaitaire max");
    pr.getFormu().getChamp("idcategorieprofessionnel").setLibelle("Catégorie Professionnel");
    pr.getFormu().getChamp("idcategorieprofessionnel").setPageAppel("choix/categorie-professionnel-choix.jsp");
    pr.getFormu().getChamp("idcategorieprofessionnel").setAutre("readonly");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=ordre-mission/indemnite-mission-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles à afficher
    String libEnteteAffiche[] = {"Id","Catégorie Professionnel", "Frais d'hébergement","Frais de restauration","Frais de déplacement","Frais forfaitaire","Date"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
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



