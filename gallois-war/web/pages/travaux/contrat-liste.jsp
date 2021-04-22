<%-- 
    Document   : contrat-liste.jsp
    Created on : 17 déc. 2020, 17:14:55
    Author     : Lenovo
--%>

<%@page import="mg.spat.compta.ContratChantierLibComplet"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    ContratChantierLibComplet info = new ContratChantierLibComplet();
    info.setNomTable("contrat_chantier_CplSum");
    
    String listeCrt[] = {"id","chantierlib", "designation", "prestatairelib"};
    String listeInt[] = {};
    String libEntete[] = {"id","chantierlib", "designation","montant", "prestatairelib", "tva", "projetlib", "code_etablib", "nocontrat", "montant_paye", "resteapaye"};
    
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/contrat-liste.jsp");    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste contrat</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/contrat-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=travaux/contrat-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "chantier", "designation","montant", "prestataire", "tva", "projet", "Code Etablissement", "no contrat", "montant payé", "reste a payé"};
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

