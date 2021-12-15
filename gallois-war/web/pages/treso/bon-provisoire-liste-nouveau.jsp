<%-- 
    Document   : bon-provisoire-liste
    Created on : 30 nov. 2019, 11:06:26
    Author     : john
--%>

<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="mg.spat.BonProvisoireComplet"%>
<%@page import="mg.spat.BonProvisoireRetourRegule"%>
<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.ConstanteEtat"%>

<% try{ 
    FactureFournisseur bonProvisoire = new FactureFournisseur();
    String nomTable = "BPvalide";
    if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
        nomTable = request.getParameter("table");
    }
    bonProvisoire.setNomTable(nomTable);
    
    String listeCrt[] = {"id","daty","tierslib","designation","date_echeance","escale","categorielib", "code"};
    String listeInt[] = {"daty","date_echeance"};
    String libEntete[] = {"id","daty","tierslib", "code", "escale","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    PageRecherche pr = new PageRecherche(bonProvisoire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("categorielib").setLibelle("Catégorie");
        
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);
        
        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);
            
        }
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        pr.getFormu().getChamp("designation").setLibelle("Note explicative");        
    
    pr.setApres("treso/bon-provisoire-liste-nouveau.jsp");
    //pr.setAWhere(" and etat != "+ConstanteEtat.getEtatRegulariser());
    String[] colSomme = {"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
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
                        <option value="BPvalide" selected>Tous</option>
                        <% } else { %>
                        <option value="BPvalide" >Tous</option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BON_PROVISOIRE_LIB_cree") == 0) {%>    
                        <option value="BPvalide_c" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="BPvalide_c" >Cr&eacute;&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BON_PROVISOIRE_LIB_valide") == 0) {%>    
                        <option value="BPvalide_v" selected>Valid&eacute;</option>
                        <% } else { %>
                        <option value="BPvalide_v" >Valid&eacute;</option>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp", pr.getLien() + "?but=capitainerie/quais/quais-prevision-fiche.jsp"};
            String colonneLien[] = {"id", "escale"};
            String[] urlLienMultiple = {"id", "idprevision"};
            String[] urlLienAffiche = {"id", "id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="form_arif" id="form_arif">
            <input type="hidden" name="bute" id="bute" value="ded/ordonnerpayement-saisie.jsp"/>
            <input type="hidden" name="classe" value="facturefournisseur.FactureFournisseur"/>
            <input type="hidden" name="acte" id="acte" value="editerOP"/>
        <%
            String libEnteteAffiche[] = {"id","daty","Client","Code", "Escale","Note explicative","Catégorie", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste à payer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);            
            pr.getTableau().setNameActe("editerOP");
            pr.getTableau().setNameBoutton("Editer OP");
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        <div style="display: flex; justify-content: flex-end; align-items: center;">
            <input type="button" class="btn btn-info" onclick="decaisser()" style="margin-right:30px" value="Décaisser"/>
        </div>
        </form>
         <% out.println(pr.getBasPage());%>
    </section>
</div>
    <script>
        function decaisser(){
        $('#form_arif').attr('action', '<%= pr.getLien() %>?but=apresFactureF.jsp');
        $('#acte').val('decaisserMultiple');
        document.getElementById("form_arif").submit();
    }
    </script>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>


