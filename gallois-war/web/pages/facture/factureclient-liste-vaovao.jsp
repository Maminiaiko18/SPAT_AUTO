<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureClient ff = new FactureClient();
        ff.setNomTable("factureclientMSum_lib");
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            ff.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"id","daty","tierslib","designation","date_echeance"};
        String listeInt[] = {"daty","date_echeance"};
        String libEntete[] = {"id","daty","tierslib","designation","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
//        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/factureclient-liste-vaovao.jsp");
        
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);
        
        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        if(request.getParameter("date_echeance1") == null && request.getParameter("date_echeance2") == null){
            pr.getFormu().getChamp("date_echeance1").setDefaut(debutDate);
            pr.getFormu().getChamp("date_echeance2").setDefaut(dateFin);
            
        }
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        
        String[] colSomme = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/factureclient-liste-vaovao.jsp" method="post" name="incident" id="incident">
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
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("factureclientMSum_lib") == 0) {%>    
                        <option value="factureclientMSum_lib" selected>Tous</option>
                        <% } else { %>
                        <option value="factureclientMSum_lib" >Tous</option>
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
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp"};

            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id","daty","Client","designation", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste à payer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
