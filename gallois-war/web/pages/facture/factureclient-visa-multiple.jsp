<%-- 
    Document   : en-attente-de-visa
    Created on : 20 févr. 2016, 11:04:59
    Author     : ITU
--%>
<%@page import="facture.FactureClient"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        FactureClient facture = new FactureClient();
        facture.setNomTable("facture_client_union");
        String listeCrt[] = {"id", "daty", "tierslib", "designation", "date_echeance"};
        String listeInt[] = {"daty", "date_echeance"};
        String libEntete[] = {"id", "daty", "tierslib", "designation", "tva", "date_echeance", "montant", "montanttva", "montantttc", "montantAvoir", "montantpaye", "montantreste"};
        PageRecherche pr = new PageRecherche(facture, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        /*pr.getFormu().getChamp("montant").setLibelle("montant HT");
    pr.getFormu().getChamp("montanttva").setLibelle("montant TVA");
    pr.getFormu().getChamp("montantttc").setLibelle("montant TTC");*/
        pr.getFormu().getChamp("tierslib").setLibelle("Tiers");

        pr.setApres("facture/factureclient-visa-multiple.jsp");
        String[] colSomme = {"montant", "montanttva", "montantttc", "montantAvoir", "montantpaye", "montantreste"};
        pr.creerObjetPage(libEntete, colSomme);%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des facture client &agrave; viser</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/factureclient-visa-multiple.jsp" method="post" name="incident" id="incident">
            
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("facture_client_union") == 0) {%>    
                        <option value="facture_client_union" selected>Tous</option>
                        <% } else { %>
                        <option value="facture_client_union" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("factureclientMSumC") == 0) {%>
                        <option value="factureclientMSumC" selected>Créée(s)</option>
                        <% } else { %>
                        <option value="factureclientMSumC">Créée(s)</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("factureclientMSumV") == 0) {%>
                        <option value="factureclientMSumV" selected>Visée(s)</option>
                        <% } else { %>
                        <option value="factureclientMSumV">Visée(s)</option>
                        <% } %>

                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>

        <%  String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br/>
        <form action="<%=pr.getLien()%>?but=visa-multiple.jsp" method="post" name="fcform" id="fcform">
            
            <input type="hidden" name="bute" value="facture/factureclient-visa-multiple.jsp"/>
            <input type="hidden" name="classe" value="facture.FactureClient"/>
            <input type="hidden" name="acte" value="viser"/>

            <%

                String libEnteteAffiche[] = {"id", "daty", "tiers", "designation", "tva", "date echeance", "montant HT", "montant TVA", "montant TTC", "montant Avoir", "montant payé", "reste à payer"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameActe("viser");
                pr.getTableau().setNameBoutton("Viser");

                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
            <input type="button" class="btn btn-info" onclick="payer()" style="margin-right:30px" value="Payer"/>
            <!--<a href="<%=pr.getLien()%>?but=transitionPaiement.jsp" class="btn btn-info">Payer</a>-->
        </form>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<script>
    function payer() {
        document.getElementById("fcform").action = "<%=pr.getLien()%>?but=transitionPaiement.jsp";
        document.getElementById("fcform").submit();
    }
</script>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>