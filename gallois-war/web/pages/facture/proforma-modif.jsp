<%@page import="affichage.Liste"%>
<%@page import="affichage.PageUpdateMultiple"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageUpdate"%>
<%@page import="facture.ProformaFille"%>
<%@page import="facture.ProformaMere"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%
try {
    String titrePage = "Modification d'une demande de prix" ,
            classeMere = "facture.ProformaMere" ,
            classeFille = "facture.ProformaFille",
            buteLien = "facture/proforma-fiche.jsp" ,
            colonneMereDansFille = "idmere",
            buteApresVisa = "facture/proforma-fiche.jsp";
    
    ProformaMere  mere = new ProformaMere();
    mere.setNomTable("proforma_mere_ordre");
    ProformaFille fille = new ProformaFille();
    fille.setNomTable("PROFORMA_FILLE_LIB");
    fille.setIdmere(request.getParameter("id"));
    ProformaFille[] liste = (ProformaFille[]) CGenUtil.rechercher(fille, null, null, "");
   
  
   PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), liste.length);
    pi.setLien((String) session.getValue("lien"));
  
    pi.getFormu().getChamp("typeEngagement").setVisible(false);
    pi.getFormu().getChamp("estAncienne").setVisible(false);
    pi.getFormu().getChamp("designation").setLibelle("Note explicative");
    pi.getFormu().getChamp("exercice").setLibelle("Exercice");
    pi.getFormu().getChamp("exercice").setDefaut(String.valueOf(Utilitaire.getAnneeEnCours()));
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("date_echeance").setLibelle("Date echeance");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idprevision").setLibelle("escale");
    pi.getFormu().getChamp("idprevision").setPageAppel("choix/listePrevisionChoix.jsp");
    pi.getFormu().getChamp("tiers").setPageAppel("choix/clientCategorieChoix.jsp");
    //pi.getFormu().getChamp("idProvision").setPageAppel("choix/listeFactureProvisionChoix.jsp");
    pi.getFormu().getChamp("tva").setVisible(false);
    pi.getFormu().getChamp("idavoir").setVisible(false);
    pi.getFormu().getChamp("pourCompte").setPageAppel("choix/clientCategorieChoix.jsp");
    pi.getFormu().getChamp("pourCompte").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setAutre("readonly");
    pi.getFormu().getChamp("provenance").setAutre("readonly");
    pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireExterneChoix.jsp");
    pi.getFormu().getChamp("destination").setAutre("readonly");
    pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireExterneChoix.jsp");
    pi.getFormu().getChamp("idprevision").setAutre("readonly");
    pi.getFormu().getChamp("dateDepart").setLibelle("Date de départ");
    pi.getFormu().getChamp("dateArrivee").setLibelle("Date d'arrivée");
    pi.getFormu().getChamp("heureDepart").setLibelle("Heure de départ");
    pi.getFormu().getChamp("heureArrivee").setLibelle("Heure d'arrivée");
    pi.getFormu().getChamp("bateau").setLibelle("Navire");
    pi.getFormu().getChamp("bateau").setPageAppel("choix/listeNavireChoix.jsp","bateau;bateaulibelle;volume100;volume;lht;lm;te;jnt");
    pi.getFormu().getChamp("bateau").setAutre("readonly");
    pi.getFormu().getChamp("provenance").setPageAppel("choix/listePostedestinataireExterneChoix.jsp");
    pi.getFormu().getChamp("provenance").setAutre("readonly");
    pi.getFormu().getChamp("destination").setPageAppel("choix/listePostedestinataireExterneChoix.jsp");
    pi.getFormu().getChamp("destination").setAutre("readonly");
    pi.getFormu().getChamp("volume").setAutre("readonly");
    
    pi.getFormu().getChamp("lht").setAutre("readonly");
    pi.getFormu().getChamp("lm").setAutre("readonly");
    pi.getFormu().getChamp("te").setAutre("readonly");
    pi.getFormu().getChamp("jnt").setAutre("readonly");
    
    affichage.Liste[] listes= new affichage.Liste[3];
    
    TypeObjet type = new TypeObjet();
    type.setNomTable("typefc");
    listes[0] = new Liste("type", type, "VAL", "id");
        
    TypeObjet categ = new TypeObjet();
    categ.setNomTable("categorieFC");
    listes[1] = new Liste("idcategorie", categ, "VAL", "id");
    listes[1].setDefaultSelected(Constante.idCategorieFCProforma);

    TypeObjet devise = new TypeObjet();
    devise.setNomTable("devise");
    listes[2] = new Liste("deviseMere", devise, "VAL", "id");
    listes[2].setDefaultSelected("Ar");
    
    pi.getFormu().changerEnChamp(listes);
    
    pi.getFormu().getChamp("deviseMere").setLibelle("Devise");
    pi.getFormu().getChamp("codePrestation").setLibelle("Code prestation");
    //pi.getFormu().getChamp("idProvision").setAutre("readonly");
    pi.getFormu().getChamp("idcategorie").setLibelle("Categorie");    
    //pi.getFormu().getChamp("idProvision").setLibelle("Provision");
    pi.getFormu().getChamp("idProvision").setVisible(false);
    
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
        pi.getFormufle().getChamp("duree_"+i).setAutre("onblur='calculerMontant("+i+")'");
        pi.getFormufle().getChamp("montant_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("devise_"+i).setDefaut(Constante.deviseAr);
        pi.getFormufle().getChamp("duree_"+i).setDefaut("1");
        pi.getFormufle().getChamp("idactivite_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("idactivite_"+i).setPageAppel("choix/listeActiviteChoix.jsp");
    }
    
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("taux"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false); 
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"),false);
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("tva"), "20");
    pi.getFormufle().getChamp("devise_0").setLibelle("Devise");
    pi.getFormufle().getChamp("designation_0").setLibelle("d&eacute;signation");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("duree_0").setLibelle("Durée");
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
        pi.getFormufle().getChamp("daty_0").setLibelle("Date");
    pi.getFormufle().getChamp("idactivite_0").setLibelle("Activité");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idactivite"), "choix/listeActiviteChoix.jsp", "idactivite;idactivitelibelle;quantite;pu;tva;datefact;designation");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("rubrique"), "choix/listeRubriqueChoix.jsp", "rubrique;rubriquelibelle;designation;pu;tva;compte;devise;comptelibelle");
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("compte"), "choix/listeCompteCAchoix.jsp", "compte;comptelibelle");    
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("rubrique"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("compte"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("dateFact"), "readonly");
    
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("annee"),Utilitaire.getAnneeEnCours());
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("mois"),new Integer (Utilitaire.getMoisEnCours() + 1).toString());
    
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
    //pi.getFormu().getChamp("code").setVisible(false);
    String[] ordreFille = {"rubrique","designation","pu","quantite", "duree","taux","id","idmere","compte","idproduit","devise","montant","tva","idactivite","datefact","mois","annee", "daty" , "heureDebut","heureFin","majoration","reduction"};
    pi.getFormufle().setColOrdre(ordreFille);
    
    
    mere.setNomTable("PROFORMA_MERE_MSUM_LIB");
    mere.setId(request.getParameter("id"));
    ProformaMere[] pf = (ProformaMere[])CGenUtil.rechercher(mere, null, null, "");
    mere = pf[0];
    
    pi.getFormu().getChamp("tiers").setValeurLibelle(mere.getTierslib());
    pi.getFormu().getChamp("idprevision").setValeurLibelle(mere.getIdprevision());
    //pi.getFormu().getChamp("idProvision").setValeurLibelle(mere.getIdProvisionlib());
    pi.getFormu().getChamp("provenance").setValeurLibelle(mere.getProvenancelib());
    pi.getFormu().getChamp("destination").setValeurLibelle(mere.getDestinationlib());
    pi.getFormu().getChamp("pourCompte").setValeurLibelle(mere.getPourCompteLib());
    
    
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1><%=titrePage%></h1>
    <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
        <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    pi.getFormufle().makeHtmlInsertTableauIndex();
                %>
                <div class="row">
                    <div class="col-md-12">
                    <%    
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    </div>
                </div>
                  
                <div class="row">
                    <div class="col-md-11">
                    <%
                        out.println(pi.getFormufle().getHtmlTableauInsert());
                    %>
                    </div>
                </div>
       <input name="acte" type="hidden" id="nature" value="updateInsert">
        <input name="bute" type="hidden" id="bute" value="<%= buteLien %>?id=<%=request.getParameter("id")%>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille %>">
    </form>
</div>
<script  language="JavaScript">    
    function calculerMontant(indice) {
        var quantite, pu, montant, duree;
        quantite = parseFloat($('#quantite_' + indice).val());
        duree = parseFloat($('#duree_' + indice).val());
//        quantite = quantite / 1000;
        pu = parseFloat($('#pu_' + indice).val());
        if (!isNaN(quantite) && !isNaN(pu)) {
            montant = quantite * pu * duree;
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
        $('#compte_<%=i%>').parent().attr('style', ''); 
    <%}%>
        
</script>
<%} catch (Exception e) {
    e.printStackTrace();
}%>