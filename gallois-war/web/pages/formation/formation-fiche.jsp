<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.formation.*" %>
<%!
    FormFormation formation;
    UserEJB u;
%>
<%
    u = (UserEJB) session.getAttribute("u");
    formation = new FormFormation();
    formation.setNomTable("FORM_FORMATION_LIBELLE5");
    String lien = (String) session.getValue("lien");
    String[] libelleFormationFiche = {"Id", "Domaine", "Service", "Formateur",  "Cat&eacute;gorie", "Type", "Offre de formation", "Date d&eacute;but", "Date fin", "Lieu", "Objet", "Niveau Requis", "Type Coût", "Coût Offre", "Etablissement", "Exercice", "Utilisateur", "Heure début", "Heure fin", "Durée (H) début", " Durée (H) fin", "Etat", "Intitule", "Effectif", "Type Demande", "Catégorie Professionnel", "Statut Professionnel", "Direction" /*,"Fonction" */};
    PageConsulte pc = new PageConsulte(formation, request, (user.UserEJB) session.getValue("u"));
    pc.setLibAffichage(libelleFormationFiche);
    pc.setTitre("Fiche Formation");
    FormFormation temp = (FormFormation) pc.getBase();
    pc.getChampByName("id_of").setLien(new PageConsulteLien((String) session.getValue("lien"), "but=formation/offre-fiche.jsp&" + "id=" + temp.getId_of()));
    String demandeId = "AND ID_FORMATION = '" + request.getParameter("id") + "'";
    FormPartInfoComplet[] participantdemandes1 = (FormPartInfoComplet[]) u.getData(new FormPartInfoComplet(), null, null, null, " AND FORM_FORMATION='"+request.getParameter("id")+"'");
    FormParticipantDemande fpd =new FormParticipantDemande();
    fpd.setNomTable("FORM_PARTICIPANT");
    FormParticipantDemande[] fpds = (FormParticipantDemande[]) u.getData(fpd, null, null, null, demandeId);
    pc.getChampByName("objett").setVisible(false);
    FormAbsence[] absences = (FormAbsence[]) u.getData(new FormAbsence(), null, null, null, " AND ID_FORMATION = '"+request.getParameter("id")+"'");
    /*POUR ACTIVER L'ATTACHEMENT DE FICHIER GENERIQUE*/
    pc.setCanUploadFile(true);
    pc.setFichier_table_cible("FORM_FORMATION_PJ");
    pc.setFichier_table_procedure("getSeqFormFormationPj");
    /*--END--*/
    FormFormation data = (FormFormation) pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=formation/formation-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
			    out.println(pc.getHtml());
                            String ficheredirect = "&redirect=formation/formation-fiche.jsp";
                            String butmission = "?but=mission/mission-attachement.jsp";
                            String motifMS = "&motifMS=" + data.getIntitule();
                            String idObj = "&idobj=" + request.getParameter("id");
                        %>
                    </div>
                    <div class="box-footer">
                        <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=formation/formation-liste.jsp&classe=mg.cnaps.formation.FormFormation" style="margin-right: 10px">Supprimer</a>
                        <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/formation-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                        <a  href="<%=(String) session.getValue("lien")%>?but=formation/apresNoteMultiple.jsp&acte=finFormation&bute=formation/formation-fiche.jsp&id=<%=request.getParameter("id")%>" class="btn btn-warning pull-right"  style="margin-right: 10px" >Fin Formation</a>
                        <a class="btn btn-default pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/participantchoix.jsp&retour=true&premier=false&valeur=" + request.getParameter("id")%> " style="margin-right: 10px" >Participant</a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=formation/formation-fiche.jsp&classe=mg.cnaps.formation.FormFormation" style="margin-right: 10px">Accorder</a>
                        <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=cloturer&bute=formation/formation-fiche.jsp&classe=mg.cnaps.formation.FormFormation" style="margin-right: 10px">Viser</a>
                        <!--<a class="btn btn-success pull-right" href="<%=lien + butmission + idObj + ficheredirect + motifMS %>" style="margin-right: 10px">Attachement mission</a>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%=pc.getBasPage()%>
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">Liste des participants</h1>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Matricule</th>
                                    <th>Nom et Prénoms</th>
                                    <th>Service</th>
                                    <th>Fonction</th>
                                    <th>Note</th>
                                    <th>Nombre absences</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
				    for (int i = 0; i < participantdemandes1.length; i++) {
                                        String[] attribut2 = {"log_personnel"};
                                        String[] values2 = {participantdemandes1[i].getId_personnel()};
                                        FormAbsence[] absenceAg = (FormAbsence[]) AdminGen.findAvecOrder(absences, attribut2, values2);
                                %>
				<tr>
				    <td><a href="<%=(String) session.getValue("lien") + "?but=employe/personnel-fiche.jsp&id=" + participantdemandes1[i].getId_personnel()%>" style="margin-right: 10px"><%=participantdemandes1[i].getId_personnel()%></a></td>
                                    <td><%=Utilitaire.champNull(participantdemandes1[i].getMatricule())%></td>
                                    <td><%=Utilitaire.champNull(participantdemandes1[i].getLog_personnel())%></td>
                                    <td><%=Utilitaire.champNull(participantdemandes1[i].getLog_service())%></td>
                                    <td><%=Utilitaire.champNull(participantdemandes1[i].getPaie_fonction())%></td>
                                    <td><%=participantdemandes1[i].getEtatNote()%></td>
                                    <td><a href="<%=(String) session.getValue("lien") + "?but=formation/formation-absence.jsp&idpersonnel=" + participantdemandes1[i].getId_personnel()%>&idformation=<%=request.getParameter("id")%>"><% if(absenceAg==null) out.print("0"); else out.print(absenceAg.length);%></a></td>
				    <% //if(temp.getType_demandeur()!=null){
                                        //if (temp.getType_demandeur().compareTo(Constante.idBesoinFormation) != 0) {%>
<!--                                            <td><a href="?but=formation/emploidutemp-saisie.jsp&idpers=<%=participantdemandes1[i].getId_personnel()%>&id=<%=request.getParameter("id")%>"><i class="fa fa-calendar" title="Emploi du temp de formation"></i></a></td>-->
                                        <% //}%>
                                    <%// }%>
<!--                                    <td><a href="?but=formation/reccuperation-saisie.jsp&idpers=<%=participantdemandes1[i].getId_personnel()%>&id=<%=request.getParameter("id")%>"><i class="fa fa-calendar" title="Planning de réccuperation"></i></a></td>-->
                                    <td><a href="?but=formation/absence-saisie.jsp&idpers=<%=participantdemandes1[i].getId_personnel()%>&idformation=<%=request.getParameter("id")%>"><i class="fa fa-pencil" title="Saisir Absence"></i></a></td>
                                </tr>
				<% } %>
                            </tbody>
                        </table>
			
                    </div>
                    <div class="box-footer">
                        <% if(temp.getType_demandeur()!=null){
                                //if (!temp.getType_demandeur().equalsIgnoreCase("Besoin En Formation")) {%>
                                    <!--<a onclick="etatAttestationPriseCharge()" class="btn btn-primary pull-right">Attestation de Prise En Charge</a>&nbsp;&nbsp;&nbsp;&nbsp;-->
                                <%// }
                                //else{ %>
                                <a class="btn btn-success pull-right"  onclick="etatConvocation()" style="margin-right: 10px">G&eacute;n&eacute;rer convocation</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <%
                                //}
                                %>
                        <% } %>
                        <a class="btn btn-default pull-right"  style="margin-right: 10px" href="<%=(String) session.getValue("lien") + "?but=formation/saisie-note-formation.jsp&premier=false&valeur=" + request.getParameter("id")%>">Saisir les notes</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="<%=(String) session.getValue("lien")%>/../../EtatGRHServlet?action=attestationFormation&id=<%=request.getParameter("id")%>" class="btn btn-primary pull-right">Attestation Fin Formation</a>&nbsp;&nbsp;
                        <a href="<%=(String) session.getValue("lien")%>/../../EtatGRHServlet?action=exportListeParticipant&id=<%=request.getParameter("id")%>" class="btn btn-success pull-right">Export Excel Participant</a>&nbsp;&nbsp;
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
	UnionIntraTable un = new UnionIntraTable();
	un.setNomTable("FORM_FORMATION_DEMANDE");
	un.setId1(request.getParameter("id"));
	UnionIntraTable[] lun = (UnionIntraTable[]) u.getData(un, null, null,null, "");
	if (lun.length > 0) {
    %>
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">Demandes associés</h1>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Domaine</th>
                                    <th>Service</th>
                                    <th>Categorie</th>
                                    <th>Type</th>
                                    <th>Statut</th>
                                    <th>Date debut</th>
                                    <th>Date fin</th>
                                    <th>Matiere</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
				    FormDemande fd = new FormDemande();
				    fd.setNomTable("FORM_DEMANDE_LIBELLE7");
				    for (int i = 0; i < lun.length; i++) {
					fd.setId(lun[i].getId2());
					FormDemande[] lfd = (FormDemande[]) u.getData(fd, null, null,null, "");
					for (int j = 0; j < lfd.length; j++) {%>
				<tr>
				    <td><a href="<%=(String) session.getValue("lien") + "?but=formation/demande-fiche.jsp&id=" + lfd[j].getId()%>" style="margin-right: 10px"><%=lfd[j].getId()%></a></td>
                                    <td><%=Utilitaire.champNull(lfd[j].getForm_domaine())%></td>
				    <td><%=Utilitaire.champNull(lfd[j].getLog_service())%></td>
				    <td><%=Utilitaire.champNull(lfd[j].getCategorie_pro())%></td>
				    <td><%=Utilitaire.champNull(lfd[j].getId_type())%></td>
				    <td><%=Utilitaire.champNull(lfd[j].getStatut_pro())%></td>
				    <td><%=Utilitaire.formatterDaty(lfd[j].getDate_debut())%></td>
				    <td><%=Utilitaire.formatterDaty(lfd[j].getDate_fin())%></td>
				    <td><%=Utilitaire.champNull(lfd[j].getIdmatiere())%></td>
				</tr>
                                        <% }
				    } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="box-footer">
                        <a href="<%=(String) session.getValue("lien")%>/../../EtatGRHServlet?action=exportDemandeFormation&id=<%=request.getParameter("id")%>" class="btn btn-success pull-right">Export Excel Demande</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% }%>
    <%
	if (data.getId_of()!=null && !data.getId_of().equals("")) {
            FormOffreFormation[] offreFormation = (FormOffreFormation[]) CGenUtil.rechercher(new FormOffreFormation(), null, null, null, " AND ID='"+data.getId_of()+"'");
            if(offreFormation.length>0){
    %>
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">Offre associé</h1>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Formateur</th>
                                    <th>Etablissement</th>
                                    <th>Categorie</th>
                                    <th>Type</th>
                                    <th>Service</th>
                                    <th>Date debut</th>
                                    <th>Date fin</th>
                                    <th>Lieu</th>
                                </tr>
                            </thead>
                            <tbody>
				<tr>
				    <td><a href="<%=(String) session.getValue("lien") + "?but=formation/offre-fiche.jsp&id=" + offreFormation[0].getId()%>" style="margin-right: 10px"><%=offreFormation[0].getId()%></a></td>
                                    <td><%=Utilitaire.champNull(offreFormation[0].getId_formateur())%></td>
				    <td><%=Utilitaire.champNull(offreFormation[0].getEtablissement())%></td>
				    <td><%=Utilitaire.champNull(offreFormation[0].getForm_categorie())%></td>
				    <td><%=Utilitaire.champNull(offreFormation[0].getId_type())%></td>
				    <td><%=Utilitaire.champNull(offreFormation[0].getLog_service())%></td>
				    <td><%=Utilitaire.formatterDaty(offreFormation[0].getDate_debut())%></td>
				    <td><%=Utilitaire.formatterDaty(offreFormation[0].getDate_fin())%></td>
				    <td><%=Utilitaire.champNull(offreFormation[0].getLieu())%></td>
				</tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% }}%>
</div>
<script>
    function etatAttestationPriseCharge(){
        <%
            if(data.getEtat()>=ConstanteEtat.getEtatValider()){
        %>
              window.location="<%=(String) session.getValue("lien")%>/../../EtatGRHServlet?action=attestationPriseCharge&id=<%=request.getParameter("id")%>";  
        <%
            }
            else{ %>
                alert("Accord de la formation obligatoire avant impression de l'attestation de prise en charge");
            <%
            }
        %>
    }
    function etatConvocation(){
        <%
            if(data.getEtat()>=ConstanteEtat.getEtatValider()){
        %>
              window.location="<%=(String) session.getValue("lien")%>?but=formation/convocation.jsp?id=<%=temp.getId()%>";  
        <%
            }
            else{ %>
                alert("Accord de la formation obligatoire avant impression de la convocation");
            <%
            }
        %>
    }
</script>