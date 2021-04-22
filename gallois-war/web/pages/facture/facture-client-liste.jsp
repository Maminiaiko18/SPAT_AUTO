<%-- 
    Document   : facture-client-liste
    Created on : 2 févr. 2021, 10:48:45
    Author     : ACER
--%>


<%@page import="factureclient.PaiementFactureRemise"%>
<%@page import="utilitaire.Utilitaire"%>


<%@page import="affichage.PageRecherche"%>

<%
    try {
        PaiementFactureRemise dr = new PaiementFactureRemise();
        if (request.getParameter("etat") == null || request.getParameter("etat").compareToIgnoreCase("") == 0) {
            dr.setNomTable("PAIEMENT_FACTURECLIENT_REMISE");
        } else {
            System.out.println(request.getParameter("etat"));
            dr.setNomTable(request.getParameter("etat"));

        }
        String lang = String.valueOf(session.getAttribute("lang"));
        String[] mots = {"Liste des factures clients", "Id", "Date min", "Date max", "Client", "Designation", "Compte CR","Reference facture", "Etat"};//9
        String[] ret = Utilitaire.transformerLangue(mots, lang);
        String listeCrt[] = {"id","daty", "tiers", "designation", "typee", "remarque"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id","daty", "tiers", "designation", "remarque","avoir", "montanttotaleremise", "montant", "montantpayer", "resteapayer"};
        PageRecherche pr = new PageRecherche(dr, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("id").setLibelle(ret[1]);

        pr.getFormu().getChamp("daty1").setLibelle(ret[2]);
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setLibelle(ret[3]);
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("tiers").setLibelle(ret[4]);
        pr.getFormu().getChamp("designation").setLibelle(ret[5]);
        pr.getFormu().getChamp("remarque").setLibelle(ret[7]);

        pr.getFormu().getChamp("typee").setLibelle(ret[6]);

        pr.setApres("facture/facture-client-liste.jsp&etat="+request.getParameter("etat")+"");
        String[] colSomme = {"montant","montanttva", "montanttotal", "montantpayer","resteapayer"};
        pr.setOrdre(" order by id desc");
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.personnel.submit();
    }
</script>
<style>
    th {
        color: white !important;
    }
    th a {
        color: white !important;
    }
</style>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%=ret[0]%></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/facture-client-liste.jsp" method="post" name="personnel" id="personnel">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label><%=ret[8]%> : </label>
                    <select name="etat" class="champ form-control" id="etat" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="PAIEMENT_FACTURECLIENT_REMISE" <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("PAIEMENT_FACTURECLIENT_REMISE") == 0  ) {
                                out.print(" selected");
                            }%>>Tous </option>
                        <option value="PAIEMENTFACTURECLIENTREMISE_NV" <%if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("PAIEMENTFACTURECLIENTREMISE_NV") == 0) {
                                out.print("selected");
                            }%>>Crée</option>
                        <option value="PAIEMENTFACTURECLIENTREMISE_V" <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("PAIEMENTFACTURECLIENTREMISE_V") == 0) {
                                out.print(" selected");
                            }%>>Visé </option>
                        <option value="PAIEMENTFACTURECLIENTREMISE_P" <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("PAIEMENTFACTURECLIENTREMISE_P") == 0) {
                                out.print(" selected");
                            }%>>Payé </option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=facture/facture-client-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="incident" id="incident">
            <input type="hidden" name="bute" value="facture/facture-client-liste.jsp"/>
            <input type="hidden" name="classe" value="factureclient.FactureClient"/>
            <input type="hidden" name="acte" value="fusionnerFactureClient"/>
        <%
            String[] motsEntete = {"Id", "Date facture", "Client", "Designation","Reference facture","Avoir","Montant Remise", "TOTAL","Payer","Reste à Payer"};
            pr.getTableau().setLibelleAffiche(motsEntete);
            //out.println(pr.getTableau().getHtml());
            pr.getTableau().setNameActe("fusionnerFactureClient");
            pr.getTableau().setNameBoutton("Fusionner");
           out.println(pr.getTableau().getHtmlWithCheckbox());
//            out.println(pr.getBasPage());
        %>
        </form>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }
%>
