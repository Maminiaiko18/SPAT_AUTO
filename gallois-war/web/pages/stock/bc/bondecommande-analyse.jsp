<%-- 
    Document   : bondecommande-analyse
    Created on : 14 avr. 2021, 09:37:16
    Author     : nyamp
--%>

<%@page import="mg.spat.stock.BonDeCommande"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>

<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        
         BonDeCommande bondecommande = new BonDeCommande();
         String etat="AS_BONDECOMMANDE_LIBELLE_lib";

        //PAR DEFAUT
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            etat = request.getParameter("etat");
        }
        bondecommande.setNomTable(etat);
        
        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);
        
        String listeCrt[] = {"id","daty","fournisseur","numbc","projet","code_etab"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {};
        String colDefaut[] = {"id","daty","fournisseur","numbc","projet","code_etab"};
        String somDefaut[] = {"montant","montanttva","montantttc","montant_paye_reel","restepayergeneral"};

        PageRechercheGroupe pr = new PageRechercheGroupe(bondecommande, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
        String awhere="";
        if(request.getParameter("daty1")==null){
            awhere+=String.format(" and daty>='%s'", Utilitaire.dateDuJour());
        }
        if(request.getParameter("daty2")==null){
            awhere+=String.format(" and daty<='%s'", Utilitaire.dateDuJour());
        }
        pr.setAWhere(awhere);
        pr.getFormu().getChamp("code_etab").setLibelle("Code etablissement");
        
        pr.getFormu().getChamp("numbc").setLibelle("Numero bon de commande");
     
        pr.setApres("stock/bc/bondecommande-analyse.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse bon de commande</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="<%=pr.getApres()%>" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (etat == null || etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_lib") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_lib" selected>tous</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_lib">tous</option>
                        <% } %>

                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_CREE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_CREE" selected>Créé</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_CREE">Créé</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_VISE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_VISE" selected>Visé</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_VISE">Visé</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_LIVRE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_LIVRE" selected>Livré </option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_LIVRE">Livré </option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_FACT") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_FACT" selected>Facturé</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_FACT">Facturé</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIB_ATTPAY") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIB_ATTPAY" selected>En attente de paiement</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIB_ATTPAY">En attente de paiement</option>
                        <% } %>
                        <% if (etat != null && etat.compareToIgnoreCase("AS_BONDECOMMANDE_LIBELLE_PAYE") == 0) {%>
                        <option value="AS_BONDECOMMANDE_LIBELLE_PAYE" selected>Payé</option>
                        <% } else { %>
                        <option value="AS_BONDECOMMANDE_LIBELLE_PAYE">Payé</option>
                        <% } %>


                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
          if(request.getParameter("colGroupe1")!=null){
                String tablink[] = {pr.getLien() + "?but=stock/bc/bondecommande-analyse.jsp"};
                String collink[] = {"montantttc"};
                pr.getTableau().setLien(tablink);
                pr.getTableau().setColonneLien(collink);
            }
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> 
	alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

