<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.formation.*" %>
<%!
    FormDemande demande;
    UserEJB u;
%>
<%
    u = (UserEJB) session.getAttribute("u");
    demande = new FormDemande();
    demande.setNomTable("FORM_DEMANDE_LIB_TOUS");
    PageConsulte pc = new PageConsulte(demande, request, (user.UserEJB) session.getValue("u"));
    pc.setTitre("Fiche de Demande de Formation");
    pc.getChampByName("type_demandeur").setLibelle("Type demande");
    pc.getChampByName("id_type").setLibelle("Type de formation");
    pc.getChampByName("id_etablissement").setLibelle("Etablissement");
    pc.getChampByName("Form_domaine").setLibelle("Domaine");
    pc.getChampByName("idmatiere").setLibelle("Mati&egrave;re");
    pc.getChampByName("date_fin").setLibelle("Date fin");
    pc.getChampByName("date_debut").setLibelle("Date d&eacute;but");
    pc.getChampByName("Form_domaine").setLibelle("Domaine");
    pc.getChampByName("heure_debut").setLibelle("Heure d&eacute;but de la formation");
    pc.getChampByName("heure_fin").setLibelle("Heure fin de la formation");
    pc.getChampByName("annee_scolaire").setLibelle("Ann&eacute;e");
    pc.getChampByName("niveau_requis").setLibelle("Niveau requis");
    pc.getChampByName("log_service").setLibelle("Service");
    pc.getChampByName("id_type_cout").setLibelle("Type co&ucirc;t");
    pc.getChampByName("cout_offre").setLibelle("Co&ucirc;t (Ariary)");
    pc.getChampByName("categorie_pro").setLibelle("Cat&eacute;gorie");
    pc.getChampByName("id_direction").setLibelle("Direction");
    pc.getChampByName("statut_pro").setLibelle("Statut");
    pc.getChampByName("objett").setVisible(false);
    pc.getChampByName("duree_hdebut").setVisible(false);
    pc.getChampByName("duree_hfin").setVisible(false);
    pc.getChampByName("id_categorie").setVisible(false);
    pc.getChampByName("iduser").setVisible(false);
    pc.getChampByName("id_personnel").setVisible(false);
    
    String demandeId = "AND ID_FORMATION = '" + request.getParameter("id") + "'";
    FormParticipantComplet[] participant = (FormParticipantComplet[]) u.getData(new FormParticipantComplet(), null, null, null, demandeId);
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=formation/demande-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
			    out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/demande-modif.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=formation/demande-liste.jsp&classe=mg.cnaps.formation.FormDemande" style="margin-right: 10px">Supprimer</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + request.getParameter("id")%>&acte=valider&bute=formation/demande-fiche.jsp&classe=mg.cnaps.formation.FormDemande" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/formation-saisie.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Cr&eacute;er Formation</a>
			    <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=formation/demandeparticipantchoix.jsp&retour=true&premier=false&valeur=" + request.getParameter("id")%> " style="margin-right: 10px" >Participants</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%out.println(pc.getBasPage());%>
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
                                    <th>Personnel</th>
                                    <th>Matricule</th>
                                    <th>Service</th>
                                    <th>Direction</th>
                                    <th>Cat&eacute;gorie</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
				    for (int i = 0; i < participant.length; i++) { 
                                %>
				<tr>
				    <td><a href="<%=(String) session.getValue("lien") + "?but=employe/personnel-fiche.jsp&id=" + participant[0].getIdpersonnel()%>" style="margin-right: 10px"><%=participant[0].getIdpersonnel()%></a></td>
                                    <td><%=Utilitaire.champNull(participant[i].getPersonnel())%></td>
				    <td><%=Utilitaire.champNull(participant[i].getMatricule())%></td>
                                    <td><%=Utilitaire.champNull(participant[i].getService())%></td>
                                    <td><%=Utilitaire.champNull(participant[i].getDirection())%></td>
                                    <td><%=Utilitaire.champNull(participant[i].getCategorie())%></td>
				</tr>
				<% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
