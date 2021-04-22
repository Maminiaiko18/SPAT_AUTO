<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="configuration.*" %>
<%!
Directionregionale p;
%>
<%
p=new Directionregionale();
p.setNomTable("SIG_DR");
String [] libellePersonneFiche={"Id","Libelle","Decription","Abreviation", "Numero fixe","Numero mobile","Sigle"};
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
pc.setLibAffichage(libellePersonneFiche);
%>
<div class="content-wrapper">
	<div class="row">
		<div class="col-md-6">
                    <div class="box-fiche">
			<div class="box">
				<div class="box-title with-border">
					<h1 class="box-title"><a href="<%=(String)session.getValue("lien")%>?but=configuration/directionregionale-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a> Fiche direction regionale</h1>
				</div>
				<div class="box-body">
					<%
					out.println(pc.getHtml());
					%>
					<br/>
					<div class="pull-right">
						<p>
							<a href="<%=(String)session.getValue("lien")+"?but=configuration/directionregionale-modif.jsp&id="+request.getParameter("id")%>"><button class="btn btn-warning">Modifier</button></a>
							<a href="<%=(String)session.getValue("lien")+"?but=apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=configuration/directionregionale-liste.jsp&classe=configuration.Directionregionale"><button class="btn btn-danger">Supprimer</button></a>
						</p>
					</div>
				</div>
			</div>
                    </div>
		</div>
	</div>
</div>
