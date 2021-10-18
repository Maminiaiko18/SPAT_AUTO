<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="facture.FactureFournisseur"%>
<%@page import="java.sql.Date"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="facture.FactureClient"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureFournisseur ff = new FactureFournisseur();
        String[] etatVal = {"FACTUREFOURNVALIDE_TOUS", "FACTUREFOURNVALIDE_C", "FACTUREFOURNVALIDE_V", "FACTUREFOURNVALIDE_EP", "FACTUREFOURNVALIDE_P"};
        String[] etatAff = {"Tous", "Créée(s)", "Visée(s)", "En attente de paiement", "Payéé(s)"};
        ff.setNomTable(etatVal[0]);
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            ff.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"id","daty","tierslib","designation","date_echeance","escale","categorielib", "code"};
        String listeInt[] = {"daty","date_echeance"};
        String libEntete[] = {"id","daty","tierslib", "code", "escale","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
//        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/facture-fournisseur-liste-vaovao.jsp");
        
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
        <h1>Liste facture fournisseur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/facture-fournisseur-liste-vaovao.jsp" method="post" name="incident" id="incident">
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
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = etatVal[i].equalsIgnoreCase(ff.getNomTable()) ? "selected" : "";
                        %>
                        <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <form action="<%=pr.getLien()%>?but=apresTarif.jsp" method="post" name="form_arif" id="form_arif">
            <input type="hidden" name="bute" id="bute" value="ded/ordonnerpayement-saisie.jsp"/>
            <input type="hidden" name="classe" value="facturefournisseur.FactureFournisseur"/>
            <input type="hidden" name="acte" id="acte" value="editerOP"/>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp", pr.getLien() + "?but=capitainerie/quais/quais-prevision-fiche.jsp"};
            String colonneLien[] = {"id", "escale"};
            String[] urlLienMultiple = {"id", "idprevision"};
            String[] urlLienAffiche = {"id", "id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id","daty","Client","Code", "Escale","Note explicative","Catégorie", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste à payer"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            pr.getTableau().setNameActe("editerOP");
            pr.getTableau().setNameBoutton("Editer OP");
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        <a name="reg" id="btnRegularisation" class="pull-right"><input type="button" class="btn btn-info" value="Régulariser BP" /></a>
        <input type="button" class="btn btn-info" onclick="editerBED()" style="margin-right:30px" value="Editer BED"/>
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
    
    function editerBED() {
        document.getElementById("acte").value =  "editerBED";
        document.getElementById("bute").value =  "ded/bordereauxFF-saisie.jsp";
        document.getElementById("form_arif").action = '<%=pr.getLien()%>?but=apresFacture.jsp';
        document.getElementById("form_arif").submit();
    }
    
</script>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
