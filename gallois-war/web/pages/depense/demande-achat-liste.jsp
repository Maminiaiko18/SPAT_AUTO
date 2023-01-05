
<%@page import="mg.spat.DemandeAchatMere"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        DemandeAchatMere demandeMere = new DemandeAchatMere();
        demandeMere.setNomTable("dem_achat_merelib");

        String listeCrt[] = {"id","num", "designation","codeetablissementlib","projetlib","idengagementlib","daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id","num","designation","codeetablissementlib","projetlib","idengagementlib","daty"};

        PageRecherche pr = new PageRecherche(demandeMere, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("codeetablissementlib").setLibelle("Code etablissemment");
        pr.getFormu().getChamp("designation").setLibelle("Designation");
        pr.getFormu().getChamp("idengagementlib").setLibelle("Engagement");
        pr.getFormu().getChamp("num").setLibelle("No.");

        pr.setApres("depense/demande-achat-liste.jsp");
        
        String[] colSomme =null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function submitFormulaire(){
        document.getElementById("engagement").submit();
    }
</script>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des DASE</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=depense/demande-achat-liste.jsp" method="post" name="achat" id="engagement">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=depense/demande-achat-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] ={"Id", "No.", "Désignation", "Code établissement","Projet","Engagement","Date"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>