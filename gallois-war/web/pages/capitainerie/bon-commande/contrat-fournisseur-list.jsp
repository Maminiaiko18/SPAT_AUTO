<%-- 
    Document   : bon-commande-liste
    Created on : 10 déc. 2019, 16:57:52
    Author     : HP
--%>

<%@page import="mg.spat.ContratFournisseur"%>
<%@page import="mg.spat.Navire"%>
<%@page import="affichage.PageRecherche"%>
<% try{
    ContratFournisseur navire = new ContratFournisseur();
    String listeCrt[] = {"id","nom","nif","mail","ref_fournisseur","ville","cp"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","stat","nif","rc","fax","telephone","mail","adresse","beneficiaire","condition_reglement","mode_reglement","ref_fournisseur","ville","cp"};
    PageRecherche pr = new PageRecherche(navire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("capitainerie/bon-commande/contrat-fournisseur-list.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Contrat fournisseur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=capitainerie/bon-commande/contrat-fournisseur-list.jsp" method="post" name="listenavire" id="listenavire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/bon-commande/contrat-fournisseur-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Nom","Stat","NIF","RC","Fax","Telephone","Mail","Adresse","Beneficiaire","Condition reglement","Mode reglement","Ref fournisseur","Ville","CP"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>


