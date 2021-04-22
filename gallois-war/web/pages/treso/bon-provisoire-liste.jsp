<%-- 
    Document   : bon-provisoire-liste
    Created on : 30 nov. 2019, 11:06:26
    Author     : john
--%>

<%@page import="mg.spat.BonProvisoireComplet"%>
<%@page import="mg.spat.BonProvisoireRetourRegule"%>
<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>

<% try{ 
    BonProvisoireComplet bonProvisoire = new BonProvisoireComplet();
    String nomTable = "";
    if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
        nomTable = request.getParameter("table");
    }
    bonProvisoire.setNomTable(nomTable);
    
    String listeCrt[] = {"id", "folio", "valcaisse", "numpiece", "libelle","beneficiairelib", "remarque","datesaisie", "dateeffet"};
    String listeInt[] = {"datesaisie", "dateeffet"};
    String libEntete[] = {"id", "folio", "valcaisse", "numpiece", "libelle","beneficiairelib","remarque","datesaisie", "dateeffet","debit","reste"};
    PageRecherche pr = new PageRecherche(bonProvisoire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("treso/bon-provisoire-liste.jsp");
    //pr.setAWhere(" and etat != "+ConstanteEtat.getEtatRegulariser());
    String[] colSomme = null;
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
        <form action="<%=pr.getLien()%>?but=treso/bon-provisoire-liste.jsp" method="post" name="listebonprovisoire" id="listebonprovisoire">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
                    <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("bon_provisoire_libcomplet") == 0) {%>    
                        <option value="bon_provisoire_libcomplet" selected>Tous</option>
                        <% } else { %>
                        <option value="bon_provisoire_libcomplet" >Tous</option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BON_PROVISOIRE_LIB_cree") == 0) {%>    
                        <option value="BON_PROVISOIRE_LIB_cree" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="BON_PROVISOIRE_LIB_cree" >Cr&eacute;&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BON_PROVISOIRE_LIB_valide") == 0) {%>    
                        <option value="BON_PROVISOIRE_LIB_valide" selected>Valid&eacute;</option>
                        <% } else { %>
                        <option value="BON_PROVISOIRE_LIB_valide" >Valid&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BON_PROVISOIRE_LIB_regularise") == 0) {%>
                        <option value="BON_PROVISOIRE_LIB_regularise" selected>Regularis&eacute;</option>
                        <% }
                            else{ %>
                        <option value="BON_PROVISOIRE_LIB_regularise" >Regularis&eacute;</option>
                        <% }%>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=treso"
                    + "/bon-provisoire-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Folio", "Caisse de retrait", "Num piece", "Libelle","Beneficiaire", "Remarque","Date saisie", "Date effet","Montant","Reste"};
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


