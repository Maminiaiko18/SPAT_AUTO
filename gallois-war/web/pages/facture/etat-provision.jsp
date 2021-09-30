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
        tiers.setNomTable("etatprovisionvrai");

        String listeCrt[] = {"id", "tierslib", "daty"};
        String listeInt[] = {"daty"};
        String[] colGr = {"id", "daty", "tierslib"};
        String[] sommGr =  {"montantprovision", "montantfacture", "montantpaye", "montantreste"};
        
        PageRechercheGroupe pr = new PageRechercheGroupe(tiers, request, listeCrt, listeInt, 3, colGr, sommGr, colGr.length+1, sommGr.length+1);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("facture/etat-provision.jsp");

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
                <% out.println(pr.getTableauRecap().getHtml());%>
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