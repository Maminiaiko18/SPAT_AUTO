<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
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

        String listeCrt[] = {"id","daty","tierslib","designation","exercice","date_echeance","nature", "numeroop", "code", "projetlib","montantTTC","code_etablissementlib"};
        String listeInt[] = {"daty","date_echeance","exercice"};

        String libEntete[] = {"id","daty","tierslib", "numeroop", "code", "projetlib", "code_etablissementlib", "naturelib","designation","exercice","date_echeance", "montantTTCvrai", "montantAvoir", "montantTTC", "montantpaye","montantreste","numOP"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/facture-fournisseur-liste-vaovao.jsp");
        
        affichage.Champ[]liste = new affichage.Champ[1];
        TypeObjet nature = new TypeObjet();
        nature.setNomTable("nature");
        liste[0] = new Liste("nature", nature, "val", "id");
        pr.setNpp(100);
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("exercice1").setLibelle("debut exercice");
        pr.getFormu().getChamp("exercice2").setLibelle("fin exercice");
        pr.getFormu().getChamp("tierslib").setLibelle("Fournisseur");
        pr.getFormu().getChamp("nature").setLibelle("Nature");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("numeroop").setLibelle("N° Facture");
        pr.getFormu().getChamp("code").setLibelle("Numero compta");     
        pr.getFormu().getChamp("montantTTC").setLibelle("Montant TTC");
        pr.getFormu().getChamp("code_etablissementlib").setLibelle("Code direction");
        
        pr.getFormu().changerEnChamp(liste);
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);
        firstDate.setMonth(0);
        Date lastDate = Utilitaire.dateDuJourSql();
        lastDate.setDate(31);
        lastDate.setMonth(11);
        
//        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String debutDate = "01/01/"+Utilitaire.getAnnee(Utilitaire.dateDuJourSql());
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);
            
        }
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        pr.getFormu().getChamp("designation").setLibelle("Note explicative");
        
        
        String[] colSomme = {"montantTTCvrai", "montantAvoir", "montantTTC", "montantpaye","montantreste"};
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
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-fournisseur-fiche-vaovao.jsp"};
            String colonneLien[] = {"id"};
            String[] urlLienMultiple = {"id"};
            String[] urlLienAffiche = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);


            String libEnteteAffiche[] = {"id","Date","Fournisseur", "N° Facture","Numero compta", "Projet", "Code direction", "Nature","Note explicative","exercice", "date echeance", "montant TTC", "montant Avoir", "Net à payer", "Montant payé","Reste à payer","Numero OP"};

            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            pr.getTableau().setNameActe("editerOP");
            pr.getTableau().setNameBoutton("Editer OP");
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        <div style="display: flex; justify-content: flex-end; align-items: center;">
        
        <input type="button" class="btn btn-info" onclick="editerBED()" style="margin:10px" value="Editer BED"/>
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
