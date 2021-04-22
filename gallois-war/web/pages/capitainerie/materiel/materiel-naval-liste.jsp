<%@page import="mg.spat.MaterielNaval" %>
<%@page import="affichage.PageRecherche"%>
<%
   MaterielNaval materiel=new MaterielNaval();
   materiel.setNomTable("materielnavallib");
   
    String[] champ = {"id","denomination","date_aquisition","idMarque","puissance","detenteur","maintenance","idType_materiel","immatriculation"};
    String[] libelle_comp = {"id","Dénomination","Date d'aquisition","Marque","Puissance","Détenteur","Maintenance"," Type matériel","Immatriculation"};
   
   String listeCrt[] = {"id","denomination", "date_aquisition", "idMarque","puissance","detenteur","maintenance","idType_materiel","immatriculation"};
   String listeInt[] = {"date_aquisition","puissance"};
    String libEntete[] = {"id","denomination", "date_aquisition", "idMarque","puissance","detenteur","maintenance","idType_materiel","immatriculation"};
    PageRecherche pr = new PageRecherche(materiel, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("Date_aquisition1").setLibelle("Date d'acquisition Min");
    pr.getFormu().getChamp("Date_aquisition2").setLibelle("Date d'acquisition Max");
    pr.getFormu().getChamp("Puissance1").setLibelle("Puissance Min");
    pr.getFormu().getChamp("Puissance2").setLibelle("Puissance Max");
    pr.getFormu().getChamp("IdType_materiel").setLibelle("Type de matériel");
    pr.getFormu().getChamp("IdMarque").setLibelle("Marque");

    pr.setApres("capitainerie/materiel/materiel-naval-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Materiel Naval</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/materiel/materiel-naval-liste.jsp" method="post" name="listenavire" id="listenavire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capita"
                    + "inerie/materiel/materiel-naval-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            //String libEnteteAffiche[] = {"id","denomination", "Date d'acquisition", "Marque","puissance","detenteur","maintenance","Type de materiel","immatriculation"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().construire_libelle(champ, libelle_comp);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>