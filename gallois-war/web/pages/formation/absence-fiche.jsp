<%-- 
    Document   : absence-fiche
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>

<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.formation.*" %>
<%!
     FormAbsence absence;
%>
<%

    absence = new FormAbsence();
	absence.setNomTable("form_absence_libelle");
    PageConsulte pc = new PageConsulte(absence, request, (user.UserEJB) session.getValue("u"));
//	pc.getChampByName("id_formation").setLien(new PageConsulteLien((String) session.getValue("lien") + "?but=formation/formation-fiche.jsp" ,  "id=" + request.getParameter("id")));
	pc.getChampByName("id_formation").setAutre(" id=id_formation");
	String []libelleFormationFiche = {"Id", "Formation", "Personnel", "Date", "Motif", "Remarque"};
	pc.setLibAffichage(libelleFormationFiche);

	
	pc.setTitre("Fiche absence formation");
    
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=formation/absence-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                    <div class="box-footer">                        
						<a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/absence-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
						<a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=formation/absence-liste.jsp&classe=mg.cnaps.formation.FormAbsence" style="margin-right: 10px">Supprimer</a>                        
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%out.println(pc.getBasPage());
	
		String idFormation = pc.getChampByName("id_formation").getValeur();

	
	%>
</div>

<script>
$(document).ready(initialiserLien ());


function initialiserLien()
{
	<% String id = request.getParameter("id");%>
	var lienFormation = '<a href="<%=(String) session.getValue("lien")%>?but=formation/formation-fiche.jsp&id=<%=idFormation%>"> <%=idFormation%></a>';
	var listEleFormation = $('td');
	//module.jsp?but=formation/formation-fiche.jsp?id=FABS000012
	//eleFormation.html(eleFormation);
	var eleFormation = listEleFormation.get(3);
	eleFormation.innerHTML = lienFormation;
}




</script>