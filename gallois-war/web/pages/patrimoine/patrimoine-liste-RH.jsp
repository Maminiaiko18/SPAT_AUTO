<%@page import="mg.spat.Patrimoine"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Patrimoine s = new Patrimoine();
    s.setNomTable("PATRIMOINERHLIB");
    String listeCrt[] = {"id","idObjet","idTypePatrimoine","remarque","libelle","description","occupant","utilisation","debut_contrat","fin_contrat"};
    String listeInt[] = {"debut_contrat","fin_contrat"};
    String libEntete[] = {"id","idObjet","idTypePatrimoine","remarque","etat","montant","libelle","description","occupant","utilisation","debut_contrat","fin_contrat"};
    PageRecherche pr = new PageRecherche(s, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.getFormu().getChamp("idObjet").setLibelle("objet");
    pr.getFormu().getChamp("idTypePatrimoine").setLibelle("Type du Patrimoine");
    pr.getFormu().getChamp("debut_contrat1").setLibelle("Debut du contrat min");
    pr.getFormu().getChamp("debut_contrat2").setLibelle("Debut du contrat max");
    pr.getFormu().getChamp("fin_contrat1").setLibelle("Fin du contrat min");
    pr.getFormu().getChamp("fin_contrat2").setLibelle("Fin du contrat max");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    /*pr.getFormu().getChamp("debut_contrat").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("fin_contrat").setDefaut(utilitaire.Utilitaire.dateDuJour());*/
    pr.setApres("patrimoine/patrimoine-liste-RH.jsp");
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
        <h1>Liste patrimoine</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=patrimoine/patrimoine-liste-RH.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=patrimoine/patrimoine-fiche-RH.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Objet","Type de Patrimoine","Remarque","Etat","Montant","Libelle","Description","Occupant","Utilisation","Debut contrat","Fin contrat"};
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





