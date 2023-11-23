<%@page import="mg.spat.Avenant"%>
<%@page import="affichage.PageRecherche"%>
<% 
    Avenant chantier = new Avenant();
    chantier.setNomTable("AVENANTLIB");
    if(request.getParameter("etatvue")!=null)
        chantier.setNomTable(request.getParameter("etatvue"));
    String listeCrt[] = {"id", "devise", "unite"};
    String listeInt[] = {};
    String libEntete[] = {"id", "date_signature", "objet", "debut_avenant", "fin_avenant", "duree", "redevance_fixe","devise", "redevance_variable","unite", "redevance_domaniale", "redevance_locative"};
    PageRecherche pr = new PageRecherche(chantier, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/avenant-liste.jsp");
    pr.getFormu().getChamp("devise").setLibelle("Devise");
    //pr.getFormu().getChamp("patrimoinedesce").setLibelle("Description patrimoine");
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
        <form action="<%=pr.getLien()%>?but=travaux/avenant-liste.jsp" method="post" name="travaux" id="travaux">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="AVENANTLIB" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("AVENANTLIB")==0) {
                                out.print(" selected");
                            }%>>Tous</option>
                        <option value="AVENANTLIB_C" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("AVENANTLIB_C") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;&eacute;</option>
                        <option value="AVENANTLIB_V" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("AVENANTLIB_V") == 0) {
                                out.print("selected");
                            }%>>Valid&eacute;</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux/avenant-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Date de signature", "Objet", "D&eacute;but avenant", "Fin avenant", "Dur&eacute;e", "Redevance fixe","Devise", "Redevance variable","unit&eacute;", "Redevance domaniale", "Redevance locative"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

