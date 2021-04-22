<%-- 
    Document   : ordonnerpayement-analyse
    Created on : 14 avr. 2021, 14:59:02
    Author     : nyamp
--%>

<%@page import="ded.OrdonnerPayement"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>

<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {

        OrdonnerPayement op = new OrdonnerPayement();
        op.setNomTable("ETATORDONNERPAYEMENT");
        
        if(request.getParameter("etatvue")!=null && request.getParameter("etatvue").length()>0){
            op.setNomTable(request.getParameter("etatvue"));
        }

        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);
        String listeCrt[] = {"id","ded_Id","tiers","daty"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {};
        String colDefaut[] = {"id","daty","ded_Id","tiers","remarque"};
        String somDefaut[] = {"montant","montantpaye","reste"};

        PageRechercheGroupe pr = new PageRechercheGroupe(op, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length,1);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("ded_Id").setLibelle("facture");
        pr.getFormu().getChamp("daty1").setLibelle("date de début");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.setApres("ded/ordonnerpayement-analyse.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Ordre de payer</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="<%=pr.getApres()%>" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div> <div class="col-md-4">
                <div class="form-group">
                    <label>Etat : </label>
                    <select name="etatvue" class="champ form-control" id="etatvue" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="ETATORDONNERPAYEMENT" <% if (request.getParameter("etatvue") == null || request.getParameter("etatvue").compareToIgnoreCase("") == 0 || request.getParameter("etatvue").compareToIgnoreCase("ETATORDONNERPAYEMENT")==0) {
                                out.print(" selected");
                            }%>>Tous</option>
                        <option value="ETATORDONNERPAYEMENT_creer" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("ETATORDONNERPAYEMENT_creer") == 0) {
                                out.print("selected");
                            }%>>Cr&eacute;e(s)</option>
                        <option value="ETATORDONNERPAYEMENT_N_PAY" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("ETATORDONNERPAYEMENT_N_PAY") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;(s) en attente de paiement</option>
                        <option value="ETATORDONNERPAYEMENT_paye_lib" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("ETATORDONNERPAYEMENT_paye_lib") == 0) {
                                out.print("selected");
                            }%>>Vis&eacute;(s) et pay&eacute;(s)</option>
                        <option value="ETATORDONNERPAYEMENT_annule" <%if (request.getParameter("etatvue") != null && request.getParameter("etatvue").compareToIgnoreCase("ETATORDONNERPAYEMENT_annule") == 0) {
                                out.print("selected");
                            }%>>Annul&eacute;</option>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ded/ordonnerpayement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            if(request.getParameter("colGroupe1")!=null){
                String tablink[] = {pr.getLien() + "?but=ded/ordonnerpayement-analyse.jsp"};
                String collink[] = {"montant"};
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

