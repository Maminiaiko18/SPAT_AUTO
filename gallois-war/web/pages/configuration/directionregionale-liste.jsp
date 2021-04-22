<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.sig.*" %>
<%@ page import="configuration.*" %>
<%
Directionregionale p = new Directionregionale();
p.setNomTable("sig_dr");
String listeCrt[]={"val","desce","dr_abreviation", "numero_fixe","numero_mobile"};
String listeInt[]=null;
String libEntete[]={"id","val","desce","dr_abreviation", "numero_fixe","numero_mobile","dr_sigle"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,3,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("configuration/directionregionale-liste.jsp");
pr.getFormu().getChamp("val").setLibelle("Libelle");
pr.getFormu().getChamp("desce").setLibelle("Decription");
pr.getFormu().getChamp("dr_abreviation").setLibelle("Abreviation");
pr.getFormu().getChamp("numero_fixe").setLibelle("Numero fixe");
pr.getFormu().getChamp("numero_mobile").setLibelle("Numero mobile");

String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<div class="content-wrapper">
	<section class="content-header">
	<h1>Liste Direction Regionale</h1>
	</section>
	<section class="content">
		<form action="<%=pr.getLien()%>?but=configuration/directionregionale-liste.jsp" method="post" name="personneliste" id="personneliste">
			<% out.println(pr.getFormu().getHtmlEnsemble());%>
		</form>
		<%
		String lienTableau[]={pr.getLien()+"?but=configuration/directionregionale-fiche.jsp"};
		String colonneLien[]={"id"};
		String libelles[]={"Id","Libelle","Decription","Abreviation", "Numero fixe","Numero mobile","Sigle"};
		pr.getTableau().setLien(lienTableau);
		pr.getTableau().setColonneLien(colonneLien);
		pr.getTableau().setLibelleAffiche(libelles);
		out.println(pr.getTableauRecap().getHtml());
		
                out.println(pr.getTableau().getHtml());
                out.println(pr.getBasPage()); %>
	</section>
</div>
