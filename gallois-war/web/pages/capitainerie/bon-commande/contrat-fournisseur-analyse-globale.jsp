<%-- 
    Document   : as-commande-analyse
    Created on : 30 d? 2016, 04:57:15
    Author     : Joe
--%>

<%@page import="mg.spat.FactureAnalyse"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>

<%
    try {
        FactureAnalyse mvt = new FactureAnalyse();
        String nomTable = "analyseglobalecontrat";
        if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
            nomTable = request.getParameter("table");
        }
        mvt.setNomTable(nomTable);

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte"};
        String libEntete[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte", "designation", "devfact", "mttc", "mtht", "taxe", "mtdevise", "mtavoir", "paye", "reste"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {""};
        String colDefaut[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "client", "categorie_client", "designation", "devfact", "numCompte", "daty"};
        String somDefaut[] = {"mttc", "mtht", "mtavoir", "paye", "reste"};
        String lien[] = {"mttc", "mtht", "mtavoir", "paye"};
        
        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 14, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        String apreswhere = "";
        /*if(request.getParameter("daty1") == null || request.getParameter("daty2") == null){
        apreswhere = "and daty = '"+utilitaire.Utilitaire.dateDuJour()+"'";
    }*/

        pr.setAWhere(apreswhere);
        /* pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());*/

        pr.getFormu().getChamp("nmfact").setLibelle("Numero facture");
        pr.getFormu().getChamp("categorie_facture").setLibelle("Categorie facture");
        pr.getFormu().getChamp("categorie_client").setLibelle("Categorie client");
        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");

        pr.getFormu().getChamp("daty1").setDefaut(fin[0]);
        pr.getFormu().getChamp("daty2").setDefaut(fin[1]);

        pr.getFormu().getChamp("numcompte").setLibelle("Numero de compte");
        pr.setApres("capitainerie/bon-commande/contrat-fournisseur-analyse-globale.jsp");

        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/bon-commande/contrat-fournisseur-analyse-globale.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    table : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("vue_cmd_client_details_rest") == 0) {%>    
                        <option value="ANALYSEGLOBALECONTRAT" selected>Tous</option>
                        <% } else { %>
                        <option value="ANALYSEGLOBALECONTRAT" >Tous</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("analysefactureConcessionnaire") == 0) {%>    
                        <option value="analyseContratConcessionnaire" selected>Concessionnaire</option>
                        <% } else { %>
                        <option value="analyseContratConcessionnaire" >Concessionnaire</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("analysefactureconventionnel") == 0) {%>
                        <option value="analysecontratconventionnel" selected>Conventionnel</option>
                        <% }
                            { %>
                        <option value="analysecontratconventionnel" >Conventionnel</option>
                        <% }%>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien()
                + "?but=facturation/details-analyse-globaleMttc.jsp",
                pr.getLien() + "?but=facturation/details-analyse-globaleMtht.jsp",
                pr.getLien() + "?but=facturation/details-analyse-globaleMtavoir.jsp",
                pr.getLien() + "?but=facturation/details-analyse-globalePaye.jsp"};
//String colonneLien[] = {"gain"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(lien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            /*String libEnteteAffiche[] = {"N° Facture", "Catégorie facture", "Sous catégorie facture", "Client", "Catégorie client", "Désignation", "devfact", "N° de Compte", "Date", "Montant TTC", "Montant HT", "Montant avoir", "Paye", "Reste"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);*/

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