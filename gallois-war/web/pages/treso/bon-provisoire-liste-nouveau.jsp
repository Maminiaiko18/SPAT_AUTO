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
<%@page import="user.*"%>
<%@page import="utilitaire.*"%>
<%@page import="utilisateur.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% try{ 
    UserEJB u = null;
        String userRole = "";
        u = (UserEJB) session.getValue("u");
        userRole = u.getUser().getIdrole();
        Prioritaire prioritaire = new Prioritaire();
        String aWhere = prioritaire.makeListConfidentiality(u,"code_etablissementlib");
    FactureFournisseur bonProvisoire = new FactureFournisseur();
    String nomTable = "BPVALIDE_LIBTOUS";
    if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
        nomTable = request.getParameter("table");
    }
    System.out.println("table name"+nomTable);
    bonProvisoire.setNomTable(nomTable);
    
    String listeCrt[] = {"id","daty","dateRegul","tierslib","num","designation","date_echeance","nature","valcaisserefpmt", "numeroop", "code", "projetlib","montantTTC","code_etablissementlib","numfsb","remarque","numOP","numBed","numchequerefpmt","modepaiement"};
    String listeInt[] = {"daty","date_echeance","dateRegul"};

    String libEntete[] = { "id", "code", "daty","dateRegul","num", "tierslib", "montant", "tva", "montantTVA", "montantTTCvrai", "numeroop", "datefacture", "designation", "numBed","numBc", "projetlib", "code_etablissementlib","numfsb",  "naturelib", "modepaiement", "numOP","remarque", "exercice", "date_echeance", "montantAvoir", "montantTTC", "montantpaye", "montantreste", "etatLib", "valcaisserefpmt", "numpiecerefpmt", "dateeffetrefpmt", "numchequerefpmt", "libellerefpmt", "debitrefpmt","remarque"};
    String libEnteteAffiche[] = { "id", "Reference/Code", "date","date Regul","num BP", "Fournisseur", "Montant HT", "TVA", "Montant TVA", "montant TTC", "N° Facture", "Date Facture", "Note explicative", "BED","Bon de commande", "Projet", "Code direction","Num FSB", "Nature", "Paiement", "Numero OP", "Ref Compta", "exercice", "date echeance", "montant Avoir", "Net à payer", "Montant payé", "Reste à payer", "Etat", "Caisse", "Num Piece", "Date Effet", "Num cheque", "libelle", "Sortie","ref compta"};

    
    //String libEntete[] = {"id","code","daty","dateRegul","tierslib", "montant", "tva", "montantTVA", "montantTTCvrai","code_etablissementlib","projetlib","modepaiementlib", "code", "num","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    PageRecherche pr = new PageRecherche(bonProvisoire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("num").setLibelle("Numero BP");
        pr.getFormu().getChamp("modepaiement").setLibelle("mode paiement");
        pr.getFormu().getChamp("code_etablissementlib").setLibelle("code etablissement");
        pr.getFormu().getChamp("valcaisserefpmt").setLibelle("Caisse");
        pr.getFormu().getChamp("dateRegul1").setLibelle("date Regule min");
        pr.getFormu().getChamp("dateRegul2").setLibelle("date Regule max");
        pr.getFormu().getChamp("numchequerefpmt").setLibelle("numero chq");
        
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
    String where = "";
    if(userRole.compareToIgnoreCase("ROL0000001321113437")==0) {
        where = " and idmodepaiement = '"+Constante.modepaiementDefaut+"'";
        pr.setAWhere(where);
    }else if(userRole.compareToIgnoreCase("ROL000450")==0 || userRole.compareToIgnoreCase("ROL000002")==0){
        where = " and idmodepaiement != '"+Constante.modepaiementDefaut+"'";
        pr.setAWhere(where);
    }else pr.setAWhere(aWhere);

    System.out.println("ty za"+pr.getAWhere());


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
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BPVALIDE_LIBTOUS") == 0) {%>    
                        <option value="BPVALIDE_LIBTOUS" selected>Tous</option>
                        <% } else { %>
                        <option value="BPVALIDE_LIBTOUS" >Tous</option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BPVALIDE_LIBCREE") == 0) {%>    
                        <option value="BPVALIDE_LIBCREE" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="BPVALIDE_LIBCREE" >Cr&eacute;&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BPVALIDE_LIBVISE") == 0) {%>    
                        <option value="BPVALIDE_LIBVISE" selected>Valid&eacute;</option>
                        <% } else { %>
                        <option value="BPVALIDE_LIBVISE" >Valid&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("BPNONREGULARISER_LIB") == 0) {%>    
                        <option value="BPNONREGULARISER_LIB" selected>Non regularisé</option>
                        <% } else { %>
                        <option value="BPNONREGULARISER_LIB" >Non regularisé</option>
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
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);            
            pr.getTableau().setNameActe("editerOP");
            pr.getTableau().setNameBoutton("Editer OP");
            out.println(pr.getTableau().getHtmlWithCheckbox());
        %>
        <div style="display: flex; justify-content: flex-end; align-items: center;">
            <input type="button" class="btn btn-info" onclick="decaisser()" style="margin-right:30px" value="D�caisser"/>
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


