<%@page import="mg.spat.ChantierLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
    ChantierLibComplet chantier = new ChantierLibComplet();
    chantier.setNomTable("CHANTIER_LIB_NOM");
    if(request.getParameter("etatvue")!=null)
        chantier.setNomTable(request.getParameter("etatvue"));
    String listeCrt[] = {"id", "nomtravaux", "nom", "datydebut", "datyfin", "nomtiers", "projetlib", "codeetablissementlib","patrimoinelib","patrimoinedesce"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nomtravaux", "nom", "nomtiers", "datydebut", "datyfin", "patrimoinelib","patrimoinedesce", "montant","avancement", "projetlib", "codeetablissementlib"};
    PageRecherche pr = new PageRecherche(chantier, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/chantier-liste.jsp");
    pr.setOrdre(" order by datydebut desc");
    pr.getFormu().getChamp("datydebut").setLibelle("date de d&eacute;but");
    pr.getFormu().getChamp("datyfin").setLibelle("date fin");
    pr.getFormu().getChamp("nomtravaux").setLibelle("Projet");
    pr.getFormu().getChamp("nomtiers").setLibelle("Tiers");
    pr.getFormu().getChamp("nom").setLibelle("Chantier");
    pr.getFormu().getChamp("PROJETLIB").setLibelle("Code Projet");
    pr.getFormu().getChamp("CODEETABLISSEMENTLIB").setLibelle("code Etab");
    pr.getFormu().getChamp("patrimoinelib").setLibelle("Patrimoine");
    pr.getFormu().getChamp("patrimoinedesce").setLibelle("Description patrimoine");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.travaux.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/chantier-liste.jsp" method="post" name="travaux" id="travaux">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="CHANTIER_LIB_NOM" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("CHANTIER_LIB_NOM")==0) {
                                out.print(" selected");
                            }%>>Tous</option>
                        <option value="CHANTIER_LIB_NOM_CREE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("CHANTIER_LIB_NOM_CREE") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;&eacute;</option>
                        <option value="CHANTIER_LIB_NOM_VALIDE" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("CHANTIER_LIB_NOM_VALIDE") == 0) {
                                out.print("selected");
                            }%>>Valid&eacute;</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux/chantier-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID", "Projet", "chantier", "Tiers", "date de d&eacute;but", "date de fin","patrimoine","desc patrimoine", "montant", "avancement %", "Code projet", "Code Etab"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

