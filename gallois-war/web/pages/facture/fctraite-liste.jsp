<%@page import="facture.tr.FCTraite"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
    FCTraite fctraite = new FCTraite();
    fctraite.setNomTable("FCTRAITE");
    
    
    String libEntete[] = {"id","idTraite","idFC","daty","idJc","daty","montant","etat"};   
    String listeCrt[] = {"id","idTraite","idFC","daty","idJc","daty","montant"};
    String listeInt[] = {"daty","montant"};
    PageRecherche pr = new PageRecherche(fctraite, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facture/fctraite-liste.jsp");

    pr.getFormu().getChamp("idTraite").setLibelle("Traite");
    pr.getFormu().getChamp("idFC").setLibelle("FC");
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.getFormu().getChamp("idJc").setLibelle("Journal Caisse");
    pr.getFormu().getChamp("montant1").setLibelle("Montant Min");
    pr.getFormu().getChamp("montant2").setLibelle("Montant Max");

    String[] colSomme ={};
    pr.creerObjetPage(libEntete, colSomme);
    pr.getTableau().setNameBoutton("Viser");
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste FC Traite</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/fctraite-liste.jsp" method="post" name="fctraite" id="fctraite">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="form" id="form">
            <input type="hidden" name="bute" value="facture/fctraite-liste.jsp"/>
            <input type="hidden" name="classe" value="facture.tr.FCTraite"/>
            <input type="hidden" name="table" value="FCTRAITE"/>
            <input type="hidden" name="acte" id="acte" value="viser"/>
            <%
                out.println(pr.getTableauRecap().getHtml());
            %>
            <br>
            <%
                String libEnteteAffiche[] = {"ID","TRAITE","FC","DATE","JOURNAL CAISSE","DATE","MONTANT","ETAT"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                out.println(pr.getTableau().getHtmlWithCheckbox());
                out.println(pr.getBasPage());
            %>
        </form>
    </section>
</div>
        <% }catch(Exception e) {e.printStackTrace();}%>

