

<%@page import="affichage.PageRechercheChoix"%>
<%@page import="mg.spat.compta.*"%>
<%@page import="mg.spat.Navire"%>
<%@page import="affichage.PageRecherche"%>
<% try{
    String idtravaux = request.getParameter("idtravaux");
    ContratChantier cc = new ContratChantier();
    cc.setNomTable("CONTRAT_CHANTIER_TRAVAUX");
    String listeCrt[] = {"idchantier","idtravaux","designation","prestataire"};
    String listeInt[] = {};
    String libEntete[] = {"id","idchantier","designation", "prestataire", "montant"};
    PageRechercheChoix pr = new PageRechercheChoix(cc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeContratChoix.jsp");
    pr.getFormu().getChamp("idchantier").setLibelle("Chantier");
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="wrapper">
    <section class="content-header">
        <h1>Liste contrats</h1>
    </section>
    <section class="content">
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Chantier","Designation", "Prestataire", "Montant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
//            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>

