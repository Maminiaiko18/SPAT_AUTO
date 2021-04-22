<%-- 
    Document   : conventionnel-liste
    Created on : 18 nov. 2019, 16:20:26
    Author     : john
--%>

<%@page import="mg.spat.FactureAnalyse"%>
<%@page import="mg.spat.compta.FactPrtMat"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        FactureAnalyse journalCaisse = new FactureAnalyse();
        journalCaisse.setNomTable("factprtmat");
        String listeCrt[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "client", "categorie_client", "designation", "devfact", "numCompte", "daty","mttc", "mtht", "mtavoir", "paye", "reste"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("/conventionnel-liste.jsp");
        /*pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());*/
        pr.getFormu().getChamp("date1").setLibelle("Date min");
        pr.getFormu().getChamp("date2").setLibelle("Date max");
        
        pr.getFormu().getChamp("nmfact").setLibelle("Numero facture");
        pr.getFormu().getChamp("categorie_facture").setLibelle("Catégorie facture");
        pr.getFormu().getChamp("sous_categorie_facture").setLibelle("Sous catégorie");
        pr.getFormu().getChamp("categorie_client").setLibelle("Categorie client");
        pr.getFormu().getChamp("client").setLibelle("Client");
        pr.getFormu().getChamp("numCompte").setLibelle("Compte");
        
        String[] colSomme = {"mttc", "mtht", "mtavoir", "paye", "reste"};
        pr.creerObjetPage(libEntete, colSomme);
        
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Details conventionnel</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/analyse-globale-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=facturation/analyse-globale-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
         
        <%
            String libEnteteAffiche[] ={"N° Facture", "Catégorie facture", "Sous catégorie facture", "Client", "Catégorie client", "Désignation", "devfact", "N° de Compte", "Date","Montant TTC", "Montant HT", "Montant avoir", "Paye", "Reste"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>

        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>

