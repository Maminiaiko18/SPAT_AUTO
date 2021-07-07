<%-- 
    Document   : facture-fournisseur-saisie-multiple
    Created on : 25 nov. 2020, 15:53:56
    Author     : Sanda
--%>

<%@page import="mg.spat.compta.ContratChantierLibComplet"%>
<%@page import="mg.spat.stock.BonDeLivraisonFilleReste"%>
<%@page import="mg.spat.ChantierLibComplet"%>
<%@page import="utilitaire.Utilitaire"%> 
<%@page import="utilitaire.Constante"%> 
<%@page import="mg.spat.Tva"%> 
<%@page import="mg.spat.Chantier"%> 
<%@page import="affichage.Champ"%> 
<%@page import="affichage.Liste"%> 
<%@page import="bean.TypeObjet"%> 
<%@page import="user.UserEJB"%> 
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="facturefournisseur.FactureFournisseur"%>
<%@page import="facturefournisseur.DetailsFactureFournisseur"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="data.DetailsBcData"%>

<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "facturefournisseur.FactureFournisseur",
                classeFille = "facturefournisseur.DetailsFactureFournisseur",
                titre = "Facturer",
                redirection = "facture/facture-fournisseur-fiche.jsp",
                colonneMere = "idmere",
                nomSaisie = "FactureFournisseur";
        String remarque = "", type = Constante.typeff;
        String tiers = request.getParameter("tiers"), nomprestataire = "";
        String projet = "",projetlib = "", code_etablissement = "",code_etablissementlib = "";
        if (request.getParameter("type") != null) {
            type = request.getParameter("type");
        }
        if (request.getParameter("idBL") != null) {
            remarque = request.getParameter("idBL");
        } else if (request.getParameter("idContrat") != null) {
            remarque = request.getParameter("idContrat");
        }
        else if(request.getParameter("idBC") != null){
            redirection += "&idBC=" + request.getParameter("idBC");            
        }

        int taille = 10, initial = 0;
        BonDeCommande bonDeCommande = new BonDeCommande();
        BonDeLivraisonFilleReste[] restes = new BonDeLivraisonFilleReste[initial];
        ContratChantierLibComplet[] chantiers = new ContratChantierLibComplet[0];
        BonDeCommandeFille[] listeDetailsBC = new BonDeCommandeFille[0];

        FactureFournisseur mere = new FactureFournisseur();
        DetailsFactureFournisseur fille = new DetailsFactureFournisseur();
        fille.setNomTable("DETAILSFACTUREFOURNISSEUR_MT");
        if (request.getParameter("idContrat") != null) {
            ContratChantierLibComplet reference = new ContratChantierLibComplet();
            reference.setNomTable("contrat_chantier_Sum");
            chantiers = (ContratChantierLibComplet[]) CGenUtil.rechercher(reference, null, null, " and id = '" + remarque + "'");
        }
        if (request.getParameter("idBL") != null) {
            BonDeLivraisonFilleReste reference = new BonDeLivraisonFilleReste();
            reference.setNomTable("AS_BONDELIVRAISON_FILLEQTE_RES");
            restes = (BonDeLivraisonFilleReste[]) CGenUtil.rechercher(reference, null, null, " and numbl = '" + remarque + "'");
            if (restes.length > 0) {
                taille = restes.length;
            }
        }
        if (request.getParameter("idBC") != null) {
            DetailsBcData data=new DetailsBcData(request.getParameter("idBC")); 
            data.setBC("AS_BONDECOMMANDE_LIBS","BC_BL_LIVRE");
            bonDeCommande = data.getBc();
            listeDetailsBC = data.getBcFille();
            if (listeDetailsBC.length > 0) {
                taille = listeDetailsBC.length;
            }
        }
        int tailleDetails = taille;
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));

        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet op = new TypeObjet();
        op.setNomTable("DEVISE");
        liste[0] = new Liste("iddevise", op, "desce", "id");
        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("exercice").setDefaut(Utilitaire.getAnneeEnCours());
        pi.getFormu().getChamp("idfournisseur").setPageAppel("choix/listeTiersChoix.jsp");
        pi.getFormu().getChamp("idfournisseur").setAutre("readonly");
        pi.getFormu().getChamp("remarque").setAutre("readonly");
        pi.getFormu().getChamp("designation").setDefaut("Facturation " + remarque);
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("code_etablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("code_etablissement").setAutre("readonly");

        if (request.getParameter("idBC") != null) {
            projet = bonDeCommande.getProjet();
            projetlib = bonDeCommande.getProjet_lib();
            code_etablissement = bonDeCommande.getCode_etab();
            code_etablissementlib = bonDeCommande.getCode_etab_lib();
            tiers = bonDeCommande.getFournisseur();
            nomprestataire = bonDeCommande.getFournisseur_lib();
            remarque = bonDeCommande.getRemarque();
            double montant = 0;
            for (int i = 0; i < tailleDetails; i++) {
                montant = listeDetailsBC[i].getQuantite() * listeDetailsBC[i].getPu();
                pi.getFormufle().getChamp("montant_" + i).setDefaut(Utilitaire.formaterAr(montant));
                pi.getFormufle().getChamp("tva_" + i).setDefaut(Utilitaire.formaterAr(listeDetailsBC[i].getTva()));
                pi.getFormufle().getChamp("pu_" + i).setDefaut(Utilitaire.formaterAr(listeDetailsBC[i].getPu()));
                pi.getFormufle().getChamp("qte_" + i).setDefaut(Utilitaire.formaterAr(listeDetailsBC[i].getQuantite()));
                pi.getFormufle().getChamp("idingredient_" + i).setDefaut(listeDetailsBC[i].getId());                
            }
        }
        if (request.getParameter("idContrat") != null && tailleDetails > 0) {
            pi.getFormufle().getChamp("idingredient_0").setDefaut(chantiers[0].getId());
            pi.getFormufle().getChamp("iddqe_0").setDefaut(chantiers[0].getDesignation());
            pi.getFormufle().getChamp("montant_0").setDefaut(Utilitaire.formaterAr(chantiers[0].getResteAfacturer() + ""));
            pi.getFormufle().getChamp("pu_0").setDefaut(Utilitaire.formaterAr(chantiers[0].getResteAfacturer() + ""));
            pi.getFormufle().getChamp("qte_0").setDefaut("1");
            tiers = chantiers[0].getPrestataire();
            nomprestataire = chantiers[0].getNom_prestataire();            
            projet = chantiers[0].getProjet();
            projetlib = chantiers[0].getProjetlib();
            code_etablissement = chantiers[0].getCode_etablissement();
            code_etablissementlib = chantiers[0].getCode_etablissementlib();
        }
        pi.getFormu().getChamp("iddevise").setAutre("onblur=\"dependanteChampUneValeur(this.value, 'montantdevise', 'coursdevise', 'fin.Coursdevise', 'iddevise', 'iddevise', 'montant','daty','desc');\"");
        pi.getFormu().getChamp("montantdevise").setAutre("readonly");
        pi.getFormu().getChamp("remarque").setDefaut(remarque);
        pi.getFormu().getChamp("datyecheance").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("dateemission").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("idtva").setVisible(false);
        pi.getFormu().getChamp("budget").setVisible(false);
        pi.getFormu().getChamp("type").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("montantttc").setVisible(false);
        pi.getFormu().getChamp("resp").setVisible(false);
        pi.getFormu().getChamp("idfacturefournisseur").setVisible(false);
        pi.getFormu().getChamp("numfact").setLibelle("Numéro Facture");
        pi.getFormu().getChamp("remarque").setLibelle("A facturer");
        pi.getFormu().getChamp("budget").setLibelle("Budget");
        pi.getFormu().getChamp("designation").setLibelle("Designation");
        pi.getFormu().getChamp("dateemission").setLibelle("Date d'émission");
        pi.getFormu().getChamp("datyecheance").setLibelle("Date d'échéance");
        pi.getFormu().getChamp("montantdevise").setLibelle("Montant Devise");
        pi.getFormu().getChamp("iddevise").setLibelle("Devise");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("idfournisseur").setLibelle("Tiers");
        pi.getFormu().getChamp("numid").setLibelle("Numéro compta");
        pi.getFormu().getChamp("code_etablissement").setLibelle("Code direction");
        pi.getFormu().getChamp("numeroop").setVisible(false);

        String idmere = request.getParameter("idmere");
//        affichage.Champ[] listeDetails = new affichage.Champ[pi.getNombreLigne()];
//        Tva tva = new Tva();
        for (int i = 0; i < pi.getNombreLigne(); i++) {
            pi.getFormufle().getChamp("idmere_" + i).setDefaut(idmere);
            pi.getFormufle().getChamp("montant_" + i).setAutre("readonly");
            pi.getFormufle().getChamp("pu_" + i).setAutre("onchange='calculMontant(" + i + ")'");
            pi.getFormufle().getChamp("qte_" + i).setAutre("onchange='calculMontant(" + i + ")'");
            pi.getFormufle().getChamp("idingredient_" + i).setAutre("onchange='setDesignation(" + i + ")'");
//            listeDetails[i] = new Liste("tva_"+ i, tva, "valeurtva", "valeurtva");
        }
//        pi.getFormufle().changerEnChamp(listeDetails);
        if (restes.length > 0) {
            double montant = 0;
            for (int i = 0; i < tailleDetails; i++) {
                montant = restes[i].getQuantiteReste() * restes[i].getPu();
                pi.getFormufle().getChamp("iddqe_" + i).setDefaut(restes[i].getProduit());
                pi.getFormufle().getChamp("idingredient_" + i).setDefaut(restes[i].getId());
                //pi.getFormufle().getChamp("idingredient_" + i).setAutre(" onchange='setDesignation("+i+")' ");
                pi.getFormufle().getChamp("qte_" + i).setDefaut("" + restes[i].getQuantiteReste());
                pi.getFormufle().getChamp("pu_" + i).setDefaut(Utilitaire.formaterAr("" + restes[i].getPu()));
                pi.getFormufle().getChamp("montant_" + i).setDefaut(Utilitaire.formaterAr("" +montant));
                pi.getFormufle().getChamp("idingredient_" + i).setAutre("onchange='setDesignation("+i+")'");
                pi.getFormufle().getChamp("tva_" + i).setDefaut(Utilitaire.formaterAr("" + restes[i].getTva()));
                tiers = restes[i].getIdtiers();
                nomprestataire = restes[i].getNomtiers();
                projet = restes[i].getProjet();
                projetlib = restes[i].getProjetlib();
                code_etablissement = restes[i].getCode_etablissement();
                code_etablissementlib = restes[i].getCode_etablissementlib();
            }
        }
        pi.getFormu().getChamp("projet").setDefaut(projet);
        pi.getFormu().getChamp("projet").setValeurLibelle(projetlib);
        pi.getFormu().getChamp("code_etablissement").setDefaut(code_etablissement);
        pi.getFormu().getChamp("code_etablissement").setValeurLibelle(code_etablissementlib);
        pi.getFormu().getChamp("idfournisseur").setDefaut(tiers);
        pi.getFormu().getChamp("idfournisseur").setValeurLibelle(nomprestataire);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("marge"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("pudevise"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        pi.getFormufle().getChamp("tva_0").setLibelle("TVA");
        pi.getFormufle().getChamp("compte_0").setLibelle("Compte");
        pi.getFormufle().getChamp("iddqe_0").setLibelle("Désignation");
        pi.getFormufle().getChamp("idingredient_0").setLibelle("ID Detail");
        pi.getFormufle().getChamp("pu_0").setLibelle("Prix Unitaire");
        pi.getFormufle().getChamp("qte_0").setLibelle("Quantité");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
        String[] ordreFille = {"idingredient", "pu", "qte", "montant","tva"};
        pi.getFormufle().setColOrdre(ordreFille);
       // pi.getFormufle().setOrdre(ordreFille);
        pi.preparerDataFormu();
%>

<script>
     function setDesignation(index){
        var val = document.getElementById("idingredient_" + index).value;
        document.getElementById("iddqe_" + index).value = val;
    }
</script>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="<%=nomSaisie%>" id="<%=nomSaisie%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="type" type="hidden" id="nature" value="<%=type%>">
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
    </form>
</div>
<script> 
    function rectifierValeur(valeur){
        let nouveau=valeur;
        nouveau=nouveau.trim();
        nouveau=nouveau.replace(/\s+/g,"");
        nouveau=nouveau.replace(",",".");
        return nouveau;
    }
    function calculMontant(index) {
        let montant = document.getElementById("montant_" + index);
        let pu = document.getElementById("pu_" + index).value;
        let quantite = document.getElementById("qte_" + index).value;
        pu = rectifierValeur(pu);
        quantite = rectifierValeur(quantite);

        montant.value = parseFloat(pu) * parseFloat(quantite);
    }
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();
</script>
<% }%>
