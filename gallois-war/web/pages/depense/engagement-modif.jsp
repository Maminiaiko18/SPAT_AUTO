<%-- 
    Document   : asBonDeCommande-modif
    Created on : 8 d�c. 2020, 09:28:55
    Author     : Sanda
--%>
<%@page import="mg.spat.EngagementFille"%>
<%@page import="affichage.PageUpdateMultiple"%>
<%@page import="mg.spat.Engagement"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="affichage.Liste" %>

<%
    try {
        String classeMere = "mg.spat.Engagement",
               classeFille = "mg.spat.EngagementFille",
                colonneMereDansFille = "idmere";
        
        Engagement mere = new Engagement();
        mere.setNomTable("engagementlib");

        EngagementFille fille = new EngagementFille();
        fille.setNomTable("ENGAGEMENT_FILLELIB");
        fille.setIdmere(request.getParameter("id"));
        EngagementFille[] liste = (EngagementFille[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("projetlib").setVisible(false);
        pi.getFormu().getChamp("codeetablissementlib").setVisible(false);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idLClib").setVisible(false);
        pi.getFormu().getChamp("compte").setVisible(false);
        
        //Liste[] listes = new Liste[1];
        //String[] avecFactureAff = {"oui", "non"};
        //String[] avecFactureVal = {"1", "0"}; 
        //listes[0] = new Liste("avecFacture", avecFactureAff, avecFactureVal);
    
        //pi.getFormu().changerEnChamp(listes);
        
//        pi.getFormu().getChamp("annee").setLibelle("Annee") ; 
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("codeetablissement").setLibelle("Code &eacute;tablissement");
        pi.getFormu().getChamp("projet").setLibelle("Projet");
        pi.getFormu().getChamp("montant").setLibelle("Montant");
        pi.getFormu().getChamp("disponible").setVisible(false);
        pi.getFormu().getChamp("dispoavant").setVisible(false);
        pi.getFormu().getChamp("dispoapres").setVisible(false);
        pi.getFormu().getChamp("montantop").setVisible(false);
        pi.getFormu().getChamp("tierslib").setVisible(false);
        pi.getFormu().getChamp("idLC").setLibelle("Budget");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("AvecFacturelib").setVisible(false);
        pi.getFormu().getChamp("AvecFacture").setVisible(false);
        pi.getFormu().getChamp("num").setVisible(false);
        pi.getFormu().getChamp("montantreste").setVisible(false);
        pi.getFormu().getChamp("annee").setLibelle("Ann&eacute;e");


        pi.getFormu().getChamp("projet").setAutre("readonly");
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp", "projet;projetlibelle");

        pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
        pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp", "codeEtablissement;codeEtablissementlibelle");

        pi.getFormu().getChamp("idLC").setAutre("readonly");
        pi.getFormu().getChamp("idLC").setPageAppel("choix/listeBudgetDepenseChoix.jsp", "idLC;idLClibelle;idLClibelle;idLClibelle");

        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp", "tiers;tierslibelle");
        pi.getFormu().getChamp("duree").setVisible(false);
        pi.getFormu().getChamp("chantier").setVisible(false);

        
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("estpaye"), false);
        
        pi.getFormufle().getChamp("Id_0").setLibelle("Id");
        pi.getFormufle().getChamp("designation_0").setLibelle("D&eacute;signation");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
        
        Liste[] listes = new Liste[1];
        TypeObjet catAchat = new TypeObjet();
        catAchat.setNomTable("typeengagement");
        listes[0] = new Liste("idtype", catAchat, "val", "id");
        pi.getFormu().changerEnChamp(listes);
          
        pi.getFormu().getChamp("idtype").setLibelle("Type");
        pi.getFormu().getChamp("idtypelib").setVisible(false);
        pi.getFormu().getChamp("idavenant").setVisible(false);

        pi.preparerDataFormu();
        mere = (Engagement) pi.getBase();
%>

<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-8 col-md-offset-2">
            <div class="box">
                <h1>Modification engagement</h1>
                <form action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="engagement" id="engagement" data-parsley-validate>
                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        pi.getFormufle().makeHtmlInsertTableauIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <div class="row">
                        <div class="col-md-12">
                            <%
                                out.println(pi.getFormufle().getHtmlTableauInsert());
                            %>
                        </div>
                        <br><br> 
                    </div>

                    <input name="acte" type="hidden" id="nature" value="updateInsert">
                    <input name="bute" type="hidden" id="bute" value="depense/engagement-fiche.jsp">
                    <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                    <input name="classefille" type="hidden" id="classefille" value="<%= classeFille%>">
                    <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                    <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMereDansFille%>">
                </form>
            </div>
        </div>
    </div>
</div>                    
<script>
    $('#projetlibelle').val('<%= Utilitaire.champNull(mere.getProjetlib())%>');
    $('#codeEtablissementlibelle').val('<%= Utilitaire.champNull(mere.getCodeEtablissementlib())%>');
    $('#idLClibelle').val('<%= Utilitaire.champNull(mere.getIdLClib())%>');
    $('#tierslibelle').val('<%= Utilitaire.champNull(mere.getTierslib())%>');
    $('label[for="id"]').html('');
</script>
<% } catch (Exception ex) {
        ex.printStackTrace();
    }%>