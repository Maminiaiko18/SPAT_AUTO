
<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String condition = "";
        EtatFactureMontantDaty ff = new EtatFactureMontantDaty();
        ff.setNomTable("ffregul_vise");
        String listeCrt[] = {};
        String listeInt[] = {""};
        String libEntete[] = {"id", "daty", "nomfournisseur", "numfact", "designation", "dateemission", "datyecheance", "montantttc", "montantpaye", "reste"};
        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/facture-fournisseur-liste.jsp");
        String[] colSomme = null;
        if(request.getParameter("id") != null){
            condition = " and idbon='"+request.getParameter("id")+"'";
        }
        pr.setAWhere(condition);
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
    <div>
        <a class="btn btn-primary "  href="<%=(String) session.getValue("lien") + "?but=facture/facture-fournisseur-saisie-multiple.jsp&idbon="+request.getParameter("id")%>" style="margin-right: 10px">Nouvelle facture</a>
    </div>
    <section class="content-header">
        <h1>Liste facture fournisseur</h1>
    </section>
    <section class="">

        <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="tarif" id="tarif">
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche.jsp"};

            String colonneLien[] = {"id", "remarque"};
            String[] urlLienMultiple = {"id"};
            String[] urlLienAffiche = {"id"};
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id", "date", "fournisseur", "numero facture", "designation", "date emission", "date echeance", "montant TTC", "Montant payé", "reste à payer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            if(pr.getTableau().getHtml() != null){
                out.println(pr.getTableau().getHtml());   
            }else{%>
            <center><h3>Aucune facture</h3></center>
            <%}
            
        %>
        </form>
    </section>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>