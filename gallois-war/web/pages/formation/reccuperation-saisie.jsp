
<%@page import="mg.cnaps.formation.FormReccuperation"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.formation.FormEmploiTemp"%>
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
    String idFormation = request.getParameter("id");
    String idPersonnel = request.getParameter("idpers");
    FormReccuperation[] listeRecup = (FormReccuperation[]) CGenUtil.rechercher(new FormReccuperation(), null, null, " and id_formation='" + idFormation + "' and id_personnel='" + idPersonnel + "'");
    int totalARecupere = 0;
    int totalRecupere = 0;
%>
<div class="content-wrapper" style="min-height: 946px;">
    <div class="row">
        <section class="content-header">
            <h1><a href="<%=(String) session.getValue("lien")%>?but=paie/formation/formation-fiche.jsp&id=<%=request.getParameter("id")%>"><i class="fa fa-arrow-circle-left"></i></a>Récuperation</h1>
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
                                            <th>Date</th>
                                            <th>Heure debut / Fin (Matin)</th>
                                            <th>Heure debut / Fin (Apres Midi)</th>
                                            <th>Remarque</th>
                                        </tr>
                                    </thead>
                                    <tbody id="ajout_ligne">
                                        <tr>
                                            <td><input type="text" class="form-control datepicker heure_minute_normal_input" id="heure_minute_normal_input_daty_emploi" name="date_reccup"></td>
                                            <td>
                                                <input class="form-control heure_minute_normal_input" type="text" id="heure_minute_normal_input_heure_deb_am" name="heure_debut_am"> / 
                                                <input class="form-control heure_minute_normal_input" type="text" id="heure_minute_normal_input_heure_fin_am" name="heure_fin_am">
                                            </td>
                                            <td>
                                                <input class="form-control heure_minute_normal_input" type="text" id="heure_minute_normal_input_heure_deb_pm" name="heure_debut_pm"> / 
                                                <input class="form-control heure_minute_normal_input" type="text" id="heure_minute_normal_input_heure_fin_pm" name="heure_fin_pm">
                                            </td>
                                            <td><input class="form-control" type="text" id="heure_minute_normal_remarque" name="remarque" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="box-footer">
                                <button type="submit" class="btn-sm btn-default pull-right">Enregistrer</button>
                            </div>
                            <input name="id_formation" type="hidden" value="<%=request.getParameter("id")%>" />
                            <input name="id_personnel" type="hidden" value="<%=request.getParameter("idpers")%>" />
                            <input name="acte" type="hidden" value="insert">
                            <input name="bute" type="hidden" id="bute" value="paie/formation/reccuperation-saisie.jsp&id=<%=request.getParameter("id")%>&idpers=<%=request.getParameter("idpers")%>">
                            <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormReccuperation">
                            <input name="nomtable" type="hidden" id="nomtable" value="FORM_RECCUPERATION">
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

                                   
				</tr>
				<% totalRecup += Utilitaire.diffDeuxheures(lemp[i].getHeure_debut(), lemp[i].getHeure_fin()); %>
				<% }%>
			    </tbody>
			    <tfoot>
				<tr>
				    <td colspan="4" style="text-align:center"><b>TOTAL HEURE RECUPERATION</b></td>
				    <td><%= Utilitaire.transformFormatHeure(Utilitaire.secondesToTime(totalRecup))%></td>
                                    <% totalARecupere = totalRecup;%>
				</tr>
			    </tfoot>
			</table>
		    </div>
		</div>
	    </div>
	</section>
    </div>
    <% }%>
    <div class="row">
        <section class="content-header">
            <h1>Planning de récupération</h1>
        </section>
        <section class="content">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-body">
                        <table class="table table-bordered table-condensed table-hover">
                            <thead>
                                <tr>  <th>ID</th>
                                    <th>Date</th>
                                    <th>Heure debut / Fin (Matin)</th>
                                    <th>Heure debut / Fin (Apres Midi)</th>
                                    <th>Total</th>

                                    <th>Remarque</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int totalRecup = 0; %>
                                <% for (int i = 0; i < listeRecup.length; i++) {%>
                                <tr>
                                    <td><a href="<%=(String) session.getValue("lien")%>?but=paie/formation/recuperation-fiche.jsp&id=<%=listeRecup[i].getId()%>"><%=  listeRecup[i].getId()%></a></td>
                                    <td><%= Utilitaire.formatterDaty(listeRecup[i].getDate_reccup())%></td>
                                    <td><%= Utilitaire.champNull(listeRecup[i].getHeure_debut_am())%>/<%= Utilitaire.champNull(listeRecup[i].getHeure_fin_am())%></td>
                                    <td><%= Utilitaire.champNull(listeRecup[i].getHeure_debut_pm())%>/<%= Utilitaire.champNull(listeRecup[i].getHeure_fin_pm())%></td>
                                    <td>
                                        <% 
                                            int heure=0;
                                            heure+=listeRecup[i].getHeure_fin_am()!=null && !listeRecup[i].getHeure_fin_am().equalsIgnoreCase("")?Utilitaire.diffDeuxheures(listeRecup[i].getHeure_debut_am(), listeRecup[i].getHeure_fin_am()):0;
                                            heure+=listeRecup[i].getHeure_fin_pm()!=null && !listeRecup[i].getHeure_fin_pm().equalsIgnoreCase("")?Utilitaire.diffDeuxheures(listeRecup[i].getHeure_debut_pm(), listeRecup[i].getHeure_fin_pm()):0;
                                            out.print(Utilitaire.transformFormatHeure(Utilitaire.secondesToTime(heure)));
                                        %>
                                    </td>

                                    <td><%= Utilitaire.champNull(listeRecup[i].getRemarque())%></td>
                                    <td><a data-toggle="modal" data-target="#<%=listeRecup[i].getId()%>"><i data-toggle="tooltip" title="Modifier"  class="fa fa-fw fa-edit"></i></a><a href="<%=lien%>?but=apresTarifFormation.jsp&acte=delete&idformation=<%=request.getParameter("id")%>&idpers=<%=request.getParameter("idpers")%>&id=<%=listeRecup[i].getId()%>&classe=mg.cnaps.formation.FormReccuperation&nomtable=FORM_RECCUPERATION&bute=paie/formation/reccuperation-saisie.jsp"><i data-toggle="tooltip" title="Supprimer" class="fa fa-fw fa-close"></i></a></td>
                                </tr>
                                <% totalRecup += heure; %>
                                <% }%>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" style="text-align:center"><b>TOTAL HEURE RÉCUPÉRÉE</b></td>
                                    <td><b><%= Utilitaire.transformFormatHeure(Utilitaire.secondesToTime(totalRecup))%></b></td>
                                </tr>
                                <tr>
                                    <% 
                                        int total = totalARecupere-totalRecup;
                                        String libelle = total>0?"RESTE A RÉCUPÉRER":"SURPLUS D'HEURES DE RÉCUPÉRATION";
                                        total = total<0?(total*(-1)):total;
                                    %>
                                    <td colspan="4" style="text-align:center"><b><%=libelle%></b></td>
                                    <td><b><%= Utilitaire.transformFormatHeure(Utilitaire.secondesToTime(total))%></b></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <% for (int i = 0; i < listeRecup.length; i++) {%>
    <div class="modal fade" id="<%= listeRecup[i].getId()%>" tabindex="-1" role="dialog" aria-labelledby="Modifier Récupération">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Modifier Récupération</h4>
                </div>
                <form method="post" action="<%=lien%>?but=apresTarif.jsp" data-parsley-validate>
                    <div class="modal-body">
                        <input name="id" type="hidden" value="<%= listeRecup[i].getId()%>" />
                        <input name="id_formation" type="hidden" value="<%=request.getParameter("id")%>" />
                        <input name="id_personnel" type="hidden" value="<%=request.getParameter("idpers")%>" />
                        <input name="acte" type="hidden" value="update">
                        <input name="bute" type="hidden" id="bute" value="paie/formation/reccuperation-saisie.jsp&id=<%=request.getParameter("id")%>&idpers=<%=request.getParameter("idpers")%>">
                        <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormReccuperation">
                        <input name="nomtable" type="hidden" id="nomtable" value="FORM_RECCUPERATION">
                        <table class="table table-bordered table-condensed">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Heure debut / Fin (Matin)</th>
                                    <th>Heure debut / Fin (Après Midi)</th>
                                    <th>Total</th>
                                    <th>Remarque</th>
                                </tr>
                            </thead>
                            <tbody id="ajout_ligne">
                                <tr>
                                    <td><input type="text" class="form-control datepicker modal_input" id="modal_input_daty_emploi" value="<%= Utilitaire.formatterDaty(listeRecup[i].getDate_reccup())%>" name="date_reccup"></td>
                                    <td>
                                        <input class="form-control modal_input" type="text" id="modal_input_heure_deb_am" value="<%= Utilitaire.champNull(listeRecup[i].getHeure_debut_am())%>" name="heure_debut_am">
                                        <input class="form-control modal_input" type="text" id="modal_input_heure_fin_am" value="<%= Utilitaire.champNull(listeRecup[i].getHeure_fin_am())%>" name="heure_fin_am">
                                    </td>
                                    <td>
                                        <input class="form-control modal_input" type="text" id="modal_input_heure_deb_pm" value="<%= Utilitaire.champNull(listeRecup[i].getHeure_debut_pm())%>" name="heure_debut_pm">
                                        <input class="form-control modal_input" type="text" id="modal_input_heure_fin_pm" value="<%= Utilitaire.champNull(listeRecup[i].getHeure_fin_pm())%>" name="heure_fin_pm">
                                    </td>
                                    <td><input class="form-control" type="text" id="modal_input_total_heure" value="<%= listeRecup[i].getHeure()%>" name="heure" readonly /></td>
                                    <td><input class="form-control" type="text" id="modal_input_remarque" value="<%= Utilitaire.champNull(listeRecup[i].getRemarque())%>" name="remarque" /></td>
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
    <% }%>
</div>
<script type="text/javascript">
    function diffHeure(date, heure_debut, heure_fin)
    {
        if ((date === undefined || date.length == 0) || (heure_debut === undefined || heure_debut.length == 0) || (heure_fin === undefined || heure_fin.length == 0))
        {
            return 0;
        } else {
            var splitDate = date.split("/");
            var splitHeureDebut = heure_debut.split(":");
            var splitHeureFin = heure_fin.split(":");

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
    function calculerHeureRecup(idDebutMatin, idFinMatin, idDebutAprem, idFinAprem, idDate)
    {
        var listeValeurArguments = [];
        for (var i = 0; i < 4; i++) {
            listeValeurArguments[arguments[i]] = $("#" + arguments[i]).val();
        }
        var date = $("#" + idDate).val();
        var totalHeureMatin = diffHeure(date, listeValeurArguments[idDebutMatin], listeValeurArguments[idFinMatin]);
        var totalHeureAprem = diffHeure(date, listeValeurArguments[idDebutAprem], listeValeurArguments[idFinAprem]);
        return totalHeureMatin + totalHeureAprem;
    }
    function afficherTotalHeureRecup(prefixe)
    {
        var totalHeureRecup = calculerHeureRecup(prefixe + "_heure_deb_am", prefixe + "_heure_fin_am", prefixe + "_heure_deb_pm", prefixe + "_heure_fin_pm", prefixe + "_daty_emploi");
        $("#" + prefixe + "_total_heure").val(totalHeureRecup);
    }
//    $('body').delegate('.heure_minute_normal_input', 'blur', function () {
//	afficherTotalHeureRecup("heure_minute_normal_input");
//	return false;
//    });
//    $('body').delegate('.modal_input', 'blur', function () {
//	afficherTotalHeureRecup("modal_input");
//	return false;
//    });
</script>
