<%-- 
    Document   : bondecommande-multiple
    Created on : 4 f�vr. 2021, 16:45:08
    Author     : Sanda
--%>

<%@page import="data.BonDeCommandeData"%>
<%@page import="mg.spat.Engagement"%>
<%@page import="affichage.PageUpdateMultiple"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="utilitaire.Constante" %>
<%@ page import="affichage.Liste" %>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="mg.cnaps.formation.CodeEtablissement"%>

<%
    try {
        String idEngagement  = request.getParameter("idEngagement");
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        BonDeCommandeData data =new BonDeCommandeData(idEngagement,request.getParameter("idDa"));
        Engagement engagement=data.getEngagement();
        String classeMere = "mg.spat.stock.BonDeCommande",
               classeFille = "mg.spat.stock.BonDeCommandeFille",
               titre = "Bon de commande saisie",
			   redirection = "stock/bc/asBonDeCommande-fiche.jsp",
			   colonneMere = "idbc",
               nomSaisie = "bondecommande";
        int taille = 10;
        if(data.getDemandeAchatfilles().length>taille){
            taille=data.getDemandeAchatfilles().length;
        }
        BonDeCommande mere = new BonDeCommande();
        BonDeCommandeFille fille = new BonDeCommandeFille();
        
        /*BonDeCommandeFille ordoF = new BonDeCommandeFille();
        ordoF.setIdbc(request.getParameter("id"));
        BonDeCommandeFille[] listeFF = (BonDeCommandeFille[]) CGenUtil.rechercher(ordoF, null, null, "");
        
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, ordoF, listeFF, request, (user.UserEJB) session.getValue("u"), 2);*/
        
        
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));
        
        pi.getFormu().getChamp("tva").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("iduser").setVisible(false);
        pi.getFormu().getChamp("idDa").setVisible(false);
        pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
        affichage.Champ[] liste = new affichage.Champ[2];
        TypeObjet d = new TypeObjet();
        d.setNomTable("modepaiement");
        liste[0] = new Liste("modepaiement", d, "val", "id");
        TypeObjet liste2 = new TypeObjet();
        liste2.setNomTable("typecheque");
        liste[1] = new Liste("typepaiement", liste2, "val", "id");
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("numbc").setDefaut(BonDeCommande.getNumBCDefaut());
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("code_etab").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("code_etab").setAutre("readonly");
        pi.getFormu().getChamp("fournisseur").setAutre("readonly");
        pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("modepaiement").setDefaut(Constante.modepaiementDefaut);
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("remarque").setLibelle("R&eacute;f&eacute;rence");
        pi.getFormu().getChamp("designation").setLibelle("Designation");
        pi.getFormu().getChamp("fournisseur").setLibelle("Fournisseur");
        pi.getFormu().getChamp("numbc").setLibelle("Numero bon de commande");
        pi.getFormu().getChamp("modepaiement").setLibelle("Mode de paiement");
        pi.getFormu().getChamp("fournisseur").setPageAppel("choix/listeTiersChoix.jsp");
        pi.getFormu().getChamp("code_etab").setLibelle("Code etablissement");
        pi.getFormu().getChamp("delaipaiement").setLibelle("D&eacute;lai de paiement (Jours)");
        pi.getFormu().getChamp("delailivraison").setLibelle("D&eacute;lai de livraison");
        pi.getFormu().getChamp("typepaiement").setLibelle("Type paiement");
        pi.getFormu().getChamp("idengagement").setLibelle("Engagement");
        pi.getFormu().getChamp("idengagement").setAutre("readonly");
        pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp", "idengagement;idengagementlibelle");
        pi.getFormu().getChamp("idengagement").setDefaut(Utilitaire.champNull(engagement.getId()));
        pi.getFormu().getChamp("idengagement").setValeurLibelle(Utilitaire.champNull(engagement.getDesignation()));
        pi.getFormu().getChamp("projet").setDefaut(Utilitaire.champNull(engagement.getProjet()));
        pi.getFormu().getChamp("projet").setValeurLibelle(Utilitaire.champNull(engagement.getProjetlib()));
        pi.getFormu().getChamp("code_etab").setDefaut(Utilitaire.champNull(engagement.getCodeEtablissement()));
        pi.getFormu().getChamp("code_etab").setValeurLibelle(Utilitaire.champNull(engagement.getCodeEtablissementlib()));
        pi.getFormu().getChamp("fournisseur").setDefaut(Utilitaire.champNull(engagement.getTiers()));
        pi.getFormu().getChamp("fournisseur").setValeurLibelle(Utilitaire.champNull(engagement.getTierslib()));
        
        
        
        System.out.println("u.getUser().getCodeEtablissement()=="+u.getUser().getCodeEtablissement());
        if(u.getUser().getCodeEtablissement()!=null){
            CodeEtablissement code= u.getCodeEtablissement();
            pi.getFormu().getChamp("code_etab").setDefaut(u.getUser().getCodeEtablissement());
            pi.getFormu().getChamp("code_etab").setValeurLibelle(code.getVal());
        }
        
//        pi.getFormu().setColOrdre(new String[] {"designation", "daty", "fournisseur", "modepaiement","remarque"});
        
        taille = pi.getNombreLigne();
        for( int i = 0 ; i < taille ; i++ ){       
            pi.getFormufle().getChamp("quantite_"+i).setAutre("onblur='calculerMontant("+i+")'");
            pi.getFormufle().getChamp("pu_"+i).setAutre("onblur='calculerMontant("+i+")'");
            pi.getFormufle().getChamp("montant_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("produit_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("observation_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("produit_"+i).setPageAppel("choix/produitChoix.jsp","produit;produitlibelle;pu;pu");
            pi.getFormufle().getChamp("observation_"+i).setPageAppel("choix/listeDAchoix.jsp","observation;observation;observationlibelle");
        }
        // rehefa mandray param�tre idDa
        pi.getFormu().getChamp("projet").setDefaut(Utilitaire.champNull( data.getDemandeAchatMere().getProjet()));
        pi.getFormu().getChamp("projet").setValeurLibelle(Utilitaire.champNull( data.getDemandeAchatMere().getProjetlib()));
        pi.getFormu().getChamp("code_etab").setDefaut(Utilitaire.champNull( data.getDemandeAchatMere().getCodeetablissement()));
        pi.getFormu().getChamp("code_etab").setValeurLibelle(Utilitaire.champNull( data.getDemandeAchatMere().getCodeetablissementlib()));

        for(int i=0;i<data.getDemandeAchatfilles().length;i++){
            pi.getFormufle().getChamp("produit_"+i).setDefaut(Utilitaire.champNull( data.getDemandeAchatfilles()[i].getProduit()));
            pi.getFormufle().getChamp("Remarque_"+i).setDefaut(Utilitaire.champNull( data.getDemandeAchatfilles()[i].getDesignation()));
            pi.getFormufle().getChamp("produit_"+i).setValeurLibelle(Utilitaire.champNull( data.getDemandeAchatfilles()[i].getProduitlib()));
            pi.getFormufle().getChamp("quantite_"+i).setDefaut(Utilitaire.formaterAr( data.getDemandeAchatfilles()[i].getQte()));
            pi.getFormufle().getChamp("pu_"+i).setDefaut(Utilitaire.formaterSansVirgule(data.getDemandeAchatfilles()[i].getPu()));
            pi.getFormufle().getChamp("Unite_"+i).setDefaut(Utilitaire.champNull( data.getDemandeAchatfilles()[i].getUnite()));
        }
        
        affichage.Champ[] listeUnit = new affichage.Champ[1];
        TypeObjet branche=new TypeObjet();
        branche.setNomTable("UNITECHANTIER");
        listeUnit[0]=new Liste("unite",branche,"val","id");
        pi.getFormufle().changerEnChamp(listeUnit);
        
        pi.getFormufle().getChamp("Unite_0").setLibelle("Unite");
        pi.getFormufle().getChamp("Remarque_0").setLibelle("D&eacute;signation");
        pi.getFormufle().getChamp("Montant_0").setLibelle("Montant");
        pi.getFormufle().getChamp("produit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("pu_0").setLibelle("Prix Unitaire");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantit&eacute;");
        pi.getFormufle().getChamp("tva_0").setLibelle("TVA");
        pi.getFormufle().getChamp("observation_0").setLibelle("Observation");
        pi.getFormufle().getChamp("remise_0").setLibelle("Remise %");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("Quantiteparpack"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idbc"), false);
        
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="<%=nomSaisie%>" id="<%=nomSaisie%>">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
    </form>
</div>
<script  language="JavaScript">
    function calculerMontant(indice) {
        var quantite, pu, montant;
        quantite = parseFloat($('#quantite_' + indice).val());
//        quantite = quantite / 1000;
        pu = parseFloat($('#pu_' + indice).val());
        if (!isNaN(quantite) && !isNaN(pu)) {
            montant = quantite * pu;
            $('#montant_' + indice).val(montant.toFixed(2));
        } else {
            $('#montant_' + indice).val('');
        }
    }

    window.onload = () =>{
        var submitBtns = document.querySelectorAll("button[name='Submit2'][type='submit']");
        for(var i=0; i < submitBtns.length; i++){
            modifySubmitBtn(submitBtns[i]);    
        }
    }
    
    function modifySubmitBtn(btn){
        btn.setAttribute("type","button");
        btn.onclick = save;
    }
    
    function save() {
        var btn = this;
        btn.disabled = true;
        var query = $('#bondecommande').serialize();
        $.get("apresMultipleAjax.jsp?"+query, function(data, status){
            var temp = data.trim().split("_");
            if(temp[0] === 'error'){
                btn.disabled = false;
                alert(temp[1]);
            }
            else{
                window.location.href = "<%=pi.getLien()%>?but=stock/bc/asBonDeCommande-fiche.jsp&id="+temp[1];
            }
        });
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