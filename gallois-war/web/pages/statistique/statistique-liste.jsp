<%-- 
    Document   : statistique-liste
    Created on : 19 nov. 2019, 10:43:55
    Author     : john
--%>

<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
    StatistiqueActivite posteDestinataire = new StatistiqueActivite();
    posteDestinataire.setNomTable("statistiqueactivitelib");
    
    if(request.getParameter("etatvue")!=null){
        posteDestinataire.setNomTable(request.getParameter("etatvue"));
    }
    String listeCrt[] = {"id", "titre", "daty", "navire","idtypeActionConteneur","idtypemanipulation"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","titre","daty", "navire","idtypeActionConteneur","idtypemanipulation","Plein20Pieds","Vide20Pieds","Plein40Pieds","Vide40Pieds"};
    PageRecherche pr = new PageRecherche(posteDestinataire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("statistique/statistique-liste.jsp");
    pr.getFormu().getChamp("idtypeActionConteneur").setLibelle("Type action conteneur");
    pr.getFormu().getChamp("idtypemanipulation").setLibelle("Type manipulation");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listestatistique.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=statistique/statistique-liste.jsp" method="post" name="listestatistique" id="listestatistique">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="STATISTIQUEACTIVITELIB" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("statistiqueactivitelib")==0) {
                                out.print(" selected");
                            }%>>Tous</option>
                        <option value="STATISTIQUEACTIVITELIBC" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("statistiqueactivitelibc") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;e(s)</option>
                        <option value="STATISTIQUEACTIVITELIBV" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("statistiqueactivitelibv") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;(s)</option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=statist"
                    + "ique/statistique-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Titre", "Date","navire", "Type action conteneur", "Type manipulation", "20 pieds plein", "20 pied vide", "40 pied plein", "40 pied vide"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>


