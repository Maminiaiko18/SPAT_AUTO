
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="mg.spat.exploitant.Activite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
try{
    BonDeCommandeFille  p = new BonDeCommandeFille ();
    
    String nomTable = "AS_BC_ANALYSEFILLE_LIB";
    p.setNomTable(nomTable);
    String listeCrt[] = {"idbc","numbc","daty", "codelib", "projetlib", "produit", "fournisseurlib"};
    String listeInt[] = {"daty"};
    String[] pourcentage = {};
    String colDefaut[] = {"idbc","numbc", "daty", "codelib", "projetlib", "produit", "quantite", "unite", "pu", "montantht", "fournisseurlib"};
    String somDefaut[] = {};
        //PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,3,colDefaut,somDefaut,pourcentage,listeCrt.length,colDefaut.length);
    PageRechercheGroupe pr = new PageRechercheGroupe(p, request, listeCrt, listeInt, 3, colDefaut, somDefaut, null, 2 , 2);
    pr.setUtilisateur((user.UserEJB)session.getValue("u"));
    pr.setLien((String)session.getValue("lien"));
    pr.setApres("stock/bc/analyse-detailsBC.jsp");
    
        pr.getFormu().getChamp("idbc").setLibelle("IDBC");
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        pr.getFormu().getChamp("codelib").setLibelle("Code");
        pr.getFormu().getChamp("projetlib").setLibelle("Projet");
        pr.getFormu().getChamp("fournisseurlib").setLibelle("Fournisseur");
        pr.setApres("stock/bc/analyse-detailsBC.jsp");
        pr.creerObjetPage();
        
   
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
	<section class="content-header">
		<h1>Analyse details BC</h1>
	</section>
	<section class="content">
		<form action="<%=pr.getLien()%>?but=stock/bc/analyse-detailsBC.jsp" method="post" name="analyse" id="analyse">
			<%out.println(pr.getFormu().getHtmlEnsemble());%>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <div class="form-group">
                            </div>
                        </div>
                        <div class="col-md-4"></div>
		</form>
               

		<%
                String lienTableau[] = {pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
                String colonneLien[] = {"idbc"};
                String valcolonnelien[] = {"id"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setColonneLien(colonneLien);
                pr.getTableau().setUrlLien(colonneLien);
                pr.getTableau().setUrlLienAffiche(valcolonnelien);
		out.println(pr.getTableauRecap().getHtml());
                
                %>
                <br>
                 <div class="box-footer">
                    
        <a class="btn btn-success pull-right"  href="${pageContext.request.contextPath}/AnalyseDetailBCsExcel?action=AnalyseDetailBC&idbc=<%=request.getParameter("idbc") %>&numbc=<%=request.getParameter("numbc") %>&codelib=<%=request.getParameter("codelib") %>&projetlib=<%=request.getParameter("projetlib") %>&daty1=<%=request.getParameter("daty1") %>&daty2=<%=request.getParameter("daty2") %>&produit=<%=request.getParameter("produit") %>&fournisseurlib=<%=request.getParameter("fournisseurlib") %>" style="margin-right: 10px">Export excel</a>                            <!--<a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=facturegallois/client/facture-client-saisie.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Dupliquer modele</a>-->
       
</div>
		
		<%
                    String libEnteteAffiche[] = {"IDBC","NUMBC", "date", "code", "projet", "produit", "quantite", "unite", "pu", "montant HT", "fournisseur"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                    out.println(pr.getTableau().getHtml());
                    out.println(pr.getBasPage());
		%>
	</section>
</div>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>