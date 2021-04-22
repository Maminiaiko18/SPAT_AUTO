<%-- 
    Document   : contrat-liste
    Created on : 30 nov. 2019, 17:57:23
    Author     : john
--%>

<%@page import="mg.spat.compta.Contrat"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Contrat info = new Contrat();
    info.setNomTable("contratlib");
    String listeCrt[] = {"id","idTiers","objet","devise","unite","date_signature","debut_contrat","fin_contrat" };
    String listeInt[] = {"date_signature","debut_contrat","fin_contrat"};
    String libEntete[] = {"id","idTiers","objet","devise","unite","date_signature","debut_contrat","fin_contrat","duree","droit_entree","redevance_fixe","redevance_variable","droit_port","redevance_domaniale","redevance_locative","pipeline","typedroitport","typeduree"};
    PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("compta/contrat/contrat-liste.jsp");    
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
        <form action="<%=pr.getLien()%>?but=compta/contrat/contrat-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=compta/contrat"
                    + "/contrat-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Tiers","objet","devise","unite","date de signature","debut du contrat","fin du contrat","duree","droit d'entree","redevance fixe","redevance variable","droit port","redevance domaniale","redevance locative","pipeline","type droit port","type duree"};
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
