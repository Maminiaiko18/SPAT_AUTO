<%@page import="mg.spat.BonProvisoireComplet"%>
<%@ page import="affichage.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="user.*" %>


<%
    try {

        BonProvisoireComplet bonProvisoire = new BonProvisoireComplet();
        bonProvisoire.setNomTable("bon_provisoire_libcomplet");

        String listeCrt[] = {"id", "folio", "valcaisse", "numpiece", "libelle","beneficiairelib", "remarque","datesaisie", "dateeffet"};
        String listeInt[] = {"datesaisie", "dateeffet"};

        String[] pourcentage = {};
        String somDefaut[] = {"debit","reste"};
        String colDefaut[] = {"id", "folio", "valcaisse", "numpiece", "libelle","beneficiairelib", "remarque","datesaisie", "dateeffet"};

        PageRechercheGroupe pr = new PageRechercheGroupe(bonProvisoire, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 0);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("datesaisie1").setLibelle("Date saisie min");
        pr.getFormu().getChamp("datesaisie2").setLibelle("Date saisie max");
        pr.getFormu().getChamp("dateeffet1").setLibelle("Date effet min");
        pr.getFormu().getChamp("dateeffet2").setLibelle("Date effet max");
        
        pr.setApres("treso/bon-provisoire-analyse.jsp");
        pr.creerObjetPagePourc();

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse bon provisoire</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/bon-provisoire-analyse.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
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