<%-- 
    Document   : factureclient-ancienne-liste
    Created on : 24 mars 2022, 08:54:35
    Author     : User
--%>

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureClient ff = new FactureClient();
        ff.setNomTable("analyseglobaleantsika");
        String listeCrt[] = {"id", "daty", "tiers", "designation", "type", "tva", "date_echeance", "etat"};
        String listeInt[] = {"daty", "date_echeance"};
        String libEntete[] = {"id", "daty", "tiers", "designation", "type", "tva", "date_echeance", "montant", "montanttva", "montantTTC", "montantAvoir", "montantpaye", "montantreste"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/factureclient-ancienne-liste.jsp");

        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("tiers").setLibelle("Client");
       

       
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        pr.getFormu().getChamp("designation").setLibelle("Note explicative");

        String[] colSomme = {"montant", "montantTVA", "montantTTCvrai", "montantTTC", "montantAvoir", "montantpaye", "montantreste"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture client ancienne</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/factureclient-ancienne-liste.jsp" method="post" name="incident" id="incident">
            <%
                String libelleAffiche[] = {};
                pr.getTableau().setLibelleAffiche(libelleAffiche);
                out.println(pr.getFormu().getHtmlEnsemble());
            %>

        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=apresFactureAncienne.jsp" method="post" name="incidents" id="incidents">
            <%
                String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-ancienne-liste.jsp", pr.getLien() + "?but=capitainerie/quais/quais-prevision-fiche.jsp"};
                String colonneLien[] = {"id"};
                String[] urlLienMultiple = {"id"};
                String[] urlLienAffiche = {"id", "id"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setColonneLien(colonneLien);

                String libEnteteAffiche[] = {"id", "daty", "Client", "Note explicative", "Type", "tva", "date echeance", "montant HT", "montant TVA", "Montant TTC", "montant Avoir", "Montant payé", "Reste à payer"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setUrlLienAffiche(urlLienAffiche);
                pr.getTableau().setUrlLien(urlLienMultiple);
                pr.getTableau().setNameBoutton("Encaisser");

                pr.getTableau().setNameActe("encaisserMultiple");

                out.println(pr.getTableau().getHtmlWithCheckbox());

            %>
            <input type="hidden" id="acte" name="acte" value="encaisserMultiple"/>
        </form>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<script>
    function integrer(){
        document.getElementById("acte").value = "integrer";
    }
    
    const btnf = document.getElementsByClassName("box-footer");
    let btn = document.createElement("button");
    btn.innerHTML = "integrer";
    btn.type = "submit";
    btn.onclick = integrer();
    btn.className = "btn btn-success pull-left"
    btnf[1].appendChild(btn);
    console.log("");
</script>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
