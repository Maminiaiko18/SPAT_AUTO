<%--
    Document   : emploidutemp-saisie
    Created on : 25 janv. 2016, 10:57:05
    Author     : Tafitasoa
--%>

<%@page import="mg.cnaps.formation.FormEmploiTemp"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%!
    UserEJB u = null;
    String lien = "";
%>
<%
    u = (UserEJB) session.getAttribute("u");
    lien = (String) session.getValue("lien");

%>
<div class="content-wrapper" style="min-height: 946px;">
    <div class="row">
	<section class="content-header">
	    <h1><a href="<%=(String) session.getValue("lien")%>?but=formation/formation-fiche.jsp&id=<%=request.getParameter("id")%>"><i class="fa fa-arrow-circle-left"></i></a>Créer Emploi du temps formation</h1>
	</section>
	<section class="content">
	    <form class="form-inline" action="<%=lien%>?but=apresTarif.jsp" method="post" data-parsley-validate>
		<div class="row">
		    <div class="col-md-12">
			<div class="box box-primary">

			    <div class="box-body">
                                <table class="table table-bordered table-condensed">
				    <thead>
					<tr>
					    <th style="text-align: center">Date</th>
					    <th style="text-align: center">Heure debut / Heure fin</th>
					    <th style="text-align: center">Matières</th>
					    <th style="text-align: center">Trajet en minutes</th>
					    <th style="text-align: center">Remarque</th>
					</tr>
				    </thead>
				    <tbody id="ajout_ligne">
					<tr>
					    <td><input type="text" class="form-control datepicker heure_minute_normal_input" id="heure_minute_normal_input_daty_emploi" name="date_formation"></td>
					    <td>
                                                <input style="text-align: center" type="text" class="form-control heure_minute_normal_input" id="heure_minute_normal_input_heure_deb" name="heure_debut">  
                                                /
                                                <input style="text-align: center" type="text" class="form-control heure_minute_normal_input" id="heure_minute_normal_input_heure_fin" name="heure_fin">  
                                                <!--<input value="test" type="hidden" class="form-control heure_minute_normal_input" id="heure_minute_normal_input_heure_fin" name="heure_fin">-->
                                            </td>
					    <td><input type="text" class="form-control" id="matiere" name="matiere"></td>
					    <td><input type="text" class="form-control" id="trajet" name="duree_trajet"></td>
					    <td><input type="text" class="form-control" id="remarque" name="remarque"></td>
					    <td><input type="hidden" value="0" class="form-control" id="duree_hdeb" name="duree_hdeb"></td>
					    <td><input type="hidden" value="0" class="form-control" id="duree_hfin" name="duree_hfin"></td>
					</tr>
				    </tbody>
				</table>
			    </div>
			    <div class="box-footer">    
				<button type="submit" class="btn-sm btn-default pull-right">Enregistrer</button>
			    </div>
			    <input name="acte" type="hidden" value="insert">
			    <input name="bute" type="hidden" id="bute" value="formation/emploidutemp-saisie.jsp&id=<%=request.getParameter("id")%>&idpers=<%=request.getParameter("idpers")%>">
			    <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormEmploiTemp">
			    <input name="nomtable" type="hidden" id="nomtable" value="FORM_EMPLOI_TEMP">
			    <input type="hidden" id="idform" name="id_formation" value="<%=request.getParameter("id")%>">
			    <input type="hidden" id="idpers" name="id_personnel" value="<%=request.getParameter("idpers")%>">
			</div>
		    </div>
		</div>
	    </form>
	</section>
    </div>
    <%
	FormEmploiTemp emp = new FormEmploiTemp();
	emp.setId_formation(request.getParameter("id"));
	emp.setId_personnel(request.getParameter("idpers"));
	FormEmploiTemp[] lemp = (FormEmploiTemp[]) CGenUtil.rechercher(emp, null, null, " and id_formation='" + emp.getId_formation() + "' and id_personnel='" + emp.getId_personnel() + "'");
	if (lemp.length > 0) {
    %>
    <div class="row">
	<section class="content-header">
	    <h1>Emploi du temps</h1>
	</section>
	<section class="content">
	    <div class="col-md-12">
		<div class="box box-primary">
		    <div class="box-body">
			<table class="table table-bordered table-condensed">
			    <thead>
				<tr>
				    <th>Date</th>
				    <th>Heure debut / Fin</th>
				    <th>Matieres</th>
				    <th>Trajet en heure</th>
				    <th>Durée</th>
				    <th>Remarque</th>
				    <th></th>
				</tr>
			    </thead>
			    <tbody id="ajout_ligne">
				<% int totalRecup = 0; %>
				<% for (int i = 0; i < lemp.length; i++) {%>
				<tr>
				    <td><%= Utilitaire.formatterDaty(lemp[i].getDate_formation())%></td>
				    <td>
					<%=Utilitaire.champNull(lemp[i].getHeure_debut())%>/
					<%=Utilitaire.champNull(lemp[i].getHeure_fin())%>
				    </td>
				    <td><%=Utilitaire.champNull(lemp[i].getMatiere())%></td>
				    <td><%=Utilitaire.champNull(lemp[i].getDuree_trajet())%></td>
                                    <td><%= Utilitaire.transformFormatHeure(Utilitaire.secondesToTime(Utilitaire.diffDeuxheures(lemp[i].getHeure_debut(), lemp[i].getHeure_fin())))%></td>
				    <td><%= Utilitaire.champNull(lemp[i].getRemarque())%></td>
				    <td><a data-toggle="modal" data-target="#<%=lemp[i].getId()%>"><i data-toggle="tooltip" title="Modifier"  class="fa fa-fw fa-edit"></i></a><a href="<%=lien%>?but=apresTarifFormation.jsp&acte=delete&idformation=<%=request.getParameter("id")%>&idpers=<%=request.getParameter("idpers")%>&id=<%=lemp[i].getId()%>&classe=mg.cnaps.formation.FormEmploiTemp&nomtable=FORM_EMPLOI_TEMP&bute=formation/emploidutemp-saisie.jsp"><i data-toggle="tooltip" title="Supprimer" class="fa fa-fw fa-close"></i></a></td>
				</tr>
				<% totalRecup += Utilitaire.diffDeuxheures(lemp[i].getHeure_debut(), lemp[i].getHeure_fin()); %>
				<% }%>
			    </tbody>
			    <tfoot>
				<tr>
				    <td colspan="4" style="text-align:center"><b>TOTAL HEURE RECUPERATION</b></td>
				    <td><%= Utilitaire.transformFormatHeure(Utilitaire.secondesToTime(totalRecup))%></td>
				</tr>
			    </tfoot>
			</table>
		    </div>
		</div>
	    </div>
	</section>
    </div>
    <% for (int i = 0; i < lemp.length; i++) {%>
    <div class="modal fade" id="<%= lemp[i].getId()%>" tabindex="-1" role="dialog" aria-labelledby="Modifier Emplois du temp">
	<div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
		<div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    <h4 class="modal-title" id="myModalLabel">Modifier Emplois du temps</h4>
		</div>
		<form method="post" action="<%=lien%>?but=apresTarif.jsp" data-parsley-validate>
		    <div class="modal-body">
			<input name="acte" type="hidden" value="update">
			<input name="bute" type="hidden" id="bute" value="formation/emploidutemp-saisie.jsp&id=<%=request.getParameter("id")%>&idpers=<%=request.getParameter("idpers")%>">
			<input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormEmploiTemp">
			<input name="nomtable" type="hidden" id="nomtable" value="FORM_EMPLOI_TEMP">
			<input type="hidden" id="idform" name="id_formation" value="<%=request.getParameter("id")%>">
			<input type="hidden" id="idpers" name="id_personnel" value="<%=request.getParameter("idpers")%>">
			<input type="hidden" name="id" value="<%=lemp[i].getId()%>">
			<table class="table table-bordered table-condensed">
			    <thead>
				<tr>
				    <th>Date</th>
				    <th>Heure debut / Fin</th>
				    <th>Matières</th>
				    <th>Trajet en heure</th>
				    <th>Heures à récupérer</th>
				    <th>Remarque</th>
				</tr>
			    </thead>
			    <tbody id="ajout_ligne">
				<tr>
				    <td><input value="<%= Utilitaire.formatterDaty(lemp[i].getDate_formation())%>" type="text" class="form-control datepicker heure_minute_normal_input" id="heure_minute_normal_input_daty_emploi" name="date_formation"></td>
				    <td>
					<input value="<%= Utilitaire.champNull(lemp[i].getHeure_debut())%>" type="text" class="form-control heure_minute_normal_input" id="heure_minute_normal_input_heure_deb" name="heure_debut">/
					<input value="<%= Utilitaire.champNull(lemp[i].getHeure_fin())%>" type="text" class="form-control heure_minute_normal_input" id="heure_minute_normal_input_heure_fin" name="heure_fin">
				    </td>
				    <td><input value="<%= Utilitaire.champNull(lemp[i].getMatiere())%>" type="text" class="form-control" id="matiere" name="matiere"></td>
				    <td><input value="<%= Utilitaire.champNull(lemp[i].getDuree_trajet())%>" type="text" class="form-control" id="trajet" name="duree_trajet"></td>
				    <td><input value="<%= Utilitaire.diffDeuxheures(lemp[i].getHeure_debut(), lemp[i].getHeure_fin()) / 3600%>" type="text" readonly class="form-control" id="heure_minute_normal_input_total_heure"></td>
				    <td><input value="<%= Utilitaire.champNull(lemp[i].getRemarque())%>" type="text" class="form-control" id="remarque" name="remarque"></td>
				    <td><input type="hidden" value="0" class="form-control" id="duree_hdeb" name="duree_hdeb"></td>
				    <td><input type="hidden" value="0" class="form-control" id="duree_hfin" name="duree_hfin"></td>
				</tr>
			    </tbody>
			</table>
		    </div>
		    <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
			<input type="submit" class="btn btn-primary" value="Modifier"/>
		    </div>
		</form>
	    </div>
	</div>
    </div>
    <% } %>
    <% }%>

</div>
<script type="text/javascript">
    var numligne = 11;

    function inputNbrLigne() {
	document.getElementById("nbrLigne").value = numligne - 1;
    }


    //debut fonction test numerique
    function isNumerique(str) {
	if (typeof (str) == "undefinied" || typeof (str) == "")
	    return "";
	for (i = 0; i < str.length; i++) {
	    c = str.charAt(i);
	    if ((c < "0") || (c > "9"))
		return false;
	}
	return true;
    }

    function testnum(obj) {
	var val = obj.value;
	if (!isNumerique(val)) {
	    var str = "";
	    for (i = 0; i < val.length - 1; i++) {
		c = val.charAt(i);
		str += c;
	    }
	    obj.value = str;
	    obj.focus();
	}
    }
    function diffHeure(date, heure_debut, heure_fin)
    {
	if ((date === undefined || date.length == 0) || (heure_debut === undefined || heure_debut.length == 0) || (heure_fin === undefined || heure_fin.length == 0))
	{
	    return 0;
	} else {
	    var splitDate = date.split("/");
            var splitheure = heure_debut.split("/");
	    var splitHeureDebut = splitheure[0].split(":");
	    var splitHeureFin = splitheure[1].split(":");

	    if (splitHeureDebut.length > 2 || splitHeureFin.length > 2)
	    {
		alert("Format Heure/Minute invalide");
		return;
	    }
	    for (var i = 0; i < 2; i++)
	    {
                
		if (splitHeureDebut[i].length > 2 || splitHeureFin[i].length > 2)
		{
		    alert("Format Heure/Minute invalide 2");
		    return;
		}
	    }
	    var dateDebut = new Date(splitDate[2], splitDate[1] - 1, splitDate[0], splitHeureDebut[0], splitHeureDebut[1]);
	    var dateFin = new Date(splitDate[2], splitDate[1] - 1, splitDate[0], splitHeureFin[0], splitHeureFin[1]);
	    var diff = new Date(dateFin.getTime() - dateDebut.getTime());
	    return (diff.getUTCHours() + (diff.getUTCMinutes() / 60));
	}
    }
    function calculerHeureRecup(idDebutMatin, idFinMatin, idDate)
    {
	var listeValeurArguments = [];
	for (var i = 0; i < 4; i++) {
	    listeValeurArguments[arguments[i]] = $("#" + arguments[i]).val();
	}
	var date = $("#" + idDate).val();
	var totalHeureMatin = diffHeure(date, listeValeurArguments[idDebutMatin], listeValeurArguments[idFinMatin]);
	return totalHeureMatin;
    }
    function afficherTotalHeureRecup(prefixe)
    {
	var totalHeureRecup = calculerHeureRecup(prefixe + "_heure_deb", prefixe + "_heure_fin", prefixe + "_daty_emploi");
	$("#" + prefixe + "_total_heure").val(totalHeureRecup);
    }
    $('body').delegate('.heure_minute_normal_input', 'blur', function () {
	//afficherTotalHeureRecup("heure_minute_normal_input");
	return false;
    });
</script>
