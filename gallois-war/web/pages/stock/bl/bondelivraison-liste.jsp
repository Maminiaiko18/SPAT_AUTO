<%-- 
    Document   : bondelivraison-liste
    Created on : 25 nov. 2020, 17:50:42
    Author     : ASUS
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<% 
    
    BonDeLivraison lv = new BonDeLivraison();
    lv.setNomTable("as_bondelivraison_MttCpl");
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        lv.setNomTable(request.getParameter("etat"));
    }
    String libEntete[] = {"id", "daty", "id_bc", "numbc","montant","montanttva","montantttc","montantfactttc","montantpaye","rap","reste_a_facturer"};
    String listeCrt[] = {"id", "daty", "id_bc"};
    String listeInt[] = {"daty"};

    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.getFormu().getChamp("id_bc").setLibelle("bon de livraison");
    pr.setApres("stock/bl/bondelivraison-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste bon de livraison</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=stock/bl/bondelivraison-liste.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
			<div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("as_bondelivraison_MttCpl") == 0) {%>    
                        <option value="as_bondelivraison_MttCpl" selected>Tous</option>
                        <% } else { %>
                        <option value="as_bondelivraison_MttCpl" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("as_bondelivraison_MttCplVISE") == 0) {%>
                        <option value="as_bondelivraison_MttCplVISE" selected>Validé</option>
                        <% } else { %>
                        <option value="as_bondelivraison_MttCplVISE">Validé</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("as_bondelivraison_MttCplCREE") == 0) {%>
                        <option value="as_bondelivraison_MttCplCREE" selected>En cours</option>
                        <% } else { %>
                        <option value="as_bondelivraison_MttCplCREE">En cours</option>
                        <% } %>

                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=stock/bl/bondelivraison-fiche.jsp", pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
            String colonneLien[] = {"id","id_bc"};
            String[] urlLienMultiple = {"id","id_bc"};
            String[] urlLienAffiche = {"id","id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);           
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%                                
            String libEnteteAffiche[] = {"Id", "Date", "BC","Numero BC","Montant", "Montant TVA", "Montant TTC", "Montant facturé", "Montant payé", "Reste à payer", "Reste à facturer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>  
    </section>
</div>