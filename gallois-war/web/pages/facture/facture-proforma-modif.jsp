<%@page import="facture.FactureProformaDetails"%>
<%@page import="facture.FactureProforma"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{
    String titrePage = "Modification Facture Proforma" ,
            classeMere = "facture.FactureProforma" ,
            classeFille = "facture.FactureProformaDetails",
            buteLien = "facture/facture-proforma-fiche.jsp" ,
            colonneMereDansFille = "idmere",
            buteApresVisa = "facture/facture-proforma-fiche.jsp";
    String autreparsley = "data-parsley-range='[8, 40]' required";
    FactureProforma mere = new FactureProforma();
        mere.setNomTable("FACTUREPROFMSUM_LIB");
    FactureProformaDetails fille = new FactureProformaDetails();
        fille.setNomTable("FACTURE_PROF_FILLE_libelle");
    fille.setIdmere(request.getParameter("id"));
    FactureProformaDetails[] liste = (FactureProformaDetails[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
    pi.setLien((String) session.getValue("lien"));
    
    
    pi.getFormu().getChamp("tiers").setPageAppel("choix/listeClientChoix.jsp");
    pi.getFormu().getChamp("tiers").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setAutre("readonly");
    pi.getFormu().getChamp("iduser").setLibelle("User");
    pi.getFormu().getChamp("date_echeance").setLibelle("date d'Echeance");
    pi.getFormu().getChamp("daty").setLibelle("date");
    pi.getFormu().getChamp("type").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
     pi.getFormu().getChamp("iduser").setAutre("readonly");
    pi.getFormu().getChamp("tierslib").setVisible(false);
    pi.getFormu().getChamp("Montant").setVisible(false);
    pi.getFormu().getChamp("Montanttva").setVisible(false);
    pi.getFormu().getChamp("Montantavoir").setVisible(false);
    pi.getFormu().getChamp("Montantttc").setVisible(false);
    pi.getFormu().getChamp("idprevision").setPageAppel("choix/listePrevisionChoix.jsp");
    pi.getFormu().getChamp("idprevision").setAutre("readonly");
    pi.getFormu().getChamp("idprevision").setLibelle("Escale");
    pi.getFormu().getChamp("escale").setVisible(false);
    
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("taux"), "readonly");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idProduit"), "choix/produitChoix.jsp", "idproduit;idproduitlibelle;designation;designation;designation");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idProduit"), "readonly");
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("idactivite"), "choix/listeActiviteChoix.jsp", "idactivite;idactivitelibelle;quantite;pu;tva;datefact;designation");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("idactivite"), "readonly");
    
    affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("rubrique"), "choix/listeRubriqueChoix.jsp", "rubrique;rubriquelibelle;designation;pu;tva;compte");
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("rubrique"), "readonly");
    
    for(int i=0; i<liste.length; i++){
        pi.getFormufle().getChamp("datefact_"+i).setAutre("readonly");
    }
    
    affichage.Liste[] listed = new affichage.Liste[1];
        TypeObjet o = new TypeObjet();
        o.setNomTable("devise");
        listed[0] = new Liste("devise", o, "VAL", "id");
    pi.getFormufle().changerEnChamp(listed);
    
    pi.getFormufle().getChamp("Id_0").setLibelle("Id"); 
    pi.getFormufle().getChamp("designation_0").setLibelle("Désignation"); 
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("pu_0").setLibelle("pu");
    pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
    pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
    pi.getFormufle().getChamp("Devise_0").setLibelle("Devise");
    pi.getFormufle().getChamp("Taux_0").setLibelle("Taux");
    pi.getFormufle().getChamp("tva_0").setLibelle("TVA");
    
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("activitelib"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("rubriquelib"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("produit_lib"), false);
    
    pi.getFormufle().getChamp("datefact_0").setLibelle("Date fact");
    pi.getFormufle().getChamp("rubrique_0").setLibelle("Rubrique");
    pi.getFormufle().getChamp("Mois_0").setLibelle("Mois");
    pi.getFormufle().getChamp("Annee_0").setLibelle("Année");
    pi.getFormufle().getChamp("HeureDebut_0").setLibelle("Heure Début");
    pi.getFormufle().getChamp("HeureFin_0").setLibelle("Heure Fin");
    pi.getFormufle().getChamp("idactivite_0").setLibelle("Activité");
    
    
    mere = (FactureProforma) pi.getBase();
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
        <div class="box">
            <h1><%= titrePage %></h1>
            <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="medhospi">
                <%
                    pi.getFormu().makeHtmlInsertTabIndex();
                    pi.getFormufle().makeHtmlInsertTableauIndex();
                    out.println(pi.getFormu().getHtmlInsert());
                %>
                   <center style="margin-bottom: 10px;"> <a class="btn btn-success button-margin"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=<%= buteApresVisa %>&classe=<%= classeMere %>">Viser</a> </center>
                <div class="row">
                    <div class="col-md-12">
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
</div>
<script>
    document.getElementById("tierslibelle").value = "<%= mere.getTierslib() %>";
    <%for(int i=0; i<liste.length; i++){%>
        document.getElementById("idactivitelibelle_<%=i%>").value = "<%= liste[i].getActivitelib() != null ? liste[i].getActivitelib() : Utilitaire.champNull(liste[i].getIdactivite())%>";
        document.getElementById("rubriquelibelle_<%=i%>").value = "<%= liste[i].getRubriquelib() != null ? liste[i].getRubriquelib() : Utilitaire.champNull(liste[i].getRubrique())%>";
        document.getElementById("idproduitlibelle_<%=i%>").value = "<%=liste[i].getProduit_lib() != null ? liste[i].getProduit_lib() : Utilitaire.champNull(liste[i].getIdproduit()) %>";
    
    <%}%>
    document.getElementById("idprevisionlibelle").value = '<%=Utilitaire.champNull(mere.getEscale())%>';
    
    var designation = document.getElementById("designation");
    var textarea = document.createElement("textarea");
        textarea.name="designation";
        textarea.id="designation";
        textarea.className="form-control";
        textarea.style.height="100px";
        textarea.value = designation.value;
    designation.parentNode.replaceChild(textarea , designation);
</script>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>