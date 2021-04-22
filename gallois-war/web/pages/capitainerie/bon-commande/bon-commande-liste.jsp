<%-- 
    Document   : bon-commande-liste
    Created on : 10 déc. 2019, 16:57:52
    Author     : HP
--%>

<%@page import="mg.spat.ContratEngagementBonCommande"%>
<%@page import="mg.spat.Navire"%>
<%@page import="affichage.PageRecherche"%>
<% try{
    ContratEngagementBonCommande cebc = new ContratEngagementBonCommande();
    cebc.setNomTable("contrat_engagement_boncmdlib");
    String listeCrt[] = {"id","num_bc","organe_demandeur","type_commande"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","num_bc","organe_demandeur","type_commande","daty","montant_ht","tva","montant_ttc","montant_autoriser","etat","fournisseur_id","bon_livraison","bon_entre","date_livraison","facturer","ordre_de_paiement","reference_paiement","type_paiement","tva_valider","type","condition_reglement","mode_reglement","note"};
    PageRecherche pr = new PageRecherche(cebc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("capitainerie/bon-commande/bon-commande-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste bon commande</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/bon-commande/bon-commande-liste.jsp" method="post" name="listenavire" id="listenavire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/bon-commande/bon-commande-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Numero BC","Organe demandeur","Type commande","Date","Montant HT","TVA ","Montant TTC","Montant Autoriser","Etat","Fournisseur id","Bon de livraison","Bon d'entrée","Date de livraison","facturer","Ordre de paiement","Référence paiement","Type de paiement","TVA Validé", "type","Condition de reglement","mode de reglement","note"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>
