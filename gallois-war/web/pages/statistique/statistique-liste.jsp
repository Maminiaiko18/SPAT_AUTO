<%-- 
    Document   : statistique-liste
    Created on : 19 nov. 2019, 10:43:55
    Author     : john
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.Constante"%>

<% 
    StatistiqueActivite posteDestinataire = new StatistiqueActivite();
    posteDestinataire.setNomTable("statistiqueactivitelib");
    
    if(request.getParameter("etatvue")!=null){
        posteDestinataire.setNomTable(request.getParameter("etatvue"));
    }
    String listeCrt[] = {"id", "titre", "daty", "navire","idtypeActionConteneur","idtypemanipulation"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","titre","daty", "navire","idtypeActionConteneur", "Plein20Pieds", "Vide20Pieds","Plein40Pieds","Vide40Pieds", "teus"};
    PageRecherche pr = new PageRecherche(posteDestinataire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("statistique/statistique-liste.jsp");
    pr.setAWhere(" and idTypeSaisie = '"+Constante.typeconteneur+"' ");
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet typeAction = new TypeObjet();
    typeAction.setNomTable("TYPEACTIONCONTENEUR");
    liste[0] = new Liste("idtypeActionConteneur", typeAction, "val", "id");
    
    pr.getFormu().changerEnChamp(liste);
    
    pr.getFormu().getChamp("idtypeActionConteneur").setLibelle("Type action conteneur");
    pr.getFormu().getChamp("idtypemanipulation").setLibelle("Type manipulation");
    pr.getFormu().getChamp("daty1").setLibelle("Date début");
    pr.getFormu().getChamp("daty2").setLibelle("Date fin");
    
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
        <h1>Liste statistique conteneurs</h1>
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
            String libEnteteAffiche[] = {"Id", "Titre", "Date","navire", "Type action conteneur", "20 pieds plein", "20 pieds vide", "40 pieds plein", "40 pieds vide", "Nb EVP"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>


