<%-- 
    Document   : bon-provisoire-liste
    Created on : 30 nov. 2019, 11:06:26
    Author     : john
--%>

<%@page import="facture.FactureFournisseur"%>
<%@page import="mg.spat.BonProvisoireComplet"%>
<%@page import="mg.spat.BonProvisoireRetourRegule"%>
<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>

<% try{ 
    FactureFournisseur bonProvisoire = new FactureFournisseur();
    String nomTable = "FACTFOURN_MSUM_LIB";
    if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
        nomTable = request.getParameter("table");
    }
    bonProvisoire.setNomTable(nomTable);
    
    String listeCrt[] = {"id", "tiers", "code", "designation", "daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "tiers", "code", "designation", "montant", "remarque", "daty"};
    PageRecherche pr = new PageRecherche(bonProvisoire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("tiers").setLibelle("Bénéficiaire");
    pr.getFormu().getChamp("code").setLibelle("Numéro pièce");
    pr.getFormu().getChamp("designation").setLibelle("Désignation");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    
    pr.setApres("treso/bon-provisoire-liste-nouveau.jsp");
    //pr.setAWhere(" and etat != "+ConstanteEtat.getEtatRegulariser());
    String[] colSomme = {"montant"};
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listebonprovisoire.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste bon provisoire</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=treso/bon-provisoire-liste-nouveau.jsp" method="post" name="listebonprovisoire" id="listebonprovisoire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
                    <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("bon_provisoire_libcomplet") == 0) {%>    
                        <option value="FACTFOURN_MSUM_LIB" selected>Tous</option>
                        <% } else { %>
                        <option value="FACTFOURN_MSUM_LIB" >Tous</option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BON_PROVISOIRE_LIB_cree") == 0) {%>    
                        <option value="FACTFOURN_MSUM_LIBC" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="FACTFOURN_MSUM_LIBC" >Cr&eacute;&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BON_PROVISOIRE_LIB_valide") == 0) {%>    
                        <option value="FACTFOURN_MSUM_LIBV" selected>Valid&eacute;</option>
                        <% } else { %>
                        <option value="FACTFOURN_MSUM_LIBV" >Valid&eacute;</option>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso"
                    + "/bon-provisoire-fiche-nouveau.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID", "Bénéficiaire", "Numéro pièce", "Désignation", "Montant", "Remarque", "Date"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>


