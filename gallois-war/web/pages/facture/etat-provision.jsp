<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="facture.EtatProvision"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<% try {

        EtatProvision tiers = new EtatProvision();

        String listeCrt[] = {"id"};
        String listeInt[] = {};
        String libEntete[] = {"id", "montantfacture", "montantprovision", "ecart"};

        PageRecherche pr = new PageRecherche(tiers, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/etat-provision.jsp");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%> 

<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">

    <div class="row">
        <section class="content-header">
            <h1>Etat de provision</h1>
        </section>

    </div>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form action="<%=pr.getLien()%>?but=facture/etat-provision.jsp" method="post" name="incident" id="incident">
                    <%
                        out.println(pr.getFormu().getHtmlEnsemble());
                    %>

                </form>
                <%
                    String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
                    String colonneLien[] = {"id"};
                    pr.getTableau().setLien(lienTableau);
                    pr.getTableau().setColonneLien(colonneLien);
                    out.println(pr.getTableauRecap().getHtml());%>
                <br>
                <%
                    String libEnteteAffiche[] = {"id", "Montant facture", "Montant provision", "ecart"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                    out.println(pr.getTableau().getHtml());
                    out.println(pr.getBasPage());
                %>
            </div>
        </div>
    </section>

</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>