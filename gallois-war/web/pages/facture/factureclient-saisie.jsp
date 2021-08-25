<%-- 
    Document   : facture-client-saisie-multiple
    Created on : 10 dï¿½c. 2020, 11:57:14
    Author     : Sanda
--%>
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
    FactureClient  fc = new FactureClient();
    FactureClientDetails fcfille = new FactureClientDetails();
    fcfille.setNomTable("facture_client_fille_plus");
    
    PageInsertMultiple pi = new PageInsertMultiple(fc, fcfille, request, 10, u);
    pi.setLien((String) session.getValue("lien"));
    
    
    String mere=request.getParameter("idmere");
    if(mere!=null && mere.compareToIgnoreCase("")!=0)pi.getFormu().getChamp("idmere").setDefaut(mere);
    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("date_echeance").setLibelle("Date echeance");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idprevision").setLibelle("escale");
    pi.getFormu().getChamp("idprevision").setPageAppel("choix/listePrevisionChoix.jsp");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/clientCategorieChoix.jsp");
    pi.getFormu().getChamp("idProvision").setPageAppel("choix/listeFactureProvisionChoix.jsp");
    
    
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setAutre("readonly");
    pi.getFormu().getChamp("idprevision").setAutre("readonly");
    
    affichage.Liste[] listes= new affichage.Liste[3];
    
    TypeObjet type = new TypeObjet();
        type.setNomTable("typefc");
        listes[0] = new Liste("type", type, "VAL", "id");
        
     TypeObjet categ = new TypeObjet();
        categ.setNomTable("categorieFC");
        listes[1] = new Liste("idcategorie", categ, "VAL", "id");
        
//    TypeObjet prestation = new TypeObjet();
//        prestation.setNomTable("code_prestation");
//        listes[2] = new Liste("codePrestation", prestation, "VAL", "id");
    
    TypeObjet devise = new TypeObjet();
        devise.setNomTable("devise");
        listes[2] = new Liste("deviseMere", devise, "VAL", "id");
        listes[2].setDefaultSelected("Ar");
    
    pi.getFormu().changerEnChamp(listes);
    
    pi.getFormu().getChamp("deviseMere").setLibelle("Devise");
    pi.getFormu().getChamp("codePrestation").setLibelle("Code prestation");
    pi.getFormu().getChamp("idProvision").setAutre("readonly");
    pi.getFormu().getChamp("idcategorie").setLibelle("Categorie");    
    pi.getFormu().getChamp("idProvision").setLibelle("Provision");
       
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
        pi.getFormufle().getChamp("devise_"+i).setDefaut(Constante.deviseAr);
        pi.getFormufle().getChamp("idactivite_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("idactivite_"+i).setPageAppel("choix/listeActiviteChoix.jsp");
    }
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("taux"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"),false);
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("tva"), "20");
    pi.getFormufle().getChamp("devise_0").setLibelle("Devise");
    pi.getFormufle().getChamp("designation_0").setLibelle("Designation");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("pu_0").setLibelle("Pu");
    pi.getFormufle().getChamp("compte_0").setLibelle("Compte");
    pi.getFormufle().getChamp("idproduit_0").setLibelle("Produit");
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("tva_0").setLibelle("tva");
    pi.getFormufle().getChamp("datefact_0").setLibelle("Date fact");
    pi.getFormufle().getChamp("rubrique_0").setLibelle("Rubrique");
    pi.getFormufle().getChamp("mois_0").setLibelle("Mois");
    
    pi.getFormufle().getChamp("annee_0").setLibelle("Année");
    pi.getFormufle().getChamp("heureDebut_0").setLibelle("Heure debut");
    pi.getFormufle().getChamp("heureFin_0").setLibelle("Heure fin");
    pi.getFormufle().getChamp("reduction_0").setLibelle("RED. %");
    pi.getFormufle().getChamp("majoration_0").setLibelle("MAJ. %");
    
    pi.getFormufle().getChamp("idactivite_0").setLibelle("Activité");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idactivite"), "choix/listeActiviteChoix.jsp", "idactivite;idactivitelibelle;quantite;pu;tva;datefact;designation");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("rubrique"), "choix/listeRubriqueChoix.jsp", "rubrique;rubriquelibelle;designation;pu;tva;compte");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("rubrique"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("dateFact"), "readonly");
    
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("annee"),Utilitaire.getAnneeEnCours());
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("mois"),new Integer (Utilitaire.getMoisEnCours() + 1).toString());
    //String[]valeurChampEstDDPMICTSL = {"0", "1"};
    //String[]afficheChampEstDDPMICTSL = {"non", "oui"};
    
    //affichage.Liste[] lst= new affichage.Liste[1];
    //lst[0] = new Liste("EstDDPMICTSL");
    //lst[0].ajouterValeur(valeurChampEstDDPMICTSL, afficheChampEstDDPMICTSL);
    
    String[]valeurChampEstMICTSL = {"0", "1"};
    String[]afficheChampEstMICTSL = {"non", "oui"};
    
    affichage.Liste[] lst= new affichage.Liste[1];
    lst[0] = new Liste("estMictsl");
    lst[0].ajouterValeur(valeurChampEstMICTSL, afficheChampEstMICTSL); 
    
    pi.getFormu().changerEnChamp(lst);
//    pi.getFormu().getChamp("EstDDPMICTSL").setDefaut("0");
//    pi.getFormu().getChamp("EstDDPMICTSL").setLibelle("Droit de Port MICTSL");
    pi.getFormu().getChamp("EstDDPMICTSL").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("codePrestation").setVisible(false);
    pi.getFormu().getChamp("code").setVisible(false);

    pi.preparerDataFormu();
       
%>
<div class="content-wrapper">
    <h1>Enregistrer facture client</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" name="starticle" id="starticle">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="facture/factureclient-fiche-vaovao.jsp">
        <input name="classe" type="hidden" id="classe" value="facture.FactureClient">
        <input name="classefille" type="hidden" id="classefille" value="facture.FactureClientDetails">
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
