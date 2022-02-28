<%-- 
    Document   : facture-client-fille
    Created on : 12 mai 2021, 14:37:18
    Author     : nyamp
--%>
<%@page import="affichage.Liste"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="facture.FactureFournisseurFilleData"%>
<%@page import="facture.FactureFournisseurDetails"%>
<%@page import="facture.FactureClientFilleData"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>
<%@page import="facture.FactureClient"%>
<%@page import="facture.FactureClientDetails"%>
<%@page import="bean.AdminGen"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{    
    FactureFournisseurDetails cht = new FactureFournisseurDetails();
    cht.setNomTable("FACTFOURN_FILL_LIB_REST_TAXE");
    String libEntete[] = {"id", "designation", "quantite", "qtelivree", "restealivrer", "devise", "compte", "pu", "taux", "montanttaux", "tva", "montanttaxe", "montantHTEuro", "montantTVAEuro", "reduction", "majoration","montantTTC"};
    String listeCrt[] = {"compte", "mois", "annee"};
    String listeInt[] = {"mois", "annee"};

    PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    Liste[] listes = new Liste[2];
    String[] moisInt = {"", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    String[] moisStr = {"--", "Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};
    listes[0] = new Liste("mois1", moisStr, moisInt);
    listes[1] = new Liste("mois2", moisStr, moisInt);
    pr.getFormu().changerEnChamp(listes);
    
    pr.getFormu().getChamp("compte").setLibelle("Compte");
    pr.getFormu().getChamp("mois1").setLibelle("Mois min");
    pr.getFormu().getChamp("mois2").setLibelle("Mois max");
    
    pr.getFormu().getChamp("annee1").setLibelle("Année min");
    pr.getFormu().getChamp("annee2").setLibelle("Année max");
    
    String awhere = "";
    String mois1 = request.getParameter("mois1");
    String mois2 = request.getParameter("mois2");
    String annee1 = request.getParameter("annee1");
    String annee2 = request.getParameter("annee2");
    
    if(mois1 == null){
        awhere += " and mois >= "+Utilitaire.getMoisEnCoursReel()+" ";
        pr.getFormu().getChamp("mois1").setDefaut(Utilitaire.getMoisEnCoursReel()+"");
    }
    if(mois2 == null){
        awhere += " and mois <= "+Utilitaire.getMoisEnCoursReel()+" ";
        pr.getFormu().getChamp("mois2").setDefaut(Utilitaire.getMoisEnCoursReel()+"");
    }
    if(annee1 == null){
        awhere += " and annee >= "+Utilitaire.getAnneeEnCours()+" ";
        pr.getFormu().getChamp("annee1").setDefaut(Utilitaire.getAnneeEnCours()+"");
    }
    if(annee2 == null){
        awhere += " and annee <= "+Utilitaire.getAnneeEnCours()+" ";
        pr.getFormu().getChamp("annee2").setDefaut(Utilitaire.getAnneeEnCours()+"");
    }
    
    pr.setApres("facture/facture-fournisseur-details-liste.jsp");
    String[] colSomme = {"montant","montanttaxe","montantTTC"};
    pr.setOrdre(" order by daty,rang");
    pr.setAWhere(awhere);
    pr.creerObjetPage(libEntete, colSomme); 
   
    String libEnteteAffiche[] = {"id", "designation", "quantité", "quantité livrée", "reste à livrer", "devise", "compte", "pu", "taux", "montant", "tva", "montant Tva", "HT Euro", "TVA Euro", "RED.%", "MAJ.%","Montant TTC"};
    pr.getTableau().setLibeEntete(libEnteteAffiche);

 %>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture fournisseur détails</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            
        </form>
        <% out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <% out.println(pr.getTableau().getHtml());%>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% }catch(Exception ex){
    ex.printStackTrace();
}
    %>

