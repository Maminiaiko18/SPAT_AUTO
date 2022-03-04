<%@page import="facture.FactureFournisseurDetails"%>
<%@page import="facture.FactureFournisseur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String titrePage = "Modification Facture Fournisseur",
                classeMere = "facture.FactureFournisseur",
                classeFille = "facture.FactureFournisseurDetails",
                buteLien = "facture/facture-fournisseur-fiche-vaovao.jsp",
                colonneMereDansFille = "idmere",
                buteApresVisa = "facture/facture-fournisseur-fiche-vaovao.jsp";
        
        FactureFournisseur mere = new FactureFournisseur();
        mere.setNomTable("FACTFOURN_MSUM_LIB");
        mere.setEstDDPMICTSL(null);
        FactureFournisseurDetails fille = new FactureFournisseurDetails();
        fille.setNomTable("FACTFOURN_FILLE_LIBELLE");
        fille.setIdmere(request.getParameter("id"));
        FactureFournisseurDetails[] liste = (FactureFournisseurDetails[]) CGenUtil.rechercher(fille, null, null, " order by daty, rang");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
        pi.setLien((String) session.getValue("lien"));

        affichage.Liste[] listeM = new affichage.Liste[4];
        TypeObjet oM = new TypeObjet();
        oM.setNomTable("TYPEFC");
        listeM[0] = new Liste("type", oM, "VAL", "id");

        TypeObjet oM1 = new TypeObjet();
        oM1.setNomTable("categorieFF");
        listeM[1] = new Liste("idcategorie", oM1, "VAL", "id");

        /*String[] ajoutValeur = {"0", "1"};
        String ajoutAffiche[] = {"Non", "Oui"};
        listeM[2] = new Liste("estMictsl");
        listeM[2].ajouterValeur(ajoutValeur, ajoutAffiche);*/
        
        TypeObjet devise = new TypeObjet();
        devise.setNomTable("devise");
        listeM[2] = new Liste("deviseMere", devise, "VAL", "id");
        
        TypeObjet nature = new TypeObjet();
        nature.setNomTable("nature");
        listeM[3] = new Liste("nature", nature, "val", "id");
        
        pi.getFormu().changerEnChamp(listeM);

        pi.getFormu().getChamp("estDDPMICTSL").setLibelle("Droit de Port MICTSL");
        pi.getFormu().getChamp("idProvision").setPageAppel("choix/listeFactureProvisionChoix.jsp");
        pi.getFormu().getChamp("idProvision").setAutre("readonly");
        pi.getFormu().getChamp("idProvision").setLibelle("Provision");
        pi.getFormu().getChamp("designation").setLibelle("Note explicative");
        pi.getFormu().getChamp("exercice").setLibelle("Exercice");
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp");
        pi.getFormu().getChamp("idengagement").setAutre("readonly");
        pi.getFormu().getChamp("idengagement").setLibelle("Engagement");

        pi.getFormu().getChamp("idprevision").setPageAppel("choix/listePrevisionChoix.jsp");
        pi.getFormu().getChamp("idprevision").setAutre("readonly");
        pi.getFormu().getChamp("idprevision").setVisible(false);
        pi.getFormu().getChamp("escale").setVisible(false);
        pi.getFormu().getChamp("typelib").setVisible(false);
        pi.getFormu().getChamp("categorielib").setVisible(false);
        pi.getFormu().getChamp("idProvisionlib").setVisible(false);
        pi.getFormu().getChamp("idengagementlib").setVisible(false);
        //pi.getFormu().getChamp("estAuto").setVisible(false);

        pi.getFormu().getChamp("iduser").setAutre("readonly");
        pi.getFormu().getChamp("iduser").setLibelle("User");
        pi.getFormu().getChamp("date_echeance").setLibelle("date d'Echeance");
        pi.getFormu().getChamp("daty").setLibelle("date");
        pi.getFormu().getChamp("type").setLibelle("Type FC");
        pi.getFormu().getChamp("idcategorie").setLibelle("Catégorie");
        pi.getFormu().getChamp("codePrestation").setLibelle("Code prestation");
        pi.getFormu().getChamp("code").setLibelle("Code");
        pi.getFormu().getChamp("deviseMere").setLibelle("Devise");
        pi.getFormu().getChamp("EtatLib").setLibelle("Etat");
        pi.getFormu().getChamp("EtatLib").setAutre("readonly");

        pi.getFormu().getChamp("etat").setAutre("readonly");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("EtatLib").setVisible(false);
        pi.getFormu().getChamp("iduser").setAutre("readonly");
        pi.getFormu().getChamp("montant").setVisible(false);
        pi.getFormu().getChamp("montanttva").setVisible(false);
        pi.getFormu().getChamp("montantttc").setVisible(false);
        pi.getFormu().getChamp("idBL").setVisible(false);
        pi.getFormu().getChamp("montantttcvrai").setVisible(false);
        pi.getFormu().getChamp("tierslib").setVisible(false);
        pi.getFormu().getChamp("codeProvision").setVisible(false);

        pi.getFormu().getChamp("montantavoir").setVisible(false);
        pi.getFormu().getChamp("Montantpaye").setVisible(false);
        pi.getFormu().getChamp("Montantreste").setVisible(false);
        pi.getFormu().getChamp("Contact").setVisible(false);
        pi.getFormu().getChamp("Adresse").setVisible(false);
        pi.getFormu().getChamp("codePrestationlib").setVisible(false);
        pi.getFormu().getChamp("codePrestation").setVisible(false);
        pi.getFormu().getChamp("estDDPMICTSL").setVisible(false);    
        pi.getFormu().getChamp("tva").setVisible(false);    
        pi.getFormu().getChamp("estMictsl").setVisible(false);
        
        pi.getFormu().getChamp("projetlib").setVisible(false);    
        pi.getFormu().getChamp("code_etablissementlib").setVisible(false);
        pi.getFormu().getChamp("naturelib").setVisible(false);
        pi.getFormu().getChamp("numeroop").setLibelle("N° facture");
        pi.getFormu().getChamp("code").setLibelle("Numéro Compta");
        pi.getFormu().getChamp("code_etablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp", "code_etablissement;code_etablissementlibelle");
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp", "projet;projetlibelle"); 
        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("code_etablissement").setAutre("readonly");
        pi.getFormu().getChamp("code_etablissement").setLibelle("Code direction");
        pi.getFormu().getChamp("projet").setLibelle("Projet");

        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("compte"), "choix/listeBudgetDepenseChoix.jsp", "compte;compte;comptelibelle");
        
        
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        //affichage.Champ.setAutre(pi.getFormufle().getChampFille("Taux"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("activitelib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("rubriquelib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("produit_lib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("rang"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("daty"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("rubriquelib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idactivite"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("rubrique"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("heureDebut"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("heureFin"), false);
        

        //affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("compte"), "choix/listeCompteCAchoix.jsp", "compte");
        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");

        //affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idactivite"), "choix/listeActiviteChoix.jsp", "idactivite;idactivitelibelle;quantite;pu;tva;datefact;designation");
        //affichage.Champ.setAutre(pi.getFormufle().getChampFille("idactivite"), "readonly");

        //affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("rubrique"), "choix/listeRubriqueChoix.jsp", "rubrique;rubriquelibelle;designation;pu;tva;compte;devise");
        //affichage.Champ.setAutre(pi.getFormufle().getChampFille("rubrique"), "readonly");

        affichage.Liste[] listed = new affichage.Liste[2];
        TypeObjet o = new TypeObjet();
        o.setNomTable("devise");
        listed[0] = new Liste("devise", o, "VAL", "id");
        
        TypeObjet o1 = new TypeObjet();
        o1.setNomTable("mois");
        listed[1] = new Liste("mois", o1, "VAL", "id");
        
        pi.getFormufle().changerEnChamp(listed);
        
        for (int i = 0; i < liste.length; i++) {
            pi.getFormufle().getChamp("designation_"+i).setAutre(" style=\"width: 150px;\" ");
            affichage.Champ datefactChp = pi.getFormufle().getChamp("datefact_" + i);
            datefactChp.setAutre("readonly");
            if (datefactChp.getValeur() != null && !"".equals(datefactChp.getValeur())) {
                String dateF = Utilitaire.datetostring(Utilitaire.stringToDate("yyyy-MM-dd", datefactChp.getValeur()));
                datefactChp.setValeur(dateF);
            }
        }
        
       // pi.getFormufle().getChamp("idactivite_0").setLibelle("Activité");
        pi.getFormufle().getChamp("Id_0").setLibelle("Id");
        pi.getFormufle().getChamp("designation_0").setLibelle("Note explicative");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
        pi.getFormufle().getChamp("pu_0").setLibelle("pu");
        pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("Devise_0").setLibelle("Devise");
        pi.getFormufle().getChamp("tva_0").setLibelle("tva");
        pi.getFormufle().getChamp("datefact_0").setLibelle("Date fact");
       // pi.getFormufle().getChamp("rubrique_0").setLibelle("Rubrique");
        pi.getFormufle().getChamp("Mois_0").setLibelle("Mois");
        pi.getFormufle().getChamp("Annee_0").setLibelle("Année");
        //pi.getFormufle().getChamp("HeureDebut_0").setLibelle("Heure Début");
        //pi.getFormufle().getChamp("HeureFin_0").setLibelle("Heure Fin");
        pi.getFormufle().getChamp("Taux_0").setLibelle("Taux");
        pi.getFormufle().getChamp("reduction_0").setLibelle("RED. %");
        pi.getFormufle().getChamp("majoration_0").setLibelle("MAJ. %");

        pi.preparerDataFormu();
        mere = (FactureFournisseur) pi.getBase();
        

%>
<div class="content-wrapper">
    <div class="box">
        <h1><%= titrePage%></h1>
        <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
            <%
                pi.getFormu().makeHtmlInsertTabIndex();
                pi.getFormufle().makeHtmlInsertTableauIndex();
                out.println(pi.getFormu().getHtmlInsert());
            %>
            <center style="margin-bottom: 10px;"> <a class="btn btn-success button-margin"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=<%= buteApresVisa%>&classe=<%= classeMere%>">Viser</a> </center>
            <div class="row">
                <div class="col-md-12">
                    <%
                        out.println(pi.getFormufle().getHtmlTableauInsert());
                    %>
                </div>
            </div>

            <input name="acte" type="hidden" id="nature" value="updateInsert">
            <input name="bute" type="hidden" id="bute" value="<%= buteLien%>?id=<%=request.getParameter("id")%>">
            <input name="classe" type="hidden" id="classe" value="<%= classeMere%>">
            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille%>">
            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille%>">

        </form>
    </div>
</div>
<script>
    
    //$('#ajout_multiple_ligne tr td:nth-child(7)').attr('style', '');
    <% for(int i=0; i<pi.getNombreLigne(); i++){ %>
    $('#idproduit_<%= i %>').parent().attr('style', '');    
    <% } %>    
    document.getElementById("projetlibelle").value = "<%= Utilitaire.champNull(mere.getProjetlib()) %>";
    document.getElementById("code_etablissementlibelle").value = "<%= Utilitaire.champNull(mere.getCode_etablissementlib()) %>";
    document.getElementById("tierslibelle").value = "<%= mere.getTierslib()%>";
    <%for (int i = 0; i < liste.length; i++) {%>
    document.getElementById("idactivitelibelle_<%=i%>").value = "<%=liste[i].getActivitelib() != null ? liste[i].getActivitelib() : Utilitaire.champNull(liste[i].getIdactivite())%>";
    document.getElementById("rubriquelibelle_<%=i%>").value = "<%=liste[i].getRubriquelib() != null ? liste[i].getRubriquelib() : Utilitaire.champNull(liste[i].getRubrique())%>";
    document.getElementById("idproduitlibelle_<%=i%>").value = "<%=liste[i].getProduit_lib() != null ? liste[i].getProduit_lib() : Utilitaire.champNull(liste[i].getIdproduit())%>";
    <%}%>
    document.getElementById("idprevisionlibelle").value = '<%=Utilitaire.champNull(mere.getEscale())%>';
    document.getElementById("idProvisionlibelle").value = '<%=Utilitaire.champNull(mere.getIdProvisionlib())%>';

    
    
    var designation = document.getElementById("designation");
    var textarea = document.createElement("textarea");
    textarea.name = "designation";
    textarea.id = "designation";
    textarea.className = "form-control";
    textarea.style.height = "100px";
    textarea.value = designation.value;
    designation.parentNode.replaceChild(textarea, designation);
    
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
<%} catch (Exception ex) {
    ex.printStackTrace();
}%>