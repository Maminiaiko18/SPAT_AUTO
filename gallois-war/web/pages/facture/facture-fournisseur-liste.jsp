<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        EtatFactureMontantDaty ff = new EtatFactureMontantDaty();
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            ff.setNomTable(request.getParameter("etat"));
        }
        
        String listeCrt[] = {"id", "daty", "nomFournisseur", "numFact", "dateEmission", "datyEcheance"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "daty", "nomfournisseur", "numfact","CODE_ETABLISSEMENT","projet","NUMID", "designation", "dateemission", "datyecheance", "montantttc", "montantpaye", "reste"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/facture-fournisseur-liste.jsp");
        String[] colSomme = {"montantttc", "montantpaye", "reste"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
     function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture fournisseur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/facture-fournisseur-liste.jsp" method="post" name="incident" id="incident">
            <%
                String libelleAffiche[] = {};
                pr.getTableau().setLibelleAffiche(libelleAffiche);
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
             <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("EtatFactureMontantDaty") == 0) {%>    
                        <option value="EtatFactureMontantDaty" selected>Tous</option>
                        <% } else { %>
                        <option value="EtatFactureMontantDaty" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("EtatFactureMontantDatyCREE") == 0) {%>
                        <option value="EtatFactureMontantDatyCREE" selected>crée</option>
                        <% } else { %>
                        <option value="EtatFactureMontantDatyCREE">crée</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("EtatFactureMontantDatyVISEII") == 0) {%>
                        <option value="EtatFactureMontantDatyVISEII" selected>visé</option>
                        <% } else { %>
                        <option value="EtatFactureMontantDatyVISEII">visé</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("EtatFactureAttentePaiement") == 0) {%>
                        <option value="EtatFactureAttentePaiement" selected>En attente de paiement</option>
                        <% } else { %>
                        <option value="EtatFactureAttentePaiement">En attente de paiement</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("EtatFactureMontantDatyPAYE") == 0) {%>
                        <option value="EtatFactureMontantDatyPAYE" selected>payé</option>
                        <% } else { %>
                        <option value="EtatFactureMontantDatyPAYE">payé</option>
                        <% } %>

                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="form_arif" id="form_arif">
            <input type="hidden" name="bute" value="ded/ordonnerpayement-saisie.jsp"/>
            <input type="hidden" name="classe" value="facturefournisseur.FactureFournisseur"/>
            <input type="hidden" name="acte" id="acte" value="editerOP"/>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche.jsp", pr.getLien() + "?but=travaux/details-chantier-fiche.jsp"};

            String colonneLien[] = {"id", "remarque"};
            String[] urlLienMultiple = {"id", "idchantier"};
            String[] urlLienAffiche = {"id", "id"};
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id", "date", "fournisseur", "numero facture","Code direction","projet","Numero Compta", "designation", "date emission", "date echeance", "montant TTC", "Montant payé", "reste à payer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
//            out.println(pr.getTableau().getHtml());
            pr.getTableau().setNameActe("editerOP");
            pr.getTableau().setNameBoutton("Editer OP");
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        
        <a name="reg" id="btnRegularisation" class="pull-right"><input type="button" class="btn btn-info" value="Régulariser BP" /></a>
        <a name="bed" id="btnBED" class="pull-right"><input type="button" class="btn btn-info" value="Editer BED" /></a>    

        </form>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<script>
    document.getElementById("btnRegularisation").onclick = function(){
        console.log(document.getElementById("acte"));
        console.log(document.getElementById("form_arif"));
        document.getElementById("acte").value =  "regularisation";
        document.getElementById("form_arif").submit();
    }
    function regularisation (){
        document.getElementById("acte").value =  "regularisation";
        document.getElementById("form_arif").submit();
    }
    document.getElementById("btnBED").onclick = function(){
        document.getElementById("acte").value =  "bed";
        document.getElementById("form_arif").submit();
    }
    
</script>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>