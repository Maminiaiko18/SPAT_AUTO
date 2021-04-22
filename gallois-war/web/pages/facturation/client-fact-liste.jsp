<%-- 
    Document   : client-fact-liste
    Created on : 24 janv. 2020, 12:14:32
    Author     : rajao
--%>



<%@page import="mg.spat.ClientFactureCategorieClient"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{    
        ClientFactureCategorieClient journalCaisse = new ClientFactureCategorieClient();
        journalCaisse.setNomTable("cltfactclientlib");
        String listeCrt[] = {"id","idClient","idtype_fact_cat_client","statut"};
        String listeInt[] = null;
        String libEntete[] = {"id","idClient","idtype_fact_cat_client","statut"};
        PageRecherche pr = new PageRecherche(journalCaisse, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("/client-fact-liste.jsp");
        /*pr.getFormu().getChamp("dateEffet1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("dateEffet2").setDefaut(utilitaire.Utilitaire.dateDuJour());*/
        //pr.getFormu().getChamp("statut").setLibelle("Date min");
        pr.getFormu().getChamp("idtype_fact_cat_client").setLibelle("Type facture categorie client");
        pr.getFormu().getChamp("idClient").setLibelle("Client");
        
        String[] colSomme =null;
        pr.creerObjetPage(libEntete, colSomme);
        
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Client Facture categorie</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturation/client-fact-liste.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=facturation/client-fact-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br/>
         
        <%
            String libEnteteAffiche[] ={"id","Client","Type facture categorie client","statut"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
        %>

        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>
