<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="facture.EtatProvision"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<% try {

        EtatProvision tiers = new EtatProvision();
        tiers.setNomTable("ETATBPVRAI_REEL");

        String listeCrt[] = {"id", "tierslib", "daty","code_etablissementlib"};
        String listeInt[] = {"daty"};
        String[] colGr = {"id", "daty", "tierslib","code_etablissementlib"};
        String[] sommGr =  {"montantprovision", "montantfacture", "montantpaye", "montantreste"};
        
        PageRechercheGroupe pr = new PageRechercheGroupe(tiers, request, listeCrt, listeInt, 3, colGr, sommGr, colGr.length+1, sommGr.length+1);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("treso/etat-bon-provisoire.jsp");

        pr.getFormu().getChamp("id").setLibelle("Id");
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");
        pr.getFormu().getChamp("daty1").setLibelle("Date min.");
        pr.getFormu().getChamp("daty2").setLibelle("Date max.");
        
        pr.creerObjetPage();
%> 

<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">

    <div class="row">
        <section class="content-header">
            <h1>Etat bon provisoire</h1>
        </section>

    </div>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="incident" id="incident">
                    <%
                        out.println(pr.getFormu().getHtmlEnsemble());
                    %>

                </form>
                <% 
                    String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
                    String colonneLien[] = {"id"};
                    String[] urlLienMultiple = {"id"};
                    String[] urlLienAffiche = {"id"};
                    pr.getTableau().setLien(lienTableau);
                    pr.getTableau().setColonneLien(colonneLien);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <br>
                <%
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