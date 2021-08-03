<%@page import="facture.FactureClientDetails"%>
<%@page import="facture.FactureClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String titrePage = "Modification Facture Client",
                classeMere = "facture.FactureClient",
                classeFille = "facture.FactureClientDetails",
                buteLien = "facture/factureclient-fiche-vaovao.jsp",
                colonneMereDansFille = "idmere",
                buteApresVisa = "facture/factureclient-fiche-vaovao.jsp";
        String autreparsley = "data-parsley-range='[8, 40]' required";
        FactureClient mere = new FactureClient();
        mere.setNomTable("FACTURECLIENTMSUM_LIB");
        FactureClientDetails fille = new FactureClientDetails();
        fille.setNomTable("FACTURE_CLIENT_FILLE_libelle");
        fille.setIdmere(request.getParameter("id"));
        FactureClientDetails[] liste = (FactureClientDetails[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
        pi.setLien((String) session.getValue("lien"));

        affichage.Liste[] listeM = new affichage.Liste[3];
        TypeObjet oM = new TypeObjet();
        oM.setNomTable("TYPEFC");
        listeM[0] = new Liste("type", oM, "VAL", "id");

        TypeObjet oM1 = new TypeObjet();
        oM1.setNomTable("categorieFC");
        listeM[1] = new Liste("idcategorie", oM1, "VAL", "id");

        String[] ajoutValeur = {"0", "1"};
        String ajoutAffiche[] = {"Non", "Oui"};
        listeM[2] = new Liste("estDDPMICTSL");
        ((Liste) listeM[2]).ajouterValeur(ajoutValeur, ajoutAffiche);
        pi.getFormu().changerEnChamp(listeM);

        pi.getFormu().getChamp("estDDPMICTSL").setLibelle("Droit de Port MICTSL");
        pi.getFormu().getChamp("idProvision").setPageAppel("choix/listeFactureProvisionChoix.jsp");
        pi.getFormu().getChamp("idProvision").setAutre("readonly");
        pi.getFormu().getChamp("idProvision").setLibelle("Provision");

        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeClientChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");

        pi.getFormu().getChamp("idprevision").setPageAppel("choix/listePrevisionChoix.jsp");
        pi.getFormu().getChamp("idprevision").setAutre("readonly");
        pi.getFormu().getChamp("idprevision").setLibelle("Escale");
        pi.getFormu().getChamp("escale").setVisible(false);
        pi.getFormu().getChamp("typelib").setVisible(false);
        pi.getFormu().getChamp("categorielib").setVisible(false);
        pi.getFormu().getChamp("idProvisionlib").setVisible(false);

        pi.getFormu().getChamp("iduser").setAutre("readonly");
        pi.getFormu().getChamp("iduser").setLibelle("User");
        pi.getFormu().getChamp("date_echeance").setLibelle("date d'Echeance");
        pi.getFormu().getChamp("daty").setLibelle("date");
        pi.getFormu().getChamp("type").setLibelle("Type FC");
        pi.getFormu().getChamp("idcategorie").setLibelle("Catégorie");

        pi.getFormu().getChamp("etat").setAutre("readonly");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("iduser").setAutre("readonly");
        pi.getFormu().getChamp("montant").setVisible(false);
        pi.getFormu().getChamp("montanttva").setVisible(false);
        pi.getFormu().getChamp("montantttc").setVisible(false);
        pi.getFormu().getChamp("tierslib").setVisible(false);

        pi.getFormu().getChamp("montantavoir").setVisible(false);
        pi.getFormu().getChamp("Montantpaye").setVisible(false);
        pi.getFormu().getChamp("Montantreste").setVisible(false);
        pi.getFormu().getChamp("Contact").setVisible(false);
        pi.getFormu().getChamp("Adresse").setVisible(false);

        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        //affichage.Champ.setAutre(pi.getFormufle().getChampFille("Taux"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("activitelib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("rubriquelib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("produit_lib"), false);

        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");

        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idactivite"), "choix/listeActiviteChoix.jsp", "idactivite;idactivitelibelle;quantite;pu;tva;datefact;designation");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("idactivite"), "readonly");

        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("rubrique"), "choix/listeRubriqueChoix.jsp", "rubrique;rubriquelibelle;designation;pu;tva;compte");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("rubrique"), "readonly");

        affichage.Liste[] listed = new affichage.Liste[1];
        TypeObjet o = new TypeObjet();
        o.setNomTable("devise");
        listed[0] = new Liste("devise", o, "VAL", "id");
        pi.getFormufle().changerEnChamp(listed);

        pi.getFormufle().getChamp("idactivite_0").setLibelle("Activité");
        pi.getFormufle().getChamp("Id_0").setLibelle("Id");
        pi.getFormufle().getChamp("designation_0").setLibelle("Désignation");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
        pi.getFormufle().getChamp("pu_0").setLibelle("pu");
        pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("Devise_0").setLibelle("Devise");
        pi.getFormufle().getChamp("tva_0").setLibelle("tva");
        //pi.getFormufle().getChamp("Idactivite_0").setLibelle("Activité");
        pi.getFormufle().getChamp("datefact_0").setLibelle("Date fact");
        pi.getFormufle().getChamp("rubrique_0").setLibelle("Rubrique");
        pi.getFormufle().getChamp("Mois_0").setLibelle("Mois");
        pi.getFormufle().getChamp("Mois_0").setLibelle("Mois");
        pi.getFormufle().getChamp("Annee_0").setLibelle("Année");
        pi.getFormufle().getChamp("HeureDebut_0").setLibelle("Heure Début");
        pi.getFormufle().getChamp("HeureFin_0").setLibelle("Heure Fin");
        pi.getFormufle().getChamp("Taux_0").setLibelle("Taux");
        pi.getFormufle().getChamp("reduction").setLibelle("RED. %");
        pi.getFormufle().getChamp("majoration").setLibelle("MAJ. %");

        mere = (FactureClient) pi.getBase();
        pi.preparerDataFormu();

        for (int i = 0; i < liste.length; i++) {
            affichage.Champ datefactChp = pi.getFormufle().getChamp("datefact_" + i);
            datefactChp.setAutre("readonly");
            if (datefactChp.getValeur() != null && !"".equals(datefactChp.getValeur())) {
                String dateF = Utilitaire.datetostring(Utilitaire.stringToDate("yyyy-MM-dd", datefactChp.getValeur()));
                datefactChp.setValeur(dateF);
            }
        }

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
</script>
<%} catch (Exception ex) {
        ex.printStackTrace();
    }%>