<%-- 
    Document   : rubrique-facture-fournisseur-liste
    Created on : 9 févr. 2021, 10:34:34
    Author     : ACER
--%>

<%@page import="rubrique.RubriqueFactureFournisseur"%>
<%@page import="lignecredit.LigneCredit"%>

<%@page import="affichage.PageRecherche"%>

<% try{ 
    RubriqueFactureFournisseur rff = new RubriqueFactureFournisseur();
    rff.setNomTable("rubriqueFactureFournisseurLib");
    String listeCrt[] = {"id", "designation", "compte"};
    String listeInt[] = {};
    String libEntete[] = {"id", "designation", "montant", "compte", "duree"};
    PageRecherche pr = new PageRecherche(rff,request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

    pr.getFormu().getChamp("designation").setLibelle("Désignation");
            
    pr.setApres("facture/rubrique-facture-fournisseur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listestatistiqueactivite.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste rubrique facture fournisseur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/rubrique-facture-fournisseur-liste.jsp" method="post" name="listestatistiqueactivite" id="listestatistiqueactivite">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/rubrique-facture-fournisseur-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "désignation", "montant", "compte", "durée"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>