<%-- 
    Document   : navire-prof-liste
    Created on : 9 f�vr. 2024, 14:19:55
    Author     : bruel
--%>

<%-- 
    Document   : navire-liste
    Created on : 5 nov. 2019, 11:09:25
    Author     : john
--%>

<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="mg.spat.Navire"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        Navire navire = new Navire();
        navire.setNomTable("navireproflib");

        String[] champ = {"id", "nom", "pavillon", "armateurlib", "remarque", "jnt", "jbt", "plt", "lht", "lm", "te", "volume", "type"};
        String[] libelle_comp = {"id", "Nom", "Pavillon","Armateur", "Remarque", "jnt", "jbt", "plt", "lht", "lm", "te", "Volume", "type"};

        String listeCrt[] = {"id", "nom", "pavillon","armateurlib", "remarque", "type"};
        String listeInt[] = {""};
        String libEntete[] = {"id", "nom", "pavillon","armateurlib", "jnt", "jbt", "plt", "lht", "lm", "te", "volume", "remarque", "type"};
        PageRecherche pr = new PageRecherche(navire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
//        pr.getFormu().getChamp("reference").setLibelle("R�f�rence");
        pr.getFormu().getChamp("armateurlib").setLibelle("Armateur");
        pr.setLien((String) session.getValue("lien"));
        pr.setAWhere(" and etat!=" + ConstanteEtat.getEtatAnnuler() + " order by nom asc");
        pr.setApres("capitainerie/navire-prof-liste.jsp");
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
        <h1>Liste Navire</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/navire-prof-liste.jsp" method="post" name="listenavire" id="listenavire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String link = pr.getLien() + "?but=capita"
                + "inerie/navire-fiche.jsp?nomtable=navirelibprof";
            
            String lienTableau[] = {link};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            //String libEnteteAffiche[] = {"Id","R�f�rence", "Nom", "Pavillon","JNT", "JBT", "PLT", "LHT", "LM", "TE", "Volume","Remarque"};
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