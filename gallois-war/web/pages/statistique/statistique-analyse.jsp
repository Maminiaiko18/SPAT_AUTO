<%@page import="mg.spat.StatistiqueActivite"%>
<%@ page import="affichage.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="user.*" %>


<%
    try {

        StatistiqueActivite lv = new StatistiqueActivite();
        lv.setNomTable("statistiqueActivitelib");
        String listeCrt[] = {"id","titre","idtypeActionConteneur","idnomsociete","idtypemanipulation","idtypemarchandise","idtypemesure","typeSaisie","Plein20Pieds","Vide20Pieds","Plein40Pieds","Vide40Pieds","poids"};
        String listeInt[] = {"Plein20Pieds","Vide20Pieds","Plein40Pieds","Vide40Pieds","poids"};

        String[] pourcentage = {};
        String somDefaut[] ={"Plein20Pieds","Vide20Pieds","Plein40Pieds","Vide40Pieds","poids"};
        String colDefaut[] =  {"id","titre","idtypeActionConteneur","idnomsociete","idtypemanipulation","idtypemarchandise","idtypemesure","typeSaisie"};

        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 0);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("Plein20Pieds1").setLibelle("Plein20Pieds Min");
        pr.getFormu().getChamp("Plein20Pieds2").setLibelle("Plein20Pieds Max");
        
        pr.getFormu().getChamp("Vide20Pieds1").setLibelle("Vide20Pieds Min");
        pr.getFormu().getChamp("Vide20Pieds2").setLibelle("Vide20Pieds Max");
        
        pr.getFormu().getChamp("Plein40Pieds1").setLibelle("Plein40Pieds Min");
        pr.getFormu().getChamp("Plein40Pieds2").setLibelle("Plein40Pieds Max");
        
        pr.getFormu().getChamp("Vide40Pieds1").setLibelle("Vide40Pieds Min");
        pr.getFormu().getChamp("Vide40Pieds2").setLibelle("Vide40Pieds Max");
        
        pr.getFormu().getChamp("poids1").setLibelle("poids Max");
        pr.getFormu().getChamp("poids2").setLibelle("poids Max");
        
        pr.setApres("statistique/statistique-analyse.jsp");
        pr.creerObjetPagePourc();

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=statistique/statistique-analyse.jsp" method="post" name="analyse" id="analyse">
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