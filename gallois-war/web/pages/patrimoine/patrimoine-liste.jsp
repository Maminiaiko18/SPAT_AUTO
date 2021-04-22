<%@page import="mg.spat.Patrimoine"%>
<%@page import="affichage.PageRecherche"%>

<% try {
        Patrimoine s = new Patrimoine();
        s.setNomTable("patrimoinelib");
         if (request.getParameter("etatvue") != null && !request.getParameter("etatvue").equals("")) {
             System.out.println(" MIDITRA "+request.getParameter("etatvue"));
        s.setNomTable(request.getParameter("etatvue"));
    }
        String listeCrt[] = {"id", "idObjet", "idTypePatrimoine", "remarque", "libelle", "description",  "utilisation", "date_debut_contrat","superficie"};
        String listeInt[] = {"date_debut_contrat","superficie"};
        String libEntete[] = {"id", "idObjet", "idTypePatrimoine", "remarque", "etat", "montant", "libelle", "description",  "utilisation", "date_debut_contrat","superficie"};
        PageRecherche pr = new PageRecherche(s, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.getFormu().getChamp("idObjet").setLibelle("objet");
        pr.getFormu().getChamp("idTypePatrimoine").setLibelle("Type du Patrimoine");
        pr.getFormu().getChamp("date_debut_contrat1").setLibelle("Debut du contrat min");
        pr.getFormu().getChamp("date_debut_contrat2").setLibelle("Debut du contrat max");
        pr.getFormu().getChamp("superficie1").setLibelle("superficie min");
        pr.getFormu().getChamp("superficie2").setLibelle("superficie max");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.setApres("patrimoine/patrimoine-liste.jsp");
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
        <form action="<%=pr.getLien()%>?but=patrimoine/patrimoine-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="patrimoinelib" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0) {
                                out.print(" selected");
                            }%>>Tous</option>
                        <option value="patrimoinelibbonetat" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("patrimoinelibbonetat") == 0) {
                                out.print("selected");
                            }%>>Bon &eacute;tat</option>
                        <option value="patrimoinelibdegrade" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("patrimoinelibdegrade") == 0) {
                                out.print("selected");
                            }%>>d&eacute;grad&eacute;</option>
                        <option value="patrimoinelibencoursrep" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("patrimoinelibencoursrep") == 0) {
                                out.print("selected");
                        }%>>En cours de r&eacute;paration</option>
                        <option value="patrimoinelibusee" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("patrimoinelibusee") == 0) {
                                out.print("selected");
                        }%>>Us&eacute;</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=patrimoine/patrimoine-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Objet", "Type de Patrimoine", "Remarque", "Etat", "Montant", "Libelle", "Description",  "Utilisation", "date d'acquisitiont" ,"superficie"};
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





