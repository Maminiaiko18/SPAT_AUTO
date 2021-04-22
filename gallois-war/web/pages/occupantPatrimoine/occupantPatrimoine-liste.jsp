<%@page import="mg.spat.OccupantPatrimoine"%>
<%@page import="affichage.PageRecherche"%>

<% try {
        OccupantPatrimoine s = new OccupantPatrimoine();
        s.setNomTable("occupantpatrimoinelib");
        
        String listeCrt[] = {"id", "idpatrimoine", "idoccupant","debutcontrat", "fincontrat", "montant",  "iddevise"};
        String listeInt[] = {"debutcontrat", "fincontrat","montant"};
        String libEntete[] = {"id", "idpatrimoine", "idoccupant","debutcontrat", "fincontrat", "montant",  "iddevise"};
        PageRecherche pr = new PageRecherche(s, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.getFormu().getChamp("idpatrimoine").setLibelle("Patrimoine");
        pr.getFormu().getChamp("idoccupant").setLibelle("Occupant");
        pr.getFormu().getChamp("iddevise").setLibelle("Devise");
        pr.getFormu().getChamp("debutcontrat1").setLibelle("Debut du contrat min");
        pr.getFormu().getChamp("debutcontrat2").setLibelle("Debut du contrat max");
        pr.getFormu().getChamp("fincontrat1").setLibelle("Fin du contrat min");
        pr.getFormu().getChamp("fincontrat2").setLibelle("Fin du contrat max");
        pr.getFormu().getChamp("montant1").setLibelle("Montant min");
        pr.getFormu().getChamp("montant2").setLibelle("Montant max");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setAWhere(" order by debutcontrat desc");
        pr.setApres("occupantPatrimoine/occupantPatrimoine-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des occupants de patrimoine</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=occupantPatrimoine/occupantPatrimoine-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            
            <div class="col-md-4"></div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=occupantPatrimoine/occupantPatrimoine-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Patrimoine", "Occupant","Debut contrat", "Fin contrat", "Montant",  "Devise"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
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





