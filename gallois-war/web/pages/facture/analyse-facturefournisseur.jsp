<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@ page import="affichage.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="user.*" %>


<%
    try {

        EtatFactureMontantDaty lv = new EtatFactureMontantDaty();
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            lv.setNomTable(request.getParameter("etat"));
        }
        

        String listeCrt[] = {"id", "nomfournisseur", "numFact", "dateEmission"};
        String listeInt[] = {"dateEmission"};

        String[] pourcentage = {};
        String somDefaut[] = {"montant", "montanttva", "montantttc","montantpaye","reste"};
        String colDefaut[] = {"id", "daty", "nomfournisseur", "numFact", "designation", "dateEmission", "datyEcheance"};

        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 0);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("nomfournisseur").setLibelle("Fournisseur");
        pr.getFormu().getChamp("numFact").setLibelle("Numero facture");
        pr.getFormu().getChamp("dateEmission1").setLibelle("date Emission min");
        pr.getFormu().getChamp("dateEmission2").setLibelle("date Emission max");
        
        
        
        pr.setApres("facture/analyse-facturefournisseur.jsp");
        pr.creerObjetPagePourc();
        
        EtatFactureMontantDaty base = (EtatFactureMontantDaty) pr.getBase();

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/analyse-facturefournisseur.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
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

        <%  String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
             out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            if(request.getParameter("colGroupe1")!=null){
                String tablink[] = {pr.getLien() + "?but=facture/analyse-facturefournisseur.jsp"};
                String collink[] = {"montantttc"};
                pr.getTableau().setLien(tablink);
                pr.getTableau().setColonneLien(collink);
            }
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>