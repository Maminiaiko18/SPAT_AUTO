a<%-- 
    Document   : analyse-journal-de-caisse
    Created on : 2 dï¿½c. 2019, 08:22:05
    Author     : Antsa
--%>

<%@page import="mg.spat.RecapTreso"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try {
        RecapTreso journal = new RecapTreso();

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        String listeCrt[] = {"libelle", "daty"};
        // String libEntete[] = {"id", "datesaisie", "dateeffet","folio", "caisse", "numpiece", "libelle", "remarque", "datesaisie", "dateeffet"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {""};
        String colDefaut[] = {"libelle"};
        String somDefaut[] = {"montant"};

        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 2, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setDefaut(fin[0]);
        pr.getFormu().getChamp("daty2").setDefaut(fin[1]);
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        pr.setApres("treso/analyse-recap-treso.jsp");
        pr.setOrdre(" order by case  when libelle = 'Placement' then 1 when libelle = 'Banque' then 2 when libelle = 'Caisse' then 3 end");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Recap Trésorerie</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="treso/analyse-recap-treso.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            // String libEnteteAffiche[] = {"Id", "Date de saisie", "Date effet", "Folio", "Caisse", "Numï¿½ro piï¿½ce", "Libelle", "Remarque", "Dï¿½bit", "Crï¿½dit"};
            //pr.getTableau().setLibelleAffiche(libEnteteAffiche);tre
            //System.out.println("ITOOO "+pr.getLien() + "?but=facturation/details-analyse-concessionnairePaye.jsp");

            String lienTableau[] = {pr.getLien() + "?but=treso/details-analyse-recap-treso.jsp"};
            String colonneLien[] = {"montant"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%> 