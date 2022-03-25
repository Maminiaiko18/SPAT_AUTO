<%-- 
    Document   : asBonDeCommande-modif
    Created on : 8 déc. 2020, 09:28:55
    Author     : Sanda
--%>
<%@page import="mg.spat.DemandeAchatFille"%>
<%@page import="mg.spat.DemandeAchatMere"%>
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
        String classeMere = DemandeAchatMere.class.getName(),
               classeFille = DemandeAchatFille.class.getName(),
                colonneMereDansFille = "idmere";
        String js = "";
        String id = request.getParameter("id");
        DemandeAchatMere mere = new DemandeAchatMere();
        mere.setNomTable("dem_achat_merelib");
                
        DemandeAchatFille fille = new DemandeAchatFille();
        fille.setNomTable("dem_achat_fillelib");
        fille.setIdmere(id);
        DemandeAchatFille[] liste = (DemandeAchatFille[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, liste, request, (user.UserEJB) session.getValue("u"), 2);
        pi.setLien((String) session.getValue("lien"));
        
        pi.getFormu().getChamp("codeetablissement").setLibelle("Code établissement");
        pi.getFormu().getChamp("projet").setLibelle("Projet");
        pi.getFormu().getChamp("idengagement").setLibelle("Engagement");
        pi.getFormu().getChamp("designation").setLibelle("Désignation");
        pi.getFormu().getChamp("num").setLibelle("Numéro");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("codeetablissementlib").setVisible(false);
        pi.getFormu().getChamp("projetlib").setVisible(false);
        pi.getFormu().getChamp("idengagementlib").setVisible(false);
        
        pi.getFormu().getChamp("codeetablissement").setPageAppel("choix/listeCodeEtablissementChoix.jsp");
        pi.getFormu().getChamp("codeetablissement").setAutre("readonly");
        
        pi.getFormu().getChamp("projet").setPageAppel("choix/listeProjetChoix.jsp");
        pi.getFormu().getChamp("projet").setAutre("readonly");
        
        pi.getFormu().getChamp("idengagement").setPageAppel("choix/listeEngagementChoix.jsp");
        pi.getFormu().getChamp("idengagement").setAutre("readonly");
        
        
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("id"), "readonly");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idmere"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("produitlib"), false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("unitelib"), false);
        
        Liste[] listef = new Liste[1];
        TypeObjet baseUnite = new TypeObjet();
        baseUnite.setNomTable("UNITECHANTIER");
        listef[0] = new Liste("unite", baseUnite, "val", "id");
        pi.getFormufle().changerEnChamp(listef);
        
        pi.getFormufle().getChamp("id_0").setLibelle("Id");
        pi.getFormufle().getChamp("produit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("designation_0").setLibelle("Désignation");
        pi.getFormufle().getChamp("unite_0").setLibelle("Unité");
        pi.getFormufle().getChamp("qte_0").setLibelle("Qté");
        pi.getFormufle().getChamp("pu_0").setLibelle("PU");
        
        affichage.Champ.setPageAppel(pi.getFormufle().getChampFille("produit"), "choix/produitChoix.jsp", "produit;produitlibelle;produitlibelle;produitlibelle;produitlibelle;designation");
        affichage.Champ.setAutre(pi.getFormufle().getChampFille("produit"), "readonly");
        /*
        int taille = pi.getNombreLigne();
        for( int i = 0 ; i < taille ; i++ ){       
            pi.getFormufle().getChamp("produit_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("produit_"+i).setPageAppel("choix/produitChoix.jsp", "produit_"+i+";produitlibelle_"+i+";produitlibelle_"+i+";produitlibelle_"+i+";produitlibelle_"+i+";designation_"+i);
            if(i < liste.length){
                js += "$('#produitlibelle_"+i+"').val('"+Utilitaire.champNull(liste[i].getProduitlib())+"')";
            }
        }
        */
        pi.preparerDataFormu();
        mere = (DemandeAchatMere) pi.getBase();
%>      

<div class="content-wrapper">
    <div class="row"> 
        <div class="col-md-8 col-md-offset-2">
            <div class="box">
                <h1>Modification d'une demande d'achat</h1>
                <form action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%= id %>" method="post" name="demandeAchat" id="demandeAchat" data-parsley-validate>
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
                    <input name="bute" type="hidden" id="bute" value="depense/demande-achat-fiche.jsp">
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
    $('#codeetablissementlibelle').val('<%= Utilitaire.champNull(mere.getCodeetablissementlib()) %>');
    $('#projetlibelle').val('<%= Utilitaire.champNull(mere.getProjetlib()) %>');
    $('#idengagementlibelle').val('<%= Utilitaire.champNull(mere.getIdengagementlib()) %>');
    <% for( int i = 0 ; i < liste.length ; i++ ){  %>     
        $('#produitlibelle_<%= i %>').val('<%= Utilitaire.champNull(liste[i].getProduitlib()) %>');
    <% } %>
    $('label[for="id"]').html('');
</script>
<% } catch (Exception ex) {
        ex.printStackTrace();
    }%>