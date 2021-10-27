<%@page import="facture.FactureClientDetails"%>
<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureClientDetails cht = new FactureClientDetails();
//    cht.setNomTable("facture_client_fille_lib_reste");
        cht.setNomTable("FACT_CLT_FILL_LIB_REST_TAXE");
        String libEntete[] = {"id", "designation", "quantite", "qtelivree", "restealivrer", "devise", "compte", "pu", "taux", "montanttaux", "tva", "montantTva", "montantHTEuro", "montantTVAEuro", "activitelib", "heureDebut", "heureFin", "reduction", "majoration"};
        String listeCrt[] = {"id","idmere","designation","compte"};
        String listeInt[] = {};
        
        PageRecherche pr = new PageRecherche(cht, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by daty,rang");
        pr.setApres("facture/fille-multiple.jsp");
        
        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete,colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Scinder facture</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/fille-multiple.jsp" method="post" name="incident" id="incident">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
             
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=apresScinder.jsp" method="post" name="form_arif" id="form_arif">
            <input type="hidden" name="bute" id="bute" value="facture/facture-client-modif.jsp"/>
            <input type="hidden" name="classe" value="facture.FactureClientDetails"/>
            <input type="hidden" name="acte" id="acte" value="scinder"/>
            <input type="hidden" name="param" id="acte" value="<%=request.getParameter("idmere")%>"/>
        <%
            

            String libEnteteAffiche[] = {"id", "designation", "quantité", "quantité livrée", "reste à livrer", "devise", "compte", "pu", "taux", "montant", "tva", "montant Tva", "HT Euro", "TVA Euro", "Activite", "Heure début", "Heure fin", "RED.%", "MAJ.%"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
//            out.println(pr.getTableau().getHtml());
            pr.getTableau().setNameActe("scinder");
            pr.getTableau().setNameBoutton("Scinder");
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        

        </form>
        <% out.println(pr.getBasPage());%>
    </section>
</div>

<% } catch (Exception e) {
        e.printStackTrace();
    }%>