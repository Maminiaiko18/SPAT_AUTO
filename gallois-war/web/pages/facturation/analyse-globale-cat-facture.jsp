<%-- 
    Document   : as-commande-analyse
    Created on : 30 d? 2016, 04:57:15
    Author     : Joe
--%>

<%@page import="mg.spat.FactureAnalyse"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>

<%
    try {
        FactureAnalyse mvt = new FactureAnalyse();
        String nomTable = "analyseglobalefacture";
        if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
            nomTable = request.getParameter("table");
        }
        mvt.setNomTable(nomTable);

        String listeCrt[] = {"nmfact", "categorie_facture", "sous_categorie_facture", "categorie_client", "daty", "client", "numCompte"};
        String libEntete[] = {"categorie_facture", "mttc", "mtht", "taxe", "mtdevise", "mtavoir", "paye", "reste"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {""};
        String colDefaut[] = {"categorie_facture"};
        String somDefaut[] = {"mttc", "mtht", "mtavoir", "paye", "reste"};

        PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 14, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        String apreswhere = "";
        /*if(request.getParameter("daty1") == null || request.getParameter("daty2") == null){
        apreswhere = "and daty = '"+utilitaire.Utilitaire.dateDuJour()+"'";
    }*/

        pr.setAWhere(apreswhere);
        /* pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());*/

        pr.getFormu().getChamp("categorie_client").setLibelle("Categorie client");
        pr.setApres("facturation/analyse-globale.jsp");
        
        pr.creerObjetPage();
//        System.out.println("pr.getRs().getResultat().getClass() = " + pr.getRs().getResultat().getClass());
        FactureAnalyse[] factures = (FactureAnalyse[]) pr.getRs().getResultat();
        double[][] cumul = PageRechercheGroupe.cumul(pr.getRs(), somDefaut);
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Catégorie facture</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="facturation/analyse-globale.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    table : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("vue_cmd_client_details_rest") == 0) {%>    
                        <option value="ANALYSEGLOBALEFACTURE" selected>Tous</option>
                        <% } else { %>
                        <option value="ANALYSEGLOBALEFACTURE" >Tous</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("analysefactureConcessionnaire") == 0) {%>    
                        <option value="analysefactureConcessionnaire" selected>Concessionnaire</option>
                        <% } else { %>
                        <option value="analysefactureConcessionnaire" >Concessionnaire</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("analysefactureconventionnel") == 0) {%>
                        <option value="analysefactureconventionnel" selected>Conventionnel</option>
                        <% }
                            { %>
                        <option value="analysefactureconventionnel" >Conventionnel</option>
                        <% }%>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facturation/analyse-globale-liste.jsp",pr.getLien() + "?but=facturation/analyse-globale-liste.jsp",pr.getLien() + "?but=facturation/analyse-globale-liste.jsp",pr.getLien() + "?but=facturation/analyse-globale-liste.jsp",pr.getLien() + "?but=facturation/analyse-globale-liste.jsp"};
            //String colonneLien[] = {"gain"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(somDefaut);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="table table-hover table-bordered">
            <thead>
                <tr class="head">
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Categorie client</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Montant TTC</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Cumul Montant TTC</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Montant HT</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Cumul Montant HT</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Montant Avoir</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Cumul Montant Avoir</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Paye</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Cumul Paye</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Reste</p></th>
                    <th align="center" valign="top" style="background-color:#103a8e" ><p style="color:white;">Cumul Reste</p></th>
                </tr>
            </thead>
            <tbody>
                <% for(int i=0; i<factures.length; i++) { %>
                <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''" style="">
                    <td align="left"><%=factures[i].getCategorie_facture()%></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(factures[i].getMttc()+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(cumul[i][0]+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(factures[i].getMtht()+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(cumul[i][1]+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(factures[i].getMtavoir()+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(cumul[i][2]+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(factures[i].getPaye()+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(cumul[i][3]+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(factures[i].getReste()+""))%></a></td>
                    <td align="right"><a href="<%=pr.getLien() + "?but=facturation/detail-analyse-globale.jsp&categorie_client="+factures[i].getCategorie_facture()%>"><%=Utilitaire.formaterAr(Utilitaire.champNull(cumul[i][4]+""))%></a></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            String libEnteteAffiche[] ={"N° Facture", "Catégorie facture", "Sous catégorie facture", "Client", "Catégorie client", "Désignation", "devfact", "N° de Compte", "Date","Montant TTC", "Montant HT", "Montant avoir", "Paye", "Reste"};
//            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
//            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>