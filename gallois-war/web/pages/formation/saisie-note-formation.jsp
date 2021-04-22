<%-- 
    Document   : saisie-note-formation
    Created on : 13 oct. 2015, 20:18:37
    Author     : Tafitasoa
--%>
<%@page import="mg.cnaps.formation.FormFormateur"%>
<%@page import="mg.cnaps.formation.FormFormation"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.cnaps.formation.FormParticipantView"%>
<%
    String idForm = request.getParameter("valeur");

    FormFormation[] f = (FormFormation[]) CGenUtil.rechercher(new FormFormation(), null, null, " and id = '" + idForm + "'");

    //liste APJ
    PageRecherche pr = null;
    FormParticipantView[] participant = null;
    FormParticipantView p = new FormParticipantView();

    String listeCrt[] = {"id", "id_formation", "remarque", "note", "nom", "prenom"};
    String listeInt[] = {"cout", "note"};
    String libEntete[] = {"id", "id_formation", "remarque", "note", "cout", "nom", "prenom"};
    pr = new PageRecherche(p, request, listeCrt, listeInt, 3, libEntete, 7);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("formation/saisie-note-formation.jsp");
    pr.setAWhere(" AND ID_FORMATION = '" + idForm + "'");

    String[] colSomme = null;
    pr.setNpp(100);
    pr.creerObjetPage(libEntete, colSomme);

    participant = (FormParticipantView[]) pr.getRs().getResultat();
//    System.out.println("taille note : "+participant.length);
%>
<div class="content-wrapper" style="min-height: 946px;">
    <section class="content-header">
        <h1>Notes des participants de la formation <a href="?but=formation/formation-fiche.jsp&id=<%=idForm%>"><%=idForm%></a></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/apresNoteMultiple.jsp" method="post">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Liste des participants</h3>
                        </div>
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-hover">
                                <thead>
                                <th style='background-color:#bed1dd'>ID</th>
                                <th style='background-color:#bed1dd'>Nom</th>
                                <th style='background-color:#bed1dd'>Pr&eacute;noms</th>
                                <th style='background-color:#bed1dd'>Remarque</th>
                                <th style='background-color:#bed1dd'>Note /20</th>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 0;
                                        for (FormParticipantView element : participant) {
                                            String valNote = "";
                                            if (element.getNote() != -1) {
                                                valNote = element.getNote() + "";
                                            }
                                    %>
                                    <tr>
                                        <td><%=element.getLog_personnel()%></td>
                                        <td><%=element.getNom()%></td>
                                        <td><%=element.getPrenom()%></td>
                                        <td><%=Utilitaire.champNull(element.getRemarque())%></td>
                                        <td><input name="note_<%=i%>" class="form-control" style="width: 100px" value="<%=Utilitaire.formaterAr(valNote)%>" type="text"></td>
                                <input name="log_pers_<%=i%>" type="hidden" value="<%=element.getLog_personnel()%>">
                                </tr>
                                <%
                                        i++;
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <%
                FormFormation ff = new FormFormation();
                ff.setId(idForm);
                FormFormation[] lff = (FormFormation[]) CGenUtil.rechercher(ff, null, null, "");

            %>
            </br></br>
            <!--note formateur-->
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Formateur</h3>
                        </div>
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-hover">
                                <thead>
                                    <!--<th style='background-color:#bed1dd'>ID</th>-->
                                <th style='background-color:#bed1dd'>Nom</th>
                                <th style='background-color:#bed1dd'>Etablissement</th>
                                <th style='background-color:#bed1dd'>Description</th>
                                <th style='background-color:#bed1dd'>Note /20</th>
                                </thead>
                                <tbody>
                                    <% 
                                        FormFormateur fo = new FormFormateur();
                                        fo.setId(lff[0].getForm_formateur());
                                        fo.setNomTable("FORM_FORMATEUR_LIBELLE_2");
                                        FormFormateur[] format = (FormFormateur[]) CGenUtil.rechercher(fo, null, null, "");
                                    %>
                                    <tr>
                                        <td><%=format[0].getNom()%></td>
                                        <td><%=format[0].getId_etablissement()%></td>
                                        <td><%=format[0].getDesce()%></td>
                                        <td><input name="noteformateur" class="form-control" style="width: 100px" value="<%=Utilitaire.formaterAr(lff[0].getObjett())%>" type="text"></td>
                                <input name="idform" type="hidden" value="<%=idForm%>">
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">

                </div>
                <div class="col-md-6" align="right">
                    <button class="btn btn-primary" type="submit" style="margin-bottom: 10px">Valider</button>
                </div>
            </div>
            <input name="acte" type="hidden" value="update">
            <input name="idForm" type="hidden" value="<%=idForm%>">
            <input name="nbr" type="hidden" value="<%=participant.length%>">
            <input name="bute" type="hidden" id="bute" value="formation/formation-fiche.jsp&id=<%=idForm%>">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.formation.FormParticipantDemande">
            <input name="nomtable" type="hidden" id="nomtable" value="FORM_PARTICIPANT">
        </form>
    </section>
</div>
