<%@page import="java.sql.Date"%>
<%@page import="affichage.Liste"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@page import="utilitaire.Utilitaire"%>
<%
    try {

        FactureClient lv = new FactureClient();
        lv.setNomTable("FACTURE_CLIENT_UNIONV");
        String listeCrt[] = {"daty","tierslib"};
        String listeInt[] = {"daty"};
        
        
        String[] pourcentage = {};        
        String somDefaut[] = {"montantreste"};
        String colDefaut[] = {"tierslib"};

        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        

        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
         
        pr.setApres("facture/analyse-client.jsp");
        pr.creerObjetPagePourc();
        
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Solde par client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres()%>" method="post" name="formulaire" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
           
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-liste-vaovao.jsp"};
            String colonneLien[] = {"tierslib"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            
            String libelleAffiche[] = {"Tiers","Montant reste",""};
            pr.getTableau().setLibelleAffiche(libelleAffiche);
            out.println(pr.getTableau().getHtml());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>