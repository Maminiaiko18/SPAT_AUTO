
<%@page import="data.FactureFournisseurData"%>
<%@page import="utilisateur.Utilisateur"%>
<%@page import="affichage.Liste"%>
<%@page import="user.*"%> 
<%@page import="facture.FactureClient"%>
<%@page import="facture.FactureClientDetails"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try{
    UserEJB u = null;
    String idUser= "";
    u = (UserEJB) session.getValue("u");
    idUser = ""+u.getUser().getTuppleID();

    String autreparsley = "data-parsley-range='[8, 40]' required";
    facture.FactureFournisseur  fc = new facture.FactureFournisseur();
    fc.setNomTable("facture_Fournisseur_Mere");
    facture.FactureFournisseurDetails fcfille = new facture.FactureFournisseurDetails();
    fcfille.setNomTable("FACTFOURN_FILLE_PLUS");
    FactureFournisseurData data=new FactureFournisseurData(request.getParameter("idBL"));
    data.initData();
    int nbr=10;
    if ((data.getFille()!=null)&&(data.getFille().length>0)) {
            nbr=data.getFille().length;
        }
    PageInsertMultiple pi = new PageInsertMultiple(fc, fcfille, request, nbr, u);
    pi.setLien((String) session.getValue("lien"));
    
    
    String mere=request.getParameter("idmere");
    if(mere!=null && mere.compareToIgnoreCase("")!=0)pi.getFormu().getChamp("idmere").setDefaut(mere);
    
    pi.getFormu().getChamp("designation").setLibelle("Note explicative");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("date_echeance").setLibelle("Date echeance");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idprevision").setVisible(false);
    
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
    pi.getFormu().getChamp("idBL").setPageAppel("choix/listeTiersChoix.jsp");
    pi.getFormu().getChamp("idProvision").setPageAppel("choix/listeFactureProvisionChoix.jsp");
    pi.getFormu().getChamp("idBL").setDefaut(Utilitaire.champNull(request.getParameter("idBL")));
    pi.getFormu().getChamp("tva").setVisible(false);
    pi.getFormu().getChamp("estMictsl").setVisible(false);
    
    pi.getFormu().getChamp("idBL").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setAutre("readonly");
    
    affichage.Liste[] listes= new affichage.Liste[3];
    
    TypeObjet type = new TypeObjet();
        type.setNomTable("typefc");
        listes[0] = new Liste("type", type, "VAL", "id");
        
     TypeObjet categ = new TypeObjet();
        categ.setNomTable("categorieFF");
        listes[1] = new Liste("idcategorie", categ, "VAL", "id");
        listes[1].setDefaultSelected(Constante.categorieFFdefault);
//    TypeObjet prestation = new TypeObjet();
//        prestation.setNomTable("code_prestation");
//        listes[2] = new Liste("codePrestation", prestation, "VAL", "id");
    
    TypeObjet devise = new TypeObjet();
        devise.setNomTable("devise");
        listes[2] = new Liste("deviseMere", devise, "VAL", "id");
        listes[2].setDefaultSelected(Constante.deviseAr);
    
    pi.getFormu().changerEnChamp(listes);
    
    pi.getFormu().getChamp("deviseMere").setLibelle("Devise");
    pi.getFormu().getChamp("codePrestation").setLibelle("Code prestation");
    pi.getFormu().getChamp("idProvision").setAutre("readonly");
    pi.getFormu().getChamp("idcategorie").setLibelle("Categorie");   
    pi.getFormu().getChamp("idBL").setLibelle("Bon de livraison");  
    pi.getFormu().getChamp("idProvision").setLibelle("Bon provisoire");
       
    affichage.Liste[] listed = new affichage.Liste[2];
        TypeObjet o = new TypeObjet();
        o.setNomTable("devise");
        listed[0] = new Liste("devise", o, "VAL", "id");
        
        TypeObjet mois = new TypeObjet();
        mois.setNomTable("mois");
        listed[1] = new Liste("mois", mois, "val", "id");
        listed[1].setApresW("order by id asc");
    pi.getFormufle().changerEnChamp(listed);
    
    int taille = pi.getNombreLigne();
    for( int i = 0 ; i < taille ; i++ ){       
        //pi.getFormufle().getChamp("designation_"+i).setAutre(" style=\"width: 200px;\" ");
        pi.getFormufle().getChamp("quantite_"+i).setAutre("onblur='calculerMontant("+i+")'");
        pi.getFormufle().getChamp("pu_"+i).setAutre("onblur='calculerMontant("+i+")'");
        pi.getFormufle().getChamp("montant_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("idBLF_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("devise_"+i).setDefaut(Constante.deviseAr);
        pi.getFormufle().getChamp("idactivite_"+i).setVisible(false);
        //pi.getFormufle().getChamp("idactivite_"+i).setPageAppel("choix/listeActiviteChoix.jsp");
    }
    if ((data.getFille()!=null)&&(data.getFille().length>0)) {
            for (int i = 0; i < nbr; i++) {
                pi.getFormufle().getChamp("idBLF_"+i).setDefaut(""+data.getFille()[i].getId());
            }
        }
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("taux"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idactivite"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("rubrique"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("heureDebut"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("heureFin"),false);
    
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("tva"), "20");
    pi.getFormufle().getChamp("devise_0").setLibelle("Devise");
    pi.getFormufle().getChamp("designation_0").setLibelle("d&eacute;signation");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("pu_0").setLibelle("Pu");
    pi.getFormufle().getChamp("compte_0").setLibelle("Compte");
    pi.getFormufle().getChamp("idproduit_0").setLibelle("Produit");
    pi.getFormufle().getChamp("idBLF_0").setLibelle("BL détail");
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("tva_0").setLibelle("tva");
    pi.getFormufle().getChamp("datefact_0").setLibelle("Date fact");
    pi.getFormufle().getChamp("rubrique_0").setVisible(false);
    pi.getFormufle().getChamp("mois_0").setLibelle("Mois");
    
    pi.getFormufle().getChamp("annee_0").setLibelle("Ann&eacute;e");
    //pi.getFormufle().getChamp("heureDebut_0").setVisible(false);
    //pi.getFormufle().getChamp("heureFin_0").setVisible(false);
    pi.getFormufle().getChamp("reduction_0").setLibelle("RED. %");
    pi.getFormufle().getChamp("majoration_0").setLibelle("MAJ. %");
    
    //pi.getFormufle().getChamp("idactivite_0").setVisible(false);
    //affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idactivite"), "choix/listeActiviteChoix.jsp", "idactivite;idactivitelibelle;quantite;pu;tva;datefact;designation");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
    //affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("rubrique"), "choix/listeRubriqueChoix.jsp", "rubrique;rubriquelibelle;designation;pu;tva;compte;devise");
    //affichage.Champ.setAutre(pi.getFormufle().getChampFille("rubrique"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("dateFact"), "readonly");
    
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("annee"),Utilitaire.getAnneeEnCours());
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("mois"),new Integer (Utilitaire.getMoisEnCours() + 1).toString());
    //String[]valeurChampEstDDPMICTSL = {"0", "1"};
    //String[]afficheChampEstDDPMICTSL = {"non", "oui"};
    
    //affichage.Liste[] lst= new affichage.Liste[1];
    //lst[0] = new Liste("EstDDPMICTSL");
    //lst[0].ajouterValeur(valeurChampEstDDPMICTSL, afficheChampEstDDPMICTSL);
    
    //String[]valeurChampEstMICTSL = {"0", "1"};
    //String[]afficheChampEstMICTSL = {"non", "oui"};
    
    //affichage.Liste[] lst= new affichage.Liste[1];
    //lst[0] = new Liste("estMictsl");
    //lst[0].ajouterValeur(valeurChampEstMICTSL, afficheChampEstMICTSL); 
    
    //pi.getFormu().changerEnChamp(lst);
//    pi.getFormu().getChamp("EstDDPMICTSL").setDefaut("0");
//    pi.getFormu().getChamp("EstDDPMICTSL").setLibelle("Droit de Port MICTSL");
    pi.getFormu().getChamp("EstDDPMICTSL").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("codePrestation").setVisible(false);
    pi.getFormu().getChamp("code").setVisible(false);

    pi.preparerDataFormu();
       
%>
<div class="content-wrapper">
    <h1>Enregistrer facture fournisseur</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="facture/facture-fournisseur-fiche-vaovao.jsp">
        <input name="classe" type="hidden" id="classe" value="facture.FactureFournisseur">
        <input name="classefille" type="hidden" id="classefille" value="facture.FactureFournisseurDetails">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="idmere">
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
    $('#designation').each(function() {
        var textbox = $(document.createElement('textarea')).val(this.value);
        console.log(this.attributes);
        $.each(this.attributes, function() {
          if (this.specified) {
            textbox.prop(this.name, this.value)
          }
        });
        $(this).replaceWith(textbox);
    });
    var selectList = $('#test option');
    function sortList(select){
        var selectList = select.find("option");
        selectList.sort(function(a,b){
            a = a.value;
            b = b.value;

            return a-b;
        });
        select.html(selectList);
    }
    for(var iL=0; iL<<%=taille%>; iL++){
        sortList($('#mois_'+iL));
    }
    
    <%for (int i = 0; i < pi.getNombreLigne(); i++) {%>
        var designation<%=i%> = document.getElementById("designation_<%=i%>");
        var textarea<%=i%> = document.createElement("textarea");
            textarea<%=i%>.name = "designation_<%=i%>";
            textarea<%=i%>.id = "designation_<%=i%>";
            textarea<%=i%>.className = "form-control";
            textarea<%=i%>.style.height = "100px";
            textarea<%=i%>.value = designation<%=i%>.value;
        designation<%=i%>.parentNode.replaceChild(textarea<%=i%>, designation<%=i%>);
    <%}%>
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
