
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
try{
    facture.FactureClient p = new facture.FactureClient();
    
    String nomTable = "PROVISIONVISEENONFACTUREE";
    p.setNomTable(nomTable);
    String listeCrt[] = {"id","daty","tierslib","designation","date_echeance","escale","categorielib"};
    String listeInt[] = {"daty","date_echeance"};
    String[] pourcentage = {"nombrepargroupe"};
    String colDefaut[]={"id","daty","tierslib","escale","designation","categorielib","tva","date_echeance"};
    String somDefaut[]={"montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    //PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,3,colDefaut,somDefaut,pourcentage,listeCrt.length,colDefaut.length);
    PageRechercheGroupe pr = new PageRechercheGroupe(p, request, listeCrt, listeInt, 3, colDefaut, somDefaut, null, 2 , 2);
    pr.setUtilisateur((user.UserEJB)session.getValue("u"));
    pr.setLien((String)session.getValue("lien"));
    pr.setApres("facture/provision-analyse.jsp");
    
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("tierslib").setLibelle("Client");
        pr.getFormu().getChamp("categorielib").setLibelle("Catégorie");
        Date firstDate = Utilitaire.dateDuJourSql();   
        firstDate.setDate(1);        
        Date lastDate = Utilitaire.getLastDayOfDateSQL(firstDate);
        
        String debutDate = Utilitaire.stringToDateJ("dd/MM/yyyy", firstDate);
        String dateFin = Utilitaire.stringToDateJ("dd/MM/yyyy", lastDate);
        
        if(request.getParameter("daty1") == null && request.getParameter("daty2") == null){
            pr.getFormu().getChamp("daty1").setDefaut(debutDate);
            pr.getFormu().getChamp("daty2").setDefaut(dateFin);
            
        }
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
                
    pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
	<section class="content-header">
		<h1>Analyse</h1>
	</section>
	<section class="content">
		<form action="<%=pr.getLien()%>?but=facture/provision-analyse.jsp" method="post" name="analyse" id="analyse">
			<%out.println(pr.getFormu().getHtmlEnsemble());%>
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <div class="form-group">
                            </div>
                        </div>
                        <div class="col-md-4"></div>
		</form>
		<%
		/*String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche-vaovao.jsp", pr.getLien() + "?but=capitainerie/quais/quais-prevision-fiche.jsp"};
                String colonneLien[] = {"id", "escale"};
                String varColonneLien[]={"id","id"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setVariableLien(varColonneLien);
                pr.getTableau().setColonneLien(colonneLien);*/
		out.println(pr.getTableauRecap().getHtml());%>
		<br>
		<%
                    out.println(pr.getTableau().getHtml());
                    out.println(pr.getBasPage());
		%>
	</section>
</div>
<%}catch(Exception ex){
    ex.printStackTrace();
}%>